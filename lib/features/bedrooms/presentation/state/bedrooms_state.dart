import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/bedroom_entity.dart';

/// State definitions for the bedrooms feature.
sealed class BedroomsState extends Equatable {
  const BedroomsState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any data loads.
class BedroomsInitial extends BedroomsState {
  const BedroomsInitial();
}

/// Loading state while bedrooms data is being fetched.
class BedroomsLoading extends BedroomsState {
  const BedroomsLoading();
}

/// Loaded state containing bedroom list data.
class BedroomsLoaded extends BedroomsState {
  final List<Bedroom> bedrooms;
  final String? selectedCategory;

  const BedroomsLoaded({
    required this.bedrooms,
    this.selectedCategory,
  });

  /// Unique categories derived from loaded bedrooms.
  List<String> get categories {
    final categorySet = bedrooms.map((room) => room.category).toSet();
    return categorySet.toList()..sort();
  }

  /// Filter bedrooms by the currently selected category.
  List<Bedroom> get filteredBedrooms {
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      return bedrooms;
    }
    return bedrooms
        .where((room) => room.category == selectedCategory)
        .toList();
  }

  /// Copy helper for applying updates.
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

/// Error state when bedrooms fail to load.
class BedroomsError extends BedroomsState {
  final Failure failure;

  const BedroomsError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}

/// Shared state definitions for bedroom detail screens.
sealed class BedroomDetailState extends Equatable {
  const BedroomDetailState();

  @override
  List<Object?> get props => [];
}

/// Initial state before detail loading begins.
class BedroomDetailInitial extends BedroomDetailState {
  const BedroomDetailInitial();
}

/// Loading state for bedroom details.
class BedroomDetailLoading extends BedroomDetailState {
  const BedroomDetailLoading();
}

/// Loaded state containing bedroom detail payload.
class BedroomDetailLoaded extends BedroomDetailState {
  final Bedroom bedroom;
  final int quantity;

  const BedroomDetailLoaded({
    required this.bedroom,
    this.quantity = 1,
  });

  /// Total price based on quantity.
  double get totalPrice => bedroom.price * quantity;

  /// Create an updated copy.
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

/// Error state when bedroom detail fails to load.
class BedroomDetailError extends BedroomDetailState {
  final Failure failure;

  const BedroomDetailError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}
