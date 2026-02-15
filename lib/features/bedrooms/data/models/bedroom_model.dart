import '../../domain/entities/bedroom_entity.dart';

class BedroomModel extends Bedroom {
  const BedroomModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    super.originalPrice,
    required super.imageUrl,
    required super.rating,
    required super.reviewCount,
    required super.inStock,
    required super.category,
    required super.material,
    required super.color,
    required super.dimensions,
    super.isFeatured,
    super.tags,
  });

  factory BedroomModel.fromJson(Map<String, dynamic> json) {
    return BedroomModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      originalPrice: json['original_price'] != null ? (json['original_price'] as num).toDouble() : null,
      imageUrl: json['image_url'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['review_count'] as int,
      inStock: json['in_stock'] as bool,
      category: json['category'] as String,
      material: json['material'] as String,
      color: json['color'] as String,
      dimensions: BedroomDimensionsModel.fromJson(json['dimensions'] as Map<String, dynamic>),
      isFeatured: json['is_featured'] as bool? ?? false,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'original_price': originalPrice,
      'image_url': imageUrl,
      'rating': rating,
      'review_count': reviewCount,
      'in_stock': inStock,
      'category': category,
      'material': material,
      'color': color,
      'dimensions': {
        'width': dimensions.width,
        'height': dimensions.height,
        'depth': dimensions.depth,
        'weight': dimensions.weight,
      },
      'is_featured': isFeatured,
      'tags': tags,
    };
  }

  Bedroom toEntity() => this;

  factory BedroomModel.fromEntity(Bedroom bedroom) {
    return BedroomModel(
      id: bedroom.id,
      name: bedroom.name,
      description: bedroom.description,
      price: bedroom.price,
      originalPrice: bedroom.originalPrice,
      imageUrl: bedroom.imageUrl,
      rating: bedroom.rating,
      reviewCount: bedroom.reviewCount,
      inStock: bedroom.inStock,
      category: bedroom.category,
      material: bedroom.material,
      color: bedroom.color,
      dimensions: bedroom.dimensions,
      isFeatured: bedroom.isFeatured,
      tags: bedroom.tags,
    );
  }

  static List<BedroomModel> mockData = [
    BedroomModel(id: '1', name: 'Modern Bedroom', description: 'A modern bedroom set with beautiful design.', price: 999.99, imageUrl: 'https://example.com/image1.jpg', rating: 4.5, reviewCount: 120, inStock: true, category: 'Modern', material: 'Wood', color: 'White', dimensions: BedroomDimensionsModel(width: 200, height: 250, depth: 50, weight: 30), isFeatured: true),
    BedroomModel(id: '2', name: 'Classic Bedroom', description: 'An elegant classic bedroom set.', price: 1200.00, imageUrl: 'https://example.com/image2.jpg', rating: 4.2, reviewCount: 85, inStock: true, category: 'Classic', material: 'Wood', color: 'Brown', dimensions: BedroomDimensionsModel(width: 210, height: 260, depth: 60, weight: 35)),
    BedroomModel(id: '3', name: 'Rustic Bedroom', description: 'A cozy rustic bedroom set.', price: 850.00, imageUrl: 'https://example.com/image3.jpg', rating: 4.8, reviewCount: 70, inStock: true, category: 'Rustic', material: 'Reclaimed Wood', color: 'Gray', dimensions: BedroomDimensionsModel(width: 210, height: 260, depth: 70, weight: 32)),
    BedroomModel(id: '4', name: 'Minimalist Bedroom', description: 'A minimalistic bedroom set for a modern home.', price: 1100.00, imageUrl: 'https://example.com/image4.jpg', rating: 4.6, reviewCount: 90, inStock: true, category: 'Minimalist', material: 'Fiberboard', color: 'Black', dimensions: BedroomDimensionsModel(width: 220, height: 270, depth: 55, weight: 28)),
    BedroomModel(id: '5', name: 'Luxury Bedroom', description: 'A luxurious bedroom with exquisite materials.', price: 2000.00, imageUrl: 'https://example.com/image5.jpg', rating: 4.9, reviewCount: 60, inStock: false, category: 'Luxury', material: 'Mahogany', color: 'Gold', dimensions: BedroomDimensionsModel(width: 230, height: 280, depth: 60, weight: 50)),
    BedroomModel(id: '6', name: 'Vintage Bedroom', description: 'A vintage bedroom set from the 80s.', price: 980.00, imageUrl: 'https://example.com/image6.jpg', rating: 4.0, reviewCount: 40, inStock: true, category: 'Vintage', material: 'Oak', color: 'Dark Brown', dimensions: BedroomDimensionsModel(width: 215, height: 265, depth: 65, weight: 38)),
    BedroomModel(id: '7', name: 'Eco-friendly Bedroom', description: 'An eco-friendly bedroom set with sustainable materials.', price: 1300.00, imageUrl: 'https://example.com/image7.jpg', rating: 4.4, reviewCount: 50, inStock: true, category: 'Eco-friendly', material: 'Bamboo', color: 'Natural', dimensions: BedroomDimensionsModel(width: 220, height: 270, depth: 60, weight: 20)),
    BedroomModel(id: '8', name: 'Urban Bedroom', description: 'A stylish urban bedroom design.', price: 750.00, imageUrl: 'https://example.com/image8.jpg', rating: 4.3, reviewCount: 58, inStock: true, category: 'Urban', material: 'Metal', color: 'Silver', dimensions: BedroomDimensionsModel(width: 200, height: 260, depth: 55, weight: 25)),
    BedroomModel(id: '9', name: 'Coastal Bedroom', description: 'A seaside inspired bedroom for relaxation.', price: 820.00, imageUrl: 'https://example.com/image9.jpg', rating: 4.7, reviewCount: 78, inStock: true, category: 'Coastal', material: 'Pine', color: 'Blue', dimensions: BedroomDimensionsModel(width: 210, height: 270, depth: 50, weight: 30)),
    BedroomModel(id: '10', name: 'Bohemian Bedroom', description: 'A colorful and artistic bohemian bedroom.', price: 600.00, imageUrl: 'https://example.com/image10.jpg', rating: 4.1, reviewCount: 36, inStock: true, category: 'Bohemian', material: 'Mixed Wood', color: 'Multicolor', dimensions: BedroomDimensionsModel(width: 215, height: 265, depth: 60, weight: 34))
  ];
