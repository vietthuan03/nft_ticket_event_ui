// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utility/app_theme.dart';
import '../pages/update_event.dart';

class EventManageCard extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? textLocation;
  final String? imagePath;
  final String? textName;
  final String? textDate;
  final String? textTime;
  final String? textTotAttend;
  final String? textTotEarn; //change all to data if connect to backend

  const EventManageCard({
    super.key,
    required this.onPressed,
    this.textLocation,
    this.imagePath,
    this.textName,
    this.textDate,
    this.textTime,
    this.textTotAttend,
    this.textTotEarn,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
        return InkWell(
          onTap: onPressed,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: theme.colorScheme.onSurface,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          textLocation ?? "Viet Nam",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          imagePath ?? "assets/images/event.jpg",
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              textName ?? "Music Festival 2026",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  textDate ?? "12/12/2025",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.7),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    "|",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ),
                                Text(
                                  textTime ?? "19:00 PM",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              spacing: 8,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: theme.colorScheme.primary,
                                ),
                                Text(
                                  "Total Attendees : ${textTotAttend ?? "0"}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Total Earn: ${textTotEarn ?? "\$0"}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon:
                            Icon(Icons.edit, color: theme.colorScheme.primary),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UpdateEvent()),
                          );
                        },
                      ),
                      IconButton(
                        icon:
                            Icon(Icons.delete, color: theme.colorScheme.error),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: const Text(
                                    'Are you sure you want to delete this document?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // bool deleteSuccess =
                                      // await deleteDocument(widget.document);
                                      // Navigator.of(context).pop();
                                      // if (deleteSuccess) {
                                      //   Navigator.of(context).pushReplacement(
                                      //     MaterialPageRoute(
                                      //       builder: (context) => const HomePage(),
                                      //     ),
                                      //   );
                                      //   ScaffoldMessenger.of(context)
                                      //       .showSnackBar(const SnackBar(
                                      //     content: Text(
                                      //       'Event deleted successfully',
                                      //       style: TextStyle(
                                      //           color: Colors.white,
                                      //           fontWeight: FontWeight.bold),
                                      //     ),
                                      //     backgroundColor: Colors.green,
                                      //   ));
                                      // } else {
                                      //   ScaffoldMessenger.of(context)
                                      //       .showSnackBar(const SnackBar(
                                      //     content: Text(
                                      //       'Failed to delete Event',
                                      //       style: TextStyle(
                                      //           color: Colors.white,
                                      //           fontWeight: FontWeight.bold),
                                      //     ),
                                      //     backgroundColor: Colors.red,
                                      //   ));
                                      // }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
