import 'package:furnishop/features/bedrooms/domain/entities/bedroom_entity.dart';

class BedroomModel extends BedroomEntity {
  BedroomModel({required String id, required String name, required String description}) :
    super(id: id, name: name, description: description);
}