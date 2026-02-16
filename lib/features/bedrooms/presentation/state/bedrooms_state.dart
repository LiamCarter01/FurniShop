import 'package:equatable/equatable.dart';

import '../../domain/entities/bedroom_entity.dart';
import '../../../../core/errors/failures.dart';

/// State for the bedrooms list page.
sealed class BedroomsState extends Equatable {
  const BedroomsState();

  @override
  List<Object?> get props => [];
}

/// Initial state before data loads.
class BedroomsInitial extends BedroomsState {
  const BedroomsInitial();
}

/// Loading state while fetching bedrooms.
class BedroomsLoading extends BedroomsState {
  const BedroomsLoading();
}

/// Loaded state containing bedroom products.
class BedroomsLoaded extends BedroomsState {
  final List<Bedroom> bedrooms;
  final String? selectedCategory;

  const BedroomsLoaded({
    required this.bedrooms,
    this.selectedCategory,
  });

  /// All available categories.
  List<String> get categories {
    final categorySet = bedrooms.map((b) => b.category).toSet();
    return categorySet.toList()..sort();
  }

  /// Bedrooms filtered by category.
  List<Bedroom> get filteredBedrooms {
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      return bedrooms;
    }
    return bedrooms.where((b) => b.category == selectedCategory).toList();
  }

  /// Copy with optional overrides.
  BedroomsLoaded copyWith({
    List<Bedroom>? bedrooms,
    String? selectedCategory,
  }) {
    return BedroomsLoaded(
      bedrooms: bedrooms ?? this.bedrooms,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [bedrooms, selectedCategory];
}

/// Error state when data fetch fails.
class BedroomsError extends BedroomsState {
  final Failure failure;

  const BedroomsError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}

/// State for a single bedroom detail.
sealed class BedroomDetailState extends Equatable {
  const BedroomDetailState();

  @override
  List<Object?> get props => [];
}

/// Initial state for bedroom details.
class BedroomDetailInitial extends BedroomDetailState {
  const BedroomDetailInitial();
}

/// Loading state for bedroom detail.
class BedroomDetailLoading extends BedroomDetailState {
  const BedroomDetailLoading();
}

/// Loaded detail state.
class BedroomDetailLoaded extends BedroomDetailState {
  final Bedroom bedroom;
  final int quantity;

  const BedroomDetailLoaded({
    required this.bedroom,
    this.quantity = 1,
  });

  double get totalPrice => bedroom.price * quantity;

  BedroomDetailLoaded copyWith({
    Bedroom? bedroom,
    int? quantity,
  }) {
    return BedroomDetailLoaded(
      bedroom: bedroom ?? this.bedroom,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [bedroom, quantity];
}

/// Error state for bedroom detail.
class BedroomDetailError extends BedroomDetailState {
  final Failure failure;

  const BedroomDetailError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}
