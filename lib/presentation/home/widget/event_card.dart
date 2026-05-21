import 'package:flutter/material.dart';
import 'package:nft_ticket_event_ui/models/event.dart';

class EventCard extends StatelessWidget {
  final VoidCallback? onPressed;
  final EventModel event;

  const EventCard({super.key, required this.onPressed, required this.event});

  @override
  Widget build(BuildContext context) {
    double widthQ = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: 0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildEventImage(context, widthQ, theme),
                SizedBox(height: 10),
                _buildEventInfo(context, theme),
                SizedBox(height: 5),
                _buildLocationAndTicketInfo(context, theme),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildEventImage(
      BuildContext context,
      double widthQ,
      ThemeData theme,
      ) {
    return Container(
      width: widthQ,
      height: 180,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          // Event Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: event.image != null && event.image!.isNotEmpty
                ? Image.network(
              event.image!,
              width: widthQ,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholderImage(widthQ, theme);
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            )
                : _buildPlaceholderImage(widthQ, theme),
          ),

          // Date Badge
          if (event.startTime != null)
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _formatDate(event.startTime!),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Status Badge
          if (event.status != null && event.status != 'active')
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(event.status!).withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  event.status!.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage(double widthQ, ThemeData theme) {
    return Container(
      width: widthQ,
      height: 180,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        Icons.event,
        size: 60,
        color: theme.iconTheme.color?.withValues(alpha: 0.3),
      ),
    );
  }

  Widget _buildEventInfo(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Event Name
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title ?? "Event Name",
                maxLines: 2,
                style: theme.textTheme.titleLarge?.copyWith(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationAndTicketInfo(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        // Location
        if (event.location != null)
          Row(
            children: [
              Icon(Icons.location_on, color: theme.iconTheme.color, size: 18),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  event.location!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
        return Colors.blue;
      case 'ongoing':
        return Colors.green;
      case 'completed':
        return Colors.grey;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}