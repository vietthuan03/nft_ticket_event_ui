import 'package:equatable/equatable.dart';

class TicketModel extends Equatable {
  final String title;
  final String description;
  final String date;
  final String imageUrl;
  final String location;

  const TicketModel({
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
    required this.location,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      date: json["date"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      location: json["location"] ?? "",
    );
  }

  @override
  List<Object?> get props => [title, description, date, imageUrl, location];
}
