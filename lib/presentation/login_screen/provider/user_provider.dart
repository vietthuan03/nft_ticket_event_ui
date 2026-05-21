import 'dart:convert';
import 'dart:developer';
import 'package:nft_ticket_event_ui/data/data_provider.dart';
import 'package:nft_ticket_event_ui/models/api_response.dart';
import 'package:nft_ticket_event_ui/utility/snack_bar_helper.dart';
import '../../../models/user.dart';
import '../pages/login_screen.dart';
import '../../../services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../utility/constants.dart';

class UserProvider extends ChangeNotifier {
  final HttpService service = HttpService();
  final DataProvider _dataProvider;
  final GetStorage box = GetStorage();

  UserProvider(this._dataProvider);

  /* ===================== REGISTER ===================== */

  Future<String?> register({
    required String name,
    required String email,
    required String password,
    String role = 'customer',
  }) async {
    try {
      final response = await service.addItem(
        endpointUrl: 'users/register',
        itemData: {
          'name': name.trim(),
          'email': email.toLowerCase().trim(),
          'password': password,
          'role': role,
        },
      );

      if (!response.isOk) {
        return response.body?['message'] ?? response.statusText;
      }

      final apiResponse = ApiResponse.fromJson(response.body, null);

      if (apiResponse.success == true) {
        SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        return null;
      }
      return apiResponse.message;
    } catch (e) {
      return e.toString();
    }
  }

  /* ===================== LOGIN ===================== */

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await service.addItem(
        endpointUrl: 'users/login',
        itemData: {'email': email.toLowerCase().trim(), 'password': password},
      );
      debugPrint("response + $response" );
      if (!response.isOk) {
        return response.body?['message'] ?? response.statusText;
      }

      if (response.body['success'] == true) {
        final String? token = response.body['token'];

        if (token == null || token.isEmpty) {
          return 'Token not found';
        }

        await box.write(ACCESS_TOKEN_BOX, token);
        log('Saved token: $token');

        SnackBarHelper.showSuccessSnackBar(response.body['message']);
        notifyListeners();
        return null;
      }

      return response.body['message'];
    } catch (e) {
      return e.toString();
    }
  }

  /* ===================== AUTH STATE ===================== */

  String? get token => box.read<String>(ACCESS_TOKEN_BOX);

  bool get isLoggedIn {
    final t = token;
    return t != null && t.isNotEmpty;
  }

  logOutUser() {
    box.remove(ACCESS_TOKEN_BOX);
    box.remove(USER_INFO_BOX);
    notifyListeners();
    Get.offAll(const LoginScreen());
  }
}
