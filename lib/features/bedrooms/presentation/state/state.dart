import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/bedroom_entity.dart';

/// Application state for the bedrooms list flow.
sealed class BedroomsState extends Equatable {
  const BedroomsState();

  @override
  List<Object?> get props => [];
}

/// Initial state before bedrooms have been loaded.
class BedroomsInitial extends BedroomsState {
  const BedroomsInitial();
}

/// Loading state while bedrooms are fetched.
class BedroomsLoading extends BedroomsState {
  const BedroomsLoading();
}

/// Loaded state containing bedroom products and the selected filter.
class BedroomsLoaded extends BedroomsState {
  final List<Bedroom> bedrooms;
  final String? selectedCategory;

  const BedroomsLoaded({
    required this.bedrooms,
    this.selectedCategory,
  });

  /// Available categories derived from the loaded bedrooms.
  List<String> get categories {
    final categorySet = bedrooms.map((bedroom) => bedroom.category).toSet();
    final sorted = categorySet.toList()..sort();
    return sorted;
  }

  /// Bedrooms filtered by the selected category.
  List<Bedroom> get filteredBedrooms {
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      return bedrooms;
    }
    return bedrooms
        .where((bedroom) => bedroom.category == selectedCategory)
        .toList();
  }

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

/// Error state for the bedrooms list flow.
class BedroomsError extends BedroomsState {
  final Failure failure;

  const BedroomsError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}

/// Base state for bedroom detail interactions.
sealed class BedroomDetailState extends Equatable {
  const BedroomDetailState();

  @override
  List<Object?> get props => [];
}

/// Initial bedroom detail state.
class BedroomDetailInitial extends BedroomDetailState {
  const BedroomDetailInitial();
}

/// Loading bedroom detail from the repository.
class BedroomDetailLoading extends BedroomDetailState {
  const BedroomDetailLoading();
}

/// Loaded bedroom detail with quantity tracking.
class BedroomDetailLoaded extends BedroomDetailState {
  final Bedroom bedroom;
  final int quantity;

  const BedroomDetailLoaded({
    required this.bedroom,
    this.quantity = 1,
  });

  /// Total price for the selected quantity.
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

/// Error state when loading bedroom detail fails.
class BedroomDetailError extends BedroomDetailState {
  final Failure failure;

  const BedroomDetailError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}
