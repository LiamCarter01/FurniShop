import 'package:your_project_path/domain/entities/bedroom_entity.dart';

class BedroomModel extends Bedroom {
  BedroomModel({required String id, required String name, required String description, required String imageUrl})
      : super(id: id, name: name, description: description, imageUrl: imageUrl);

  factory BedroomModel.fromJson(Map<String, dynamic> json) {
    return BedroomModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}