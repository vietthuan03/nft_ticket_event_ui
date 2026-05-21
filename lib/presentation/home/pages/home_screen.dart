import 'package:flutter/material.dart';
import 'package:nft_ticket_event_ui/data/data_provider.dart';
import 'package:nft_ticket_event_ui/presentation/home/pages/event_detail_page.dart';
import 'package:nft_ticket_event_ui/presentation/home/provider/event_provider.dart';
import 'package:nft_ticket_event_ui/utility/extensions.dart';
import 'package:nft_ticket_event_ui/widget/custom_search_bar.dart';
import 'package:provider/provider.dart';
import '../widget/location_widget.dart';
import '../widget/event_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<DataProvider>().getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    double widthQ = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              width: widthQ,
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
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSearchBar(
                    controller: TextEditingController(),
                    onChanged: (val) {
                      context.dataProvider.filterEvents(val);
                    },
                  ),
                  // Location Widget
                  // LocationWidget(),

                  // Welcome Section
                  _buildWelcomeSection(theme),

                  // Events List
                  _buildEventsList(theme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(ThemeData theme) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        final eventCount = dataProvider.events.length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello',
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'There are $eventCount event${eventCount != 1 ? 's' : ''} around your location',
              style: TextStyle(
                color: Color(0xff6351ec),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEventsList(ThemeData theme) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        return Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upcoming Events',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // TODO: Navigate to all events page
                  },
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
            ),

            SizedBox(height: 16),

            // Events List or Loading/Error State
            if (dataProvider.isLoading)
              _buildLoadingState()
            else if (dataProvider.events.isEmpty)
              _buildEmptyState()
            else
            _buildEventsListView(dataProvider),
          ],
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Icon(Icons.event_busy, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No events found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextButton(onPressed: () {}, child: Text('Clear search')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsListView(DataProvider dataProvider) {
    return ListView.builder(
      itemCount: dataProvider.events.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final event = dataProvider.events[index];
        return EventCard(
          event: event,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EventDetailPage(event: event)),
            );
          },
        );
      },
    );
  }
}
