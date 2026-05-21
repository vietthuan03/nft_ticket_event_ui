// pages/checkout_page.dart
import 'package:flutter/material.dart';
import 'package:nft_ticket_event_ui/models/booking_data.dart';
import 'package:provider/provider.dart';

import '../../data/data_provider.dart';
import '../../models/ticket.dart';
import '../booking/pages/my_tickets_page.dart';

class CheckoutPage extends StatefulWidget {
  final BookingData bookingData;

  const CheckoutPage({super.key, required this.bookingData});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool _isProcessing = false;
  String _processingMessage = '';
  double _processingProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildEventSummary(theme),
            Divider(height: 1),
            _buildTicketsList(theme),
            Divider(height: 1),
            _buildPriceSummary(theme),
            SizedBox(height: 100), // Space for bottom button
          ],
        ),
      ),
      bottomSheet: _buildBottomSheet(context, theme),
    );
  }

  Widget _buildEventSummary(ThemeData theme) {
    final event = widget.bookingData.event;

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Event Details',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: event.image != null && event.image!.isNotEmpty
                    ? Image.network(
                  event.image!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildImagePlaceholder(theme);
                  },
                )
                    : _buildImagePlaceholder(theme),
              ),
              SizedBox(width: 16),

              // Event Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title ?? 'Event Name',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),

                    // Date
                    if (event.startTime != null)
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              _formatDateTime(event.startTime),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 4),

                    // Location
                    if (event.location != null)
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.location!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder(ThemeData theme) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.event,
        size: 40,
        color: theme.iconTheme.color?.withValues(alpha: 0.3),
      ),
    );
  }

  Widget _buildTicketsList(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ticket Details',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xff6351ec).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${widget.bookingData.totalQuantity} ticket${widget.bookingData.totalQuantity > 1 ? 's' : ''}',
                  style: TextStyle(
                    color: Color(0xff6351ec),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // List of tickets
          ...widget.bookingData.selectedTickets.entries.map((entry) {
            final bookingTicket = entry.value;
            final ticket = bookingTicket.ticket;
            final quantity = bookingTicket.quantity;

            return Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xff6351ec).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  // Ticket icon
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xff6351ec).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.confirmation_number,
                      color: Color(0xff6351ec),
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 16),

                  // Ticket info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ticket.name ?? 'Ticket',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '\$${ticket.price?.toStringAsFixed(2) ?? '0.00'} × $quantity',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Subtotal
                  Text(
                    '\$${bookingTicket.subtotal.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff6351ec),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPriceSummary(ThemeData theme) {
    final subtotal = widget.bookingData.totalPrice;
    const serviceFee = 0.0; // Có thể tính phí dịch vụ
    final total = subtotal + serviceFee;

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Summary',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),

          // Subtotal
          _buildPriceRow(
            'Subtotal',
            subtotal,
            theme,
          ),
          SizedBox(height: 12),

          // Service fee
          _buildPriceRow(
            'Service Fee',
            serviceFee,
            theme,
          ),
          SizedBox(height: 12),

          Divider(),
          SizedBox(height: 12),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff6351ec),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey,
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheet(BuildContext context, ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Payment terms
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
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Your tickets will be stored as NFTs on the blockchain',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Processing indicator
            if (_isProcessing) ...[
              LinearProgressIndicator(
                value: _processingProgress,
                backgroundColor: Colors.grey.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff6351ec)),
              ),
              SizedBox(height: 12),
              Text(
                _processingMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16),
            ],

            // Payment button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _handlePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff6351ec),
                  disabledBackgroundColor: Colors.grey,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isProcessing
                    ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Proceed to Payment',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePayment() async {
    setState(() {
      _isProcessing = true;
      _processingMessage = 'Preparing payment...';
      _processingProgress = 0.0;
    });

    try {
      final provider = context.read<DataProvider>();

      // Calculate total tickets for progress
      final totalTickets = widget.bookingData.totalQuantity;
      int mintedCount = 0;

      setState(() {
        _processingMessage = 'Minting NFT tickets...';
      });

      // Process booking and mint all tickets
      final mintedNFTs = await provider.processBooking(
        widget.bookingData.selectedTickets,
            (ticketName, current, total) {
          mintedCount++;
          setState(() {
            _processingProgress = mintedCount / totalTickets;
            _processingMessage =
            'Minting $ticketName ($current/$total)...\n'
                'Total progress: $mintedCount/$totalTickets tickets';
          });
        },
      );
      // ✅ DEBUG: Kiểm tra dữ liệu NFT
      print('=== MINTED NFTs ===');
      mintedNFTs.forEach((ticketId, nfts) {
        print('Ticket ID: $ticketId');
        nfts.forEach((nft) {
          print('  Token ID: ${nft.tokenId}');
          print('  TX Hash: ${nft.mintTxHash}');
          print('  Status: ${nft.status}');
          print('  Minted At: ${nft.mintedAt}');
        });
      });
      print('===================');
      // ✅ LƯU TICKETS VÀO PROVIDER
      provider.addBookedTickets(
        mintedNFTs,
        widget.bookingData.selectedTickets,
        widget.bookingData.event,
      );
      print('=== PAYMENT COMPLETE ===');
      print('Total booked tickets: ${provider.bookedTickets.length}');
      print('========================');
      setState(() {
        _isProcessing = false;
      });

      // Show success dialog
      if (mounted) {
        _showSuccessDialog(mintedNFTs);
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });

      // Show error dialog
      if (mounted) {
        _showErrorDialog(e.toString());
      }
    }
  }
  void _showSuccessDialog(Map<String, List<NFT>> mintedNFTs) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 64,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Payment Successful!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              '${widget.bookingData.totalQuantity} NFT ticket${widget.bookingData.totalQuantity > 1 ? 's' : ''} have been minted successfully!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),

            // Show minted NFTs details
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Minted Tickets:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 8),
                  ...mintedNFTs.entries.map((entry) {
                    final ticketId = entry.key;
                    final nfts = entry.value;
                    final ticket = widget.bookingData.selectedTickets[ticketId]?.ticket;

                    return Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text(
                        '${ticket?.name ?? 'Ticket'}: ${nfts.length} NFT${nfts.length > 1 ? 's' : ''}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close checkout
              Navigator.of(context).pop();
              // Navigate to My Tickets
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyTicketsPage(),
                ),
              );// Back to event detail
            },
            child: Text('View My Tickets'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close checkout
              Navigator.of(context).pop(); // Back to event detail
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffa19cc7),
            ),
            child: Text('Done'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red),
            SizedBox(width: 8),
            Text('Payment Failed'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('An error occurred while processing your payment:'),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                error,
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Try Again'),
          ),
        ],
      ),
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