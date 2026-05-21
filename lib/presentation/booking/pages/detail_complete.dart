import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utility/app_theme.dart';

class DetailComplete extends StatefulWidget {
  const DetailComplete({super.key});

  @override
  State<DetailComplete> createState() => _DetailCompleteState();
}

class _DetailCompleteState extends State<DetailComplete> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Completed Booking Details'),
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: DecoratedBox(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        'assets/images/event.jpg',
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                
                    // Event Title
                    Text(
                      'Event Title',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 8),
                
                    // Event Details
                    _buildInfoRow(
                        Icons.calendar_today, 'Date: June 15, 2025', theme),
                    _buildInfoRow(
                        Icons.access_time, 'Time: 7:00 PM - 10:00 PM', theme),
                    _buildInfoRow(
                        Icons.location_on, 'Location: Event Venue', theme),
                    SizedBox(height: 20),
                
                    // Booking Details
                    _buildSectionTitle('Booking Details', theme),
                    _buildInfoRow(
                        Icons.confirmation_number, 'Booking ID: BOK12345', theme),
                    _buildInfoRow(Icons.person, 'Attendee: John Doe', theme),
                    _buildInfoRow(Icons.event_seat, 'Seats: 2', theme),
                    SizedBox(height: 20),
                
                    // Payment Information
                    _buildSectionTitle('Payment Information', theme),
                    _buildInfoRow(Icons.payment, 'Total Paid: \$50.00', theme),
                    _buildInfoRow(Icons.check_circle, 'Status: Completed', theme),
                    SizedBox(height: 30),
                
                    // Download Ticket Button
                    ElevatedButton(
                      onPressed: () {
                        // Add functionality to download ticket or invoice
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: theme.colorScheme.onPrimary, backgroundColor: theme.colorScheme.primary,
                        padding: EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 24.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child:
                          Text('Download Ticket', style: theme.textTheme.labelLarge),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }

  // Helper Widget for Section Title
  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  // Helper Widget to Create Info Row
  Widget _buildInfoRow(IconData icon, String text, ThemeData theme) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary, size: 22),
        title: Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
        ),
      ),
    );
  }
}
