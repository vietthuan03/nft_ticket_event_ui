import 'package:flutter/material.dart';
import 'package:nft_ticket_event_ui/data/data_provider.dart';
import 'package:nft_ticket_event_ui/models/event.dart';
import 'package:nft_ticket_event_ui/models/ticket.dart';
import 'package:provider/provider.dart';

import '../../../models/booking_data.dart';
import '../../checkout/checkout_page.dart';

class EventDetailPage extends StatefulWidget {
  final EventModel event;

  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  // Map lưu số lượng vé đã chọn: ticketId -> quantity
  Map<String, int> _selectedTickets = {};
  // Tăng số lượng vé
  void _incrementTicket(TicketModel ticket) {
    if (ticket.sId == null) return;

    final currentQty = _selectedTickets[ticket.sId!] ?? 0;
    final available = (ticket.totalQuantity ?? 0) - (ticket.soldQuantity ?? 0);

    if (currentQty < available) {
      setState(() {
        _selectedTickets[ticket.sId!] = currentQty + 1;
      });
    }final SnackBar snackBar = SnackBar(
      content: const Text('sold out'),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Giảm số lượng vé
  void _decrementTicket(String ticketId) {
    final currentQty = _selectedTickets[ticketId] ?? 0;

    if (currentQty > 0) {
      setState(() {
        if (currentQty == 1) {
          _selectedTickets.remove(ticketId);
        } else {
          _selectedTickets[ticketId] = currentQty - 1;
        }
      });
    }
  }

  // Tính tổng giá
  double _calculateTotalPrice(List<TicketModel> tickets) {
    double total = 0;

    _selectedTickets.forEach((ticketId, quantity) {
      final ticket = tickets.firstWhere(
            (t) => t.sId == ticketId,
        orElse: () => TicketModel(),
      );

      if (ticket.price != null) {
        total += (ticket.price! * quantity);
      }
    });

    return total;
  }

  // Tổng số vé đã chọn
  int _getTotalTickets() {
    return _selectedTickets.values.fold(0, (sum, qty) => sum + qty);
  }

  @override
  void initState() {
    super.initState();
    // Gọi API lấy tickets của event này
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.event.sId != null) {
        context.read<DataProvider>().getTicketsByEvent(widget.event.sId!);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          _buildSliverAppBar(context, theme),

          // Event Details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEventHeader(theme),
                  SizedBox(height: 20),
                  _buildEventInfo(theme),
                  SizedBox(height: 20),
                  _buildDescription(theme),
                  SizedBox(height: 20),
                  _buildTicketsSection(context, theme),
                  SizedBox(height: 80), // Space for bottom button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomSheet(context, theme),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, ThemeData theme) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: widget.event.image != null && widget.event.image!.isNotEmpty
            ? Image.network(
          widget.event.image!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholder(theme);
          },
        )
            : _buildPlaceholder(theme),
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Container(
      color: theme.colorScheme.surface,
      child: Icon(
        Icons.event,
        size: 100,
        color: theme.iconTheme.color?.withValues(alpha: 0.3),
      ),
    );
  }

  Widget _buildEventHeader(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.event.title ?? 'Event Name',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        if (widget.event.status != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getStatusColor(widget.event.status!).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.event.status!.toUpperCase(),
              style: TextStyle(
                color: _getStatusColor(widget.event.status!),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEventInfo(ThemeData theme) {
    return Column(
      children: [
        if (widget.event.startTime != null)
          _buildInfoRow(
            icon: Icons.calendar_today,
            title: 'Date & Time',
            value: () {
              try {
                if (widget.event.startTime is String) {
                  return _formatDateTime(DateTime.parse(widget.event.startTime as String));
                } else if (widget.event.startTime is DateTime) {
                  return _formatDateTime(widget.event.startTime as DateTime);
                }
                return '-';
              } catch (e) {
                print('Error parsing startTime: $e');
                return 'Invalid date';
              }
            }(),
            theme: theme,
          ),
        if (widget.event.startTime != null && widget.event.location != null)
          SizedBox(height: 16),
        if (widget.event.location != null)
          _buildInfoRow(
            icon: Icons.location_on,
            title: 'Location',
            value: widget.event.location!,
            theme: theme,
          ),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    required ThemeData theme,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xff6351ec).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Color(0xff6351ec)),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(ThemeData theme) {
    if (widget.event.description == null || widget.event.description!.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Event',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Text(widget.event.description!, style: theme.textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildTicketsSection(BuildContext context, ThemeData theme) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) {
        // Lọc tickets theo eventId
        final eventTickets = provider.tickets.where((ticket) {
          return ticket.proEventId?.sId == widget.event.sId;
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available Tickets',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${eventTickets.length} types',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Hiển thị loading
            if (provider.isLoading)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              )
            // Hiển thị danh sách tickets
            else if (eventTickets.isNotEmpty)
              ...eventTickets.map((ticket) =>
                  _buildTicketCard(context, ticket, theme)
              ).toList()
            // Không có tickets
            else
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.confirmation_number_outlined,
                      size: 48,
                      color: Colors.grey.withValues(alpha: 0.5),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'No tickets available',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildTicketCard(
      BuildContext context,
      TicketModel ticket,
      ThemeData theme,
      ) {
    final isAvailable = ticket.totalQuantity != null &&
        ticket.soldQuantity != null &&
        ticket.soldQuantity! < ticket.totalQuantity!;

    final selectedQty = _selectedTickets[ticket.sId] ?? 0;
    final available = (ticket.totalQuantity ?? 0) - (ticket.soldQuantity ?? 0);

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selectedQty > 0
              ? Color(0xff6351ec)
              : (isAvailable
              ? Color(0xff6351ec).withValues(alpha: 0.3)
              : Colors.grey.withValues(alpha: 0.3)),
          width: selectedQty > 0 ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.name ?? 'Ticket',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Available: ${available} / ${ticket.totalQuantity ?? 0}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isAvailable ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (ticket.price != null)
                Text(
                  '\$${ticket.price!.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Color(0xff6351ec),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),

          if (!isAvailable)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'SOLD OUT',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Counter buttons
          if (isAvailable)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (selectedQty > 0)
                    Row(
                      children: [
                        Icon(
                          Icons.confirmation_number,
                          color: Color(0xff6351ec),
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Selected: $selectedQty',
                          style: TextStyle(
                            color: Color(0xff6351ec),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.orange,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Selling fast!',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                  Row(
                    children: [
                      // Nút giảm
                      InkWell(
                        onTap: selectedQty > 0
                            ? () => _decrementTicket(ticket.sId!)
                            : null,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: selectedQty > 0
                                ? Color(0xff6351ec).withValues(alpha: 0.1)
                                : Colors.grey.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.remove,
                            size: 18,
                            color: selectedQty > 0
                                ? Color(0xff6351ec)
                                : Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),

                      // Số lượng
                      Container(
                        width: 40,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedQty > 0
                                ? Color(0xff6351ec)
                                : Colors.grey.withValues(alpha: 0.3),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$selectedQty',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: selectedQty > 0
                                ? Color(0xff6351ec)
                                : Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),

                      // Nút tăng
                      InkWell(
                        onTap: () => _incrementTicket(ticket),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Color(0xff6351ec),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context, ThemeData theme) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) {
        final eventTickets = provider.tickets.where((ticket) {
          return ticket.proEventId?.sId == widget.event.sId;
        }).toList();

        final totalPrice = _calculateTotalPrice(eventTickets);
        final totalTickets = _getTotalTickets();
        final hasSelection = totalTickets > 0;

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
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6351ec),
                        ),
                      ),
                      if (hasSelection)
                        Text(
                          '$totalTickets ticket${totalTickets > 1 ? 's' : ''}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: hasSelection
                      ? () {
                    // Chuẩn bị dữ liệu booking
                    final Map<String, BookingTicket> selectedBookingTickets = {};

                    _selectedTickets.forEach((ticketId, quantity) {
                      final ticket = eventTickets.firstWhere(
                            (t) => t.sId == ticketId,
                        orElse: () => TicketModel(),
                      );

                      if (ticket.sId != null) {
                        selectedBookingTickets[ticketId] = BookingTicket(
                          ticket: ticket,
                          quantity: quantity,
                        );
                      }
                    });

                    final bookingData = BookingData(
                      event: widget.event,
                      selectedTickets: selectedBookingTickets,
                      totalPrice: totalPrice,
                      totalQuantity: totalTickets,
                    );

                    // Navigate to checkout
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(
                          bookingData: bookingData,
                        ),
                      ),
                    );
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff6351ec),
                    disabledBackgroundColor: Colors.grey.withValues(alpha: 0.3),
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Book Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: hasSelection ? Colors.white : Colors.grey,
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
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