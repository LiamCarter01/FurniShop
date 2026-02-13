import 'package:your_project_path/data/models/bedroom_model.dart';

class BedroomDataSource {
  final List<BedroomModel> _bedrooms = [];

  BedroomDataSource() {
    _initializeMockData();
  }

  void _initializeMockData() {
    _bedrooms.add(BedroomModel(id: '1', name: 'Modern Bedroom', description: 'A modern bedroom with stylish furniture.', imageUrl: 'https://example.com/image1.jpg'));
    _bedrooms.add(BedroomModel(id: '2', name: 'Cozy Bedroom', description: 'A cozy bedroom with warm colors.', imageUrl: 'https://example.com/image2.jpg'));
    _bedrooms.add(BedroomModel(id: '3', name: 'Elegant Bedroom', description: 'An elegant bedroom with classic furniture.', imageUrl: 'https://example.com/image3.jpg'));
    _bedrooms.add(BedroomModel(id: '4', name: 'Minimalist Bedroom', description: 'A minimalist bedroom with simple decor.', imageUrl: 'https://example.com/image4.jpg'));
    _bedrooms.add(BedroomModel(id: '5', name: 'Rustic Bedroom', description: 'A rustic bedroom that feels like a cabin.', imageUrl: 'https://example.com/image5.jpg'));
    _bedrooms.add(BedroomModel(id: '6', name: 'Luxury Bedroom', description: 'A luxury bedroom with high-end furnishings.', imageUrl: 'https://example.com/image6.jpg'));
    _bedrooms.add(BedroomModel(id: '7', name: 'Beachside Bedroom', description: 'A bedroom with a view of the beach.', imageUrl: 'https://example.com/image7.jpg'));
    _bedrooms.add(BedroomModel(id: '8', name: 'Garden Bedroom', description: 'A bedroom with garden views.', imageUrl: 'https://example.com/image8.jpg'));
    _bedrooms.add(BedroomModel(id: '9', name: 'Classic Bedroom', description: 'A classic bedroom with traditional furniture.', imageUrl: 'https://example.com/image9.jpg'));
    _bedrooms.add(BedroomModel(id: '10', name: 'Urban Bedroom', description: 'A contemporary bedroom in an urban setting.', imageUrl: 'https://example.com/image10.jpg'));
  }

  List<BedroomModel> getAllBedrooms() {
    return _bedrooms;
  }

  void addBedroom(BedroomModel bedroom) {
    _bedrooms.add(bedroom);
  }

  final List<BedroomModel> _bedrooms = [];

  List<BedroomModel> getAllBedrooms() {
    return _bedrooms;
  }

  void addBedroom(BedroomModel bedroom) {
    _bedrooms.add(bedroom);
  }
}