class Bedroom { // Updated to ensure tracking
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Bedroom({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

List<Bedroom> bedroomMockData = [
  Bedroom(
    id: '1',
    name: 'Luxury King Bed',
    description: 'A luxurious king size bed with plush pillows.',
    price: 1200.00,
    imageUrl: 'assets/images/bed1.png',
  ),
  Bedroom(
    id: '2',
    name: 'Modern Queen Bed',
    description: 'A modern queen bed with a minimalist design.',
    price: 900.00,
    imageUrl: 'assets/images/bed2.png',
  ),
  // Additional mock entries...
  Bedroom(
    id: '10',
    name: 'Classic Twin Beds',
    description: 'Classic twin beds with wooden frames.',
    price: 800.00,
    imageUrl: 'assets/images/bed10.png',
  ),
];