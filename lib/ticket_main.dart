import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? tokenId;
  String? txHash;

  Future<void> buyTicket() async {
    final response = await http.post(
      Uri.parse(
        "http://192.168.1.13:3000/api/buy",
      ), // thay bằng IP máy bạn hoặc link Railway
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"eventId": 2, "buyerName": "Nguyễn Văn A"}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        tokenId = data['tokenId'].toString();
        txHash = data['txHash'];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Mua vé thành công! Token ID: $tokenId")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Demo Bán Vé NFT - Đồ Án 2025")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: TextStyle(fontSize: 24),
              ),
              onPressed: buyTicket,
              child: Text("MUA VÉ CONCERT (500.000đ)"),
            ),
            SizedBox(height: 40),
            if (tokenId != null) ...[
              Text("Vé của bạn đã được mint!", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              QrImageView(data: tokenId!, size: 250),
              Text(
                "Token ID: $tokenId",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SelectableText("Tx: $txHash"),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ScannerPage()),
                ),
                child: Text("Mở Scanner Check-in"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ScannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quét QR Check-in")),
      body: MobileScanner(
        onDetect: (barcode) {
          final String? code = barcode.barcodes.first.rawValue;
          if (code != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text("VÉ HỢP LỆ! Token ID: $code"),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
      ),
    );
  }
}
