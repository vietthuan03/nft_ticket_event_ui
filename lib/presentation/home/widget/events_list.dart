import 'package:flutter/material.dart';
import 'package:nft_ticket_event_ui/models/event.dart';
import 'package:nft_ticket_event_ui/models/ticket.dart';
import 'package:nft_ticket_event_ui/presentation/home/pages/event_detail_page.dart';
import 'package:nft_ticket_event_ui/presentation/home/widget/event_card.dart';

class EventsList extends StatelessWidget {
  final List<EventModel> events;
  final List<TicketModel> tickets;
  final VoidCallback? onSeeAllPressed;
  final Function(EventModel)? onEventPressed;
  final bool isLoading;
  final String? errorMessage;

  const EventsList({
    super.key,
    required this.events,
    this.onSeeAllPressed,
    this.onEventPressed,
    this.isLoading = false,
    this.errorMessage, 
    required this.tickets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        const SizedBox(height: 8),
        _buildEventsList(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Upcoming Events',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: onSeeAllPressed,
          child: Text(
            'See All',
            style: TextStyle(
              color: Color(0xff6351ec),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventsList(BuildContext context) {
    if (isLoading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.red),
              SizedBox(height: 16),
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (events.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('No events found'),
        ),
      );
    }

    return ListView.builder(
      itemCount: events.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final event = events[index];
        return EventCard(
          // Pass event data to EventCard if it supports it
          // Otherwise, you'll need to modify EventCard to accept parameters
          onPressed: () {
            if (onEventPressed != null) {
              onEventPressed!(event);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailPage(event: event),
                ),
              );
            }
          }, event: event,
        );
      },
    );
  }
}

