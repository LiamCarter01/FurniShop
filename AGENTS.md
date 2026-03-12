# Agent Instructions for Furnishop

This file contains instructions for AI agents working on the Furnishop Flutter application.

## Product Images

When implementing any feature category (chairs, desks, bedrooms, living_rooms), you **MUST** use the product images defined in `assets/images/product_images.json`.

### Image Data Source

All product image URLs are stored in `/home/mahmoud/projects/furnishop/assets/images/product_images.json`

This JSON file contains:
- **chairs**: 5 furniture items with Unsplash image URLs
- **desks**: 5 furniture items with Unsplash image URLs  
- **bedrooms**: 5 furniture items with Unsplash image URLs
- **living_rooms**: 5 furniture items with Unsplash image URLs

Each item includes:
- `id`: Unique identifier for the product
- `name`: Display name of the product
- `imageUrl`: Direct URL to the product image (Unsplash, open source)
- `description`: Brief description of the product

### Implementation Requirements

When implementing a feature category:

1. **Read the JSON file** to get the image URLs for that category
2. **Use the exact URLs** provided - do not generate or use different image URLs
3. **Map the JSON data** to your data models (e.g., `ChairModel`, `DeskModel`, etc.)
4. **Include all fields** from the JSON (id, name, imageUrl, description) in your entities/models
5. **Add additional fields** as needed (price, rating, stock, etc.) but keep the core image data

### Example Usage

For the chairs feature:

```dart
// In chair_datasource.dart or chair_repository_impl.dart
Future<List<ChairModel>> getChairs() async {
  // Load the JSON file
  final jsonString = await rootBundle.loadString('assets/images/product_images.json');
  final jsonData = json.decode(jsonString);
  
  // Get chairs array
  final chairsJson = jsonData['chairs'] as List;
  
  // Map to ChairModel with additional properties
  return chairsJson.map((item) => ChairModel(
    id: item['id'],
    name: item['name'],
    imageUrl: item['imageUrl'],
    description: item['description'],
    // Add additional properties as needed
    price: 99.99, // Example additional field
    rating: 4.5,
  )).toList();
}
```

### Asset Configuration

Ensure that `product_images.json` is properly registered in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/
    - assets/images/product_images.json
```

### Image Sources

All images are sourced from Unsplash (https://unsplash.com), which provides free-to-use, high-quality images under the Unsplash License. These images can be used for commercial and non-commercial purposes without requesting permission.

### Important Notes

- **DO NOT** hardcode different image URLs in your implementation
- **DO NOT** use placeholder images or generic URLs
- **DO** use the provided JSON structure as the source of truth for product data
- **DO** extend the models with additional fields (price, ratings, etc.) as needed for the feature
- **DO** handle image loading errors gracefully in the UI

## Project Structure

This is a Flutter application using Clean Architecture with the following structure:

```
lib/
  features/
    [feature_name]/
      data/
        datasources/    # Data sources (local, remote, JSON)
        models/         # Data models
        repositories/   # Repository implementations
      domain/
        entities/       # Business entities
        repositories/   # Repository interfaces
        usecases/       # Business logic
      presentation/
        pages/          # UI pages
        providers/      # State management
        state/          # State classes
        widgets/        # Feature-specific widgets
```

When implementing a new feature, follow this structure exactly.

## Testing

When implementing features, ensure you:
- Write unit tests for repositories and use cases
- Write widget tests for UI components
- Use the test images from the JSON file in your test mocks

## Questions?

If you need clarification on any of these instructions, refer to existing implementations in the `chairs` feature as a reference.
