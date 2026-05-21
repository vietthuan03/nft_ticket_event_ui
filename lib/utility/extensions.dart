import 'package:nft_ticket_event_ui/data/data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:nft_ticket_event_ui/presentation/home/provider/event_provider.dart';
import 'package:nft_ticket_event_ui/presentation/login_screen/provider/user_provider.dart';
import 'package:provider/provider.dart';

extension Providers on BuildContext {
  DataProvider get dataProvider => Provider.of<DataProvider>(this, listen: false);
  UserProvider get userProvider => Provider.of<UserProvider>(this, listen: false);
  EventProvider get eventProvider => Provider.of<EventProvider>(this, listen: false);
}
