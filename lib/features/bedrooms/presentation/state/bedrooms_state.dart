import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/bedroom_entity.dart';

/// Represents all possible states for the bedrooms page.
sealed class BedroomsState extends Equatable {
  const BedroomsState();

  @override
  List<Object?> get props => [];
}

/// Initial state before loading bedrooms.
class BedroomsInitial extends BedroomsState {
  const BedroomsInitial();
}

/// Loading state while bedroom data is being fetched.
class BedroomsLoading extends BedroomsState {
  const BedroomsLoading();
}

/// Loaded state when bedroom data is available.
class BedroomsLoaded extends BedroomsState {
  final List<Bedroom> bedrooms;
  final String? selectedCategory;

  const BedroomsLoaded({
    required this.bedrooms,
    this.selectedCategory,
  });

  /// Extract available categories from the loaded bedrooms.
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

/// Error state when fetching bedrooms fails.
class BedroomsError extends BedroomsState {
  final Failure failure;

  const BedroomsError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}
