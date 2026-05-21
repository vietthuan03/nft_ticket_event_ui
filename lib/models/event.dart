import 'package:nft_ticket_event_ui/models/ticket.dart';

class EventModel {
  String? sId;
  String? title;
  String? image;
  String? description;
  DateTime? startTime;
  String? location;
  String? status;
  String? createdAt;
  String? updatedAt;

  EventModel({
    this.sId,
    this.title,
    this.image,
    this.description,
    this.startTime,
    this.location,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    image = json['image'] is String ? json['image'] : null;
    description = json['description'];
    startTime = json['startTime'] != null
        ? DateTime.parse(json['startTime']).toLocal()
        : null;
    location = json['location'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['startTime'] = this.startTime?.toIso8601String();
    data['location'] = this.location;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  String get formattedDateTime {
    if (startTime == null) return 'TBA';
    return '${startTime!.day}/${startTime!.month}/${startTime!.year} ${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}';
  }
}