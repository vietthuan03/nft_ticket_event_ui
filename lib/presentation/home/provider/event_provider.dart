import 'package:flutter/material.dart';
import 'package:nft_ticket_event_ui/data/data_provider.dart';
import 'package:nft_ticket_event_ui/models/event.dart';

class EventProvider extends ChangeNotifier {
  final DataProvider _dataProvider;

  // ===== Data =====
  EventModel? eventModel;
  List<EventModel> filteredEvents = [];

  EventProvider(this._dataProvider);
  // =========================
  // INIT FILTER (Category)
  // =========================
  // void filterInitialEventByCategory(EventCategory category) {
  //   selectedCategory = category;
  //   selectedType = EventType(name: 'All');

  //   eventTypes = _dataProvider.eventTypes
  //       .where((type) => type.categoryId == category.sId)
  //       .toList();

  //   eventTypes.insert(0, EventType(name: 'All'));

  //   filteredEvents = _dataProvider.events
  //       .where((e) => e.categoryId == category.sId)
  //       .toList();

  //   notifyListeners();
  // }

  // =========================
  // FILTER BY TYPE
  // =========================
  // void filterEventByType(EventType type) {
  //   selectedType = type;
  //   selectedOrganizers.clear();

  //   if (type.name == 'All') {
  //     filteredEvents = _dataProvider.events
  //         .where((e) => e.categoryId == selectedCategory?.sId)
  //         .toList();
  //     organizers = [];
  //   } else {
  //     filteredEvents = _dataProvider.events
  //         .where((e) => e.typeId == type.sId)
  //         .toList();

  //     organizers = _dataProvider.organizers
  //         .where((o) => o.typeId == type.sId)
  //         .toList();
  //   }

  //   notifyListeners();
  // }

  // =========================
  // FILTER BY ORGANIZER
  // =========================
  // void filterEventByOrganizer() {
  //   if (selectedOrganizers.isEmpty) {
  //     filteredEvents = _dataProvider.events
  //         .where((e) => e.typeId == selectedType?.sId)
  //         .toList();
  //   } else {
  //     filteredEvents = _dataProvider.events.where((e) {
  //       return e.typeId == selectedType?.sId &&
  //           selectedOrganizers.any(
  //             (org) => org.sId == e.organizerId,
  //           );
  //     }).toList();
  //   }

  //   notifyListeners();
  // }


  void updateUI() {
    notifyListeners();
  }
}
