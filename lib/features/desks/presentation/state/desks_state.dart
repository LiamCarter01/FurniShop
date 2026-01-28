import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/desk_entity.dart';

/// State for the desks list.
///
/// This represents all possible states of the desks page.
sealed class DesksState extends Equatable {
  const DesksState();

  @override
  List<Object?> get props => [];
}

/// Initial state before loading.
class DesksInitial extends DesksState {
  const DesksInitial();
}

/// Loading state while fetching desks.
class DesksLoading extends DesksState {
  const DesksLoading();
}

/// Loaded state with desks data.
class DesksLoaded extends DesksState {
  final List<Desk> desks;
  final String? selectedCategory;

  const DesksLoaded({
    required this.desks,
    this.selectedCategory,
  });

  /// Get available categories from loaded desks.
  List<String> get categories {
    final categorySet = desks.map((d) => d.category).toSet();
    return categorySet.toList()..sort();
  }

  /// Filter desks by selected category.
  List<Desk> get filteredDesks {
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      return desks;
    }
    return desks.where((d) => d.category == selectedCategory).toList();
  }

  /// Create a copy with optional updates.
  DesksLoaded copyWith({
    List<Desk>? desks,
    String? selectedCategory,
  }) {
    return DesksLoaded(
      desks: desks ?? this.desks,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [desks, selectedCategory];
}

/// Error state when loading fails.
class DesksError extends DesksState {
  final Failure failure;

  const DesksError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}

/// State for a single desk detail.
sealed class DeskDetailState extends Equatable {
  const DeskDetailState();

  @override
  List<Object?> get props => [];
}

/// Initial state for desk detail.
class DeskDetailInitial extends DeskDetailState {
  const DeskDetailInitial();
}

/// Loading state for desk detail.
class DeskDetailLoading extends DeskDetailState {
  const DeskDetailLoading();
}

/// Loaded state with desk data.
class DeskDetailLoaded extends DeskDetailState {
  final Desk desk;
  final int quantity;

  const DeskDetailLoaded({
    required this.desk,
    this.quantity = 1,
  });

  /// Calculate total price.
  double get totalPrice => desk.price * quantity;

  /// Create a copy with optional updates.
  DeskDetailLoaded copyWith({
    Desk? desk,
    int? quantity,
  }) {
    return DeskDetailLoaded(
      desk: desk ?? this.desk,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [desk, quantity];
}

/// Error state for desk detail.
class DeskDetailError extends DeskDetailState {
  final Failure failure;

  const DeskDetailError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}
