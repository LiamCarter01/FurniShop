import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/bedroom_entity.dart';

/// State for the bedrooms list.
///
/// Represents all possible states of the bedrooms page.
sealed class BedroomsState extends Equatable {
  const BedroomsState();

  @override
  List<Object?> get props => [];
}

/// Initial state before loading bedrooms.
class BedroomsInitial extends BedroomsState {
  const BedroomsInitial();
}

/// Loading state while fetching bedroom data.
class BedroomsLoading extends BedroomsState {
  const BedroomsLoading();
}

/// Loaded state with bedroom products.
class BedroomsLoaded extends BedroomsState {
  final List<Bedroom> bedrooms;
  final String? selectedCategory;

  const BedroomsLoaded({
    required this.bedrooms,
    this.selectedCategory,
  });

  /// Available categories extracted from bedrooms.
  List<String> get categories {
    final categorySet = bedrooms.map((b) => b.category).toSet();
    return categorySet.toList()..sort();
  }

  /// Filter bedrooms by selected category.
  List<Bedroom> get filteredBedrooms {
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      return bedrooms;
    }
    return bedrooms.where((b) => b.category == selectedCategory).toList();
  }

  /// Create a copy with optional updates.
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
