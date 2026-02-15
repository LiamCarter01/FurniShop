import 'package:furnishop/features/bedrooms/data/models/bedroom_model.dart';

class BedroomDataSource {
  Future<List<BedroomModel>> fetchBedrooms() async {
    return List.generate(10, (index) => BedroomModel(
      id: 'bdrm_\$index',
      name: 'Bedroom \$index',
      description: 'Description for Bedroom \$index'));
  }
}