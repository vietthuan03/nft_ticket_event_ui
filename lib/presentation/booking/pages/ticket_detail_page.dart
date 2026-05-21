import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:nft_ticket_event_ui/models/booked_ticket.dart';

class TicketDetailPage extends StatelessWidget {
  final BookedTicket bookedTicket;

  const TicketDetailPage({super.key, required this.bookedTicket});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final event = bookedTicket.event;
    final ticket = bookedTicket.ticket;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Event Image Header
            _buildEventHeader(theme),

            SizedBox(height: 20),

            // QR Code Section - QUAN TRỌNG
            _buildQRCodeSection(theme),

            SizedBox(height: 20),

            // Ticket Info
            _buildTicketInfo(theme),

            SizedBox(height: 20),

            // Event Details
            _buildEventDetails(theme),

            SizedBox(height: 20),

            // NFT Blockchain Info
            _buildBlockchainInfo(theme),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildEventHeader(ThemeData theme) {
    return Container(
      height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          // Background Image
          bookedTicket.event.image != null &&
              bookedTicket.event.image!.isNotEmpty
              ? Image.network(
            bookedTicket.event.image!,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: theme.colorScheme.surface,
                child: Icon(
                  Icons.event,
                  size: 80,
                  color: Colors.grey.withValues(alpha: 0.5),
                ),
              );
            },
          )
              : Container(
            color: theme.colorScheme.surface,
            child: Icon(
              Icons.event,
              size: 80,
              color: Colors.grey.withValues(alpha: 0.5),
            ),
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),

          // Event Title
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Text(
              bookedTicket.event.title ?? 'Event',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRCodeSection(ThemeData theme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Status Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: bookedTicket.isOngoing
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  bookedTicket.isOngoing
                      ? Icons.check_circle
                      : Icons.verified,
                  color: bookedTicket.isOngoing
                      ? Colors.green
                      : Colors.grey,
                  size: 16,
                ),
                SizedBox(width: 8),
                Text(
                  bookedTicket.status.toUpperCase(),
                  style: TextStyle(
                    color: bookedTicket.isOngoing
                        ? Colors.green
                        : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // QR Code - QUAN TRỌNG
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff6351ec),
                width: 3,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: QrImageView(
              data: bookedTicket.qrData,
              version: QrVersions.auto,
              size: 250.0,
              backgroundColor: Colors.white,
              errorCorrectionLevel: QrErrorCorrectLevel.H,
            ),
          ),

          SizedBox(height: 16),

          Text(
            'Scan this QR code at the event entrance',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 8),

          // Token ID
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Token: ${bookedTicket.tokenId}',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketInfo(ThemeData theme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ticket Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),

          _buildInfoRow(
            icon: Icons.confirmation_number,
            label: 'Ticket Type',
            value: bookedTicket.ticket.name ?? '-',
            theme: theme,
          ),
          Divider(height: 24),

          _buildInfoRow(
            icon: Icons.attach_money,
            label: 'Price',
            value: '\$${bookedTicket.ticket.price?.toStringAsFixed(2) ?? '0.00'}',
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetails(ThemeData theme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Event Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),

          if (bookedTicket.event.startTime != null)
            _buildInfoRow(
              icon: Icons.calendar_today,
              label: 'Date & Time',
              value: _formatDateTime(bookedTicket.event.startTime),
              theme: theme,
            ),

          if (bookedTicket.event.startTime != null &&
              bookedTicket.event.location != null)
            Divider(height: 24),

          if (bookedTicket.event.location != null)
            _buildInfoRow(
              icon: Icons.location_on,
              label: 'Location',
              value: bookedTicket.event.location!,
              theme: theme,
            ),
        ],
      ),
    );
  }

  Widget _buildBlockchainInfo(ThemeData theme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xff6351ec).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xff6351ec).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.security,
                color: Color(0xff6351ec),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Blockchain Verification',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff6351ec),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          _buildBlockchainRow(
            label: 'Token ID',
            value: bookedTicket.tokenId,
          ),
          SizedBox(height: 12),

          _buildBlockchainRow(
            label: 'Transaction Hash',
            value: bookedTicket.mintTxHash,
          ),
          SizedBox(height: 12),

          _buildBlockchainRow(
            label: 'Minted At',
            value: _formatDateTime(bookedTicket.mintedAt),
          ),

          SizedBox(height: 16),

          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                  size: 18,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'This ticket is secured on the blockchain as an NFT',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xff6351ec).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Color(0xff6351ec), size: 20),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBlockchainRow({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            color: Color(0xff6351ec),
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _formatDateTime(dynamic dateTime) {
    try {
      DateTime dt;
      if (dateTime is String) {
        dt = DateTime.parse(dateTime);
      } else if (dateTime is DateTime) {
        dt = dateTime;
      } else {
        return '-';
      }
      return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'Invalid date';
    }
  }
}