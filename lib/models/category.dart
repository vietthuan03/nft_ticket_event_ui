class CategoryModel {
  final String id;
  final String imagePath;
  final String text;

  CategoryModel({
    required this.id,
    required this.imagePath,
    required this.text,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      imagePath: json['imagePath'] ?? json['image'] ?? '',
      text: json['text'] ?? json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'text': text,
    };
  }
}