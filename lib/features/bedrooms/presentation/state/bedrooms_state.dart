import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/bedroom_entity.dart';

/// State for the bedrooms list page.
sealed class BedroomsState extends Equatable {
  const BedroomsState();

  @override
  List<Object?> get props => [];
}

/// Initial state before bedrooms data is loaded.
class BedroomsInitial extends BedroomsState {
  const BedroomsInitial();
}

/// Loading state while fetching bedrooms.
class BedroomsLoading extends BedroomsState {
  const BedroomsLoading();
}

/// Loaded state containing bedrooms data.
class BedroomsLoaded extends BedroomsState {
  final List<Bedroom> bedrooms;
  final String? selectedCategory;

  const BedroomsLoaded({
    required this.bedrooms,
    this.selectedCategory,
  });

  /// Available categories extracted from the bedrooms list.
  List<String> get categories {
    final categorySet = bedrooms.map((bedroom) => bedroom.category).toSet();
    return categorySet.toList()..sort();
  }

  /// Filter bedrooms by the selected category.
  List<Bedroom> get filteredBedrooms {
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      return bedrooms;
    }
    return bedrooms.where((bedroom) => bedroom.category == selectedCategory).toList();
  }

  /// Create a copy with optional overrides.
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

/// Error state when loading bedrooms fails.
class BedroomsError extends BedroomsState {
  final Failure failure;

  const BedroomsError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}

/// State for a single bedroom detail page.
sealed class BedroomDetailState extends Equatable {
  const BedroomDetailState();

  @override
  List<Object?> get props => [];
}

/// Initial state for bedroom detail.
class BedroomDetailInitial extends BedroomDetailState {
  const BedroomDetailInitial();
}

/// Loading state for bedroom detail.
class BedroomDetailLoading extends BedroomDetailState {
  const BedroomDetailLoading();
}

/// Loaded state with a single bedroom and quantity.
class BedroomDetailLoaded extends BedroomDetailState {
  final Bedroom bedroom;
  final int quantity;

  const BedroomDetailLoaded({
    required this.bedroom,
    this.quantity = 1,
  });

  /// Total price for the selected quantity.
  double get totalPrice => bedroom.price * quantity;

  /// Create a copy with optional overrides.
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

/// Error state for bedroom detail failures.
class BedroomDetailError extends BedroomDetailState {
  final Failure failure;

  const BedroomDetailError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}
