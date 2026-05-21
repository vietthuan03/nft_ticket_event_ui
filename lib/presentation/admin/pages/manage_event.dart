import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utility/app_theme.dart';
import '../widget/event_manage_card.dart';
import 'upload_event.dart';

class ManageEvent extends StatefulWidget {
  const ManageEvent({super.key});

  @override
  State<ManageEvent> createState() => _ManageEventState();
}

class _ManageEventState extends State<ManageEvent> {
  final List<Map<String, dynamic>> events = [
    {
      "imagePath": "assets/images/event.jpg",
      "textName": "Music Festival 2026",
      "textDate": "12/12/2025",
      "textTime": "12:00 PM",
      'textTotAttend': '10',
      "textTotEarn": "\$0",
    }
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Manage Event'),
            centerTitle: true,
            //icon scan qr code for scan event in right side
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onLongPress: () {
                    // Menampilkan tooltip saat long press
                    final SnackBar snackBar = SnackBar(
                      content: const Text('Scan QR Attendance'),
                      duration: const Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Tooltip(
                    message: 'Scan QR Attendance',
                    child: IconButton(
                      onPressed: () {
                        // Implementasi fungsi scan QR
                      },
                      icon: const Icon(Icons.qr_code_scanner),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.secondary,
                  theme.colorScheme.surface,
                  theme.scaffoldBackgroundColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: events.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 20.0),
              itemBuilder: (context, index) => EventManageCard(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const UploadEvent();
                  }));
                },
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const UploadEvent();
              }));
            },
            child: const Icon(Icons.add),
          ),
        );
  }
}
