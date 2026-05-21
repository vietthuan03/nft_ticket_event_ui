import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utility/app_theme.dart';

class DetailOngoing extends StatefulWidget {
  const DetailOngoing({super.key});

  @override
  State<DetailOngoing> createState() => _DetailOngoingState();
}

class _DetailOngoingState extends State<DetailOngoing> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Booking Details'),
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
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
                        height: 250,
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
                    SizedBox(height: 12),

                    // Event Date and Time
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: theme.colorScheme.primary,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Date: June 15, 2025',
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: theme.colorScheme.primary,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Time: 7:00 PM',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Event Location
                    Text(
                      'Location',
                      style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: theme.colorScheme.primary,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '123 Event Street, City, Country',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Booking Status
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        'Ongoing',
                        style: TextStyle(
                          color: theme.colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Additional Details
                    Text(
                      'Additional Details',
                      style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin nec magna at ante blandit pharetra.',
                      style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: 30),

                    // Action Button
                    ElevatedButton(
                      onPressed: () {
                        // Add action for the button (e.g., cancel booking)
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: theme.colorScheme.onError,
                        backgroundColor: theme.colorScheme.error,
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Cancel Booking',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onError,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
