import 'package:flutter/material.dart';
import 'package:nft_ticket_event_ui/presentation/booking/pages/ticket_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:nft_ticket_event_ui/data/data_provider.dart';
import 'package:nft_ticket_event_ui/models/booked_ticket.dart';

class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage({super.key});

  @override
  State<MyTicketsPage> createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyTicketsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // ✅ Debug: Log số lượng tickets khi vào trang
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<DataProvider>();
      print('=== MY TICKETS PAGE ===');
      print('Total tickets: ${provider.bookedTickets.length}');
      print('Ongoing: ${provider.ongoingTickets.length}');
      print('Completed: ${provider.completedTickets.length}');
      print('======================');
    });

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Tickets',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Ongoing'),
            Tab(text: 'Completed'),
          ],
          indicatorColor: theme.colorScheme.primary,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurface,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        ),
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
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildTicketsList(isOngoing: true),
            _buildTicketsList(isOngoing: false),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketsList({required bool isOngoing}) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) {
        final tickets = isOngoing
            ? provider.ongoingTickets
            : provider.completedTickets;

        if (tickets.isEmpty) {
          return _buildEmptyState(isOngoing);
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: tickets.length,
          itemBuilder: (context, index) {
            return _buildTicketCard(tickets[index]);
          },
        );
      },
    );
  }

  Widget _buildEmptyState(bool isOngoing) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.confirmation_number_outlined,
            size: 80,
            color: Colors.grey.withValues(alpha: 0.5),
          ),
          SizedBox(height: 16),
          Text(
            isOngoing ? 'No ongoing tickets' : 'No completed tickets',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            isOngoing
                ? 'Your active tickets will appear here'
                : 'Your used tickets will appear here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketCard(BookedTicket bookedTicket) {
    final theme = Theme.of(context);
    final event = bookedTicket.event;
    final ticket = bookedTicket.ticket;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TicketDetailPage(
              bookedTicket: bookedTicket,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event location
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: theme.colorScheme.onSurface,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      event.location ?? 'Location',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: event.image != null && event.image!.isNotEmpty
                        ? Image.network(
                      event.image!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildImagePlaceholder();
                      },
                    )
                        : _buildImagePlaceholder(),
                  ),
                  SizedBox(width: 16),

                  // Event Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title ?? 'Event',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),

                        // Ticket type
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff6351ec).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            ticket.name ?? 'Ticket',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff6351ec),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),

                        // Date & Time
                        if (event.startTime != null)
                          Text(
                            _formatDateTime(event.startTime),
                            style: TextStyle(
                              fontSize: 13,
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.7),
                            ),
                          ),
                        SizedBox(height: 4),

                        // Status
                        Row(
                          children: [
                            Icon(
                              bookedTicket.isOngoing
                                  ? Icons.access_time
                                  : Icons.check_circle,
                              size: 14,
                              color: bookedTicket.isOngoing
                                  ? Colors.orange
                                  : Colors.green,
                            ),
                            SizedBox(width: 4),
                            Text(
                              bookedTicket.status.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: bookedTicket.isOngoing
                                    ? Colors.orange
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),

              // NFT Info
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified,
                      color: Color(0xff6351ec),
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'NFT Token: ${bookedTicket.tokenId}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[700],
                          fontFamily: 'monospace',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.event,
        size: 40,
        color: Colors.grey.withValues(alpha: 0.5),
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