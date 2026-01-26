import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/chair_entity.dart';

/// State for the chairs list.
///
/// This represents all possible states of the chairs page.
sealed class ChairsState extends Equatable {
  const ChairsState();

  @override
  List<Object?> get props => [];
}

/// Initial state before loading.
class ChairsInitial extends ChairsState {
  const ChairsInitial();
}

/// Loading state while fetching chairs.
class ChairsLoading extends ChairsState {
  const ChairsLoading();
}

/// Loaded state with chairs data.
class ChairsLoaded extends ChairsState {
  final List<Chair> chairs;
  final String? selectedCategory;

  const ChairsLoaded({
    required this.chairs,
    this.selectedCategory,
  });

  /// Get available categories from loaded chairs.
  List<String> get categories {
    final categorySet = chairs.map((c) => c.category).toSet();
    return categorySet.toList()..sort();
  }

  /// Filter chairs by selected category.
  List<Chair> get filteredChairs {
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      return chairs;
    }
    return chairs
        .where((c) => c.category == selectedCategory)
        .toList();
  }

  /// Create a copy with optional updates.
  ChairsLoaded copyWith({
    List<Chair>? chairs,
    String? selectedCategory,
  }) {
    return ChairsLoaded(
      chairs: chairs ?? this.chairs,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [chairs, selectedCategory];
}

/// Error state when loading fails.
class ChairsError extends ChairsState {
  final Failure failure;

  const ChairsError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}

/// State for a single chair detail.
sealed class ChairDetailState extends Equatable {
  const ChairDetailState();

  @override
  List<Object?> get props => [];
}

/// Initial state for chair detail.
class ChairDetailInitial extends ChairDetailState {
  const ChairDetailInitial();
}

/// Loading state for chair detail.
class ChairDetailLoading extends ChairDetailState {
  const ChairDetailLoading();
}

/// Loaded state with chair data.
class ChairDetailLoaded extends ChairDetailState {
  final Chair chair;
  final int quantity;

  const ChairDetailLoaded({
    required this.chair,
    this.quantity = 1,
  });

  /// Calculate total price.
  double get totalPrice => chair.price * quantity;

  /// Create a copy with optional updates.
  ChairDetailLoaded copyWith({
    Chair? chair,
    int? quantity,
  }) {
    return ChairDetailLoaded(
      chair: chair ?? this.chair,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [chair, quantity];
}

/// Error state for chair detail.
class ChairDetailError extends ChairDetailState {
  final Failure failure;

  const ChairDetailError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}
