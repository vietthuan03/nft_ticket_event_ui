import 'package:flutter/material.dart';
import 'package:nft_ticket_event_ui/features/home/models/ticket_model.dart';
import 'package:nft_ticket_event_ui/features/login/repository/metamask_connector_impl.dart';
import 'package:flutter/material.dart';
import 'package:reown_walletkit/reown_walletkit.dart';


class TicketDialog {

  /// Hiển thị dialog mua vé
  static Future<void> showBuyTicketDialog(
    BuildContext context,
    TicketModel ticket,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Buy Ticket',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('🎟 ${ticket.title}',
                  style: const TextStyle(color: Colors.white)),
              Text('📍 ${ticket.location}',
                  style: const TextStyle(color: Colors.white70)),
              Text('🗓 ${ticket.date}',
                  style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 12),
              const Text(
                '💰 Price: 0.05 ETH',
                style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),

              // Nút Pay with MetaMask
              ElevatedButton.icon(
                icon: Image.asset(
                  'assets/images/metamask_icon.png',
                  height: 22,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  // await _handlePayWithMetaMask(context);
                },
                label: const Text(
                  'Pay with MetaMask',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close', style: TextStyle(color: Colors.white70)),
            ),
          ],
        );
      },
    );
  }

  /// Hiển thị loading dialog và chờ confirm
  static void _showLoadingDialog(BuildContext context, String txHash) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Processing...',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: Colors.amber),
            const SizedBox(height: 16),
            Text(
              'Transaction hash:\n$txHash',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );

    // Giả lập confirm transaction (5s)
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pop(context);
      _showSuccessDialog(context);
    });
  }

  /// Hiển thị thông báo mua thành công
  static void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.green[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          '🎟️ Ticket Purchased!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Your NFT ticket has been sent to your wallet.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/my_tickets');
            },
            child: const Text('View My Tickets',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
