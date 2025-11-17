import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nft_ticket_event_ui/features/login/bloc/metamask_auth_bloc.dart';
import 'package:nft_ticket_event_ui/features/login/widgets/nsalert_dialog.dart';
import 'package:nft_ticket_event_ui/features/login/widgets/other_custom_widgets.dart';
import 'package:nft_ticket_event_ui/features/login/widgets/show_snack_bar.dart';
import 'package:nft_ticket_event_ui/utils/constants/app_constants.dart';
import 'package:nft_ticket_event_ui/utils/constants/assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MetaMaskLoginScreen extends StatefulWidget {
  const MetaMaskLoginScreen({super.key});

  @override
  State<MetaMaskLoginScreen> createState() => _MetaMaskLoginScreenState();
}

class _MetaMaskLoginScreenState extends State<MetaMaskLoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  BuildContext? dialogContext;
  final String signatureFromBackend = "NonStop IO Technologies Pvt Ltd.";
  @override
  Widget build(BuildContext context) {
    return BlocListener<MetaMaskAuthBloc, WalletState>(
      listener: (context, state) async {
        if (state is WalletErrorState) {
          hideDialog(dialogContext);
          ShowSnackBar.buildSnackbar(context, state.message, true);
        } else if (state is WalletReceivedSignatureState) {
          //received signature from metamask success
          hideDialog(dialogContext);
          ShowSnackBar.buildSnackbar(
            context,
            AppConstants.authenticationSuccessful,
          );
          // ✅ Save login state
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool("isLoggedIn", true);

          Future.microtask(() {
            context.go('/reserve');
          });
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Center(
            child: InkWell(
              onTap: () {
                // 1. Show dialog trước
                buildShowDialog(context);
                // 2. Rồi mới bắn event
                BlocProvider.of<MetaMaskAuthBloc>(context).add(
                  MetamaskAuthEvent(signatureFromBackend: signatureFromBackend),
                );
              },
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(Assets.metamaskIcon, height: 60, width: 60),
                      const SizedBox(height: 10),
                      const Text(
                        AppConstants.metamaskLogin,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
      context: _scaffoldKey.currentContext ?? context,
      barrierDismissible: true, //if user should not
      //cancel this dialog then set as false
      builder: (BuildContext dialogContextL) {
        dialogContext = dialogContextL;
        return BlocBuilder<MetaMaskAuthBloc, WalletState>(
          builder: (context, state) {
            return NSAlertDialog(textWidget: getText(state));
          },
        );
      },
    );
  }

  getText(WalletState state) {
    String message = "";
    if (state is WalletInitializedState) {
      //initialized metamask success
      message = state.message;
    } else if (state is WalletAuthorizedState) {
      //received authorized approval success
      message = state.message;
    } else if (state is WalletReceivedSignatureState) {
      //received signature from metamask success
      message = state.message;
    }
    return Text(
      message,
      style: const TextStyle(fontSize: 18, color: Colors.white),
    );
  }
}
