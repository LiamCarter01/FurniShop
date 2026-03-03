import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/bedroom_entity.dart';

/// Represents the state of the bedrooms listing UI.
sealed class BedroomsState extends Equatable {
  const BedroomsState();

  @override
  List<Object?> get props => [];
}

class BedroomsInitial extends BedroomsState {
  const BedroomsInitial();
}

class BedroomsLoading extends BedroomsState {
  const BedroomsLoading();
}

class BedroomsLoaded extends BedroomsState {
  final List<Bedroom> bedrooms;
  final String? selectedCategory;

  const BedroomsLoaded({
    required this.bedrooms,
    this.selectedCategory,
  });

  /// Extracts the available categories from the current list.
  List<String> get categories {
    final categorySet = bedrooms.map((b) => b.category).toSet();
    return categorySet.toList()..sort();
  }

  /// Bedrooms filtered by the currently selected category.
  List<Bedroom> get filteredBedrooms {
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      return bedrooms;
    }
    return bedrooms
        .where((bedroom) => bedroom.category == selectedCategory)
        .toList();
  }

  /// Creates a copy of the current state with optional overrides.
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

class BedroomsError extends BedroomsState {
  final Failure failure;

  const BedroomsError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}

/// Represents the state of the bedroom detail UI.
sealed class BedroomDetailState extends Equatable {
  const BedroomDetailState();

  @override
  List<Object?> get props => [];
}

class BedroomDetailInitial extends BedroomDetailState {
  const BedroomDetailInitial();
}

class BedroomDetailLoading extends BedroomDetailState {
  const BedroomDetailLoading();
}

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

class BedroomDetailError extends BedroomDetailState {
  final Failure failure;

  const BedroomDetailError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}
