import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/living_room_entity.dart';

/// State for the living rooms list.
///
/// Represents all possible states of the living rooms page.
sealed class LivingRoomsState extends Equatable {
  const LivingRoomsState();

  @override
  List<Object?> get props => [];
}

/// Initial state before loading living rooms.
class LivingRoomsInitial extends LivingRoomsState {
  const LivingRoomsInitial();
}

/// Loading state while fetching living rooms.
class LivingRoomsLoading extends LivingRoomsState {
  const LivingRoomsLoading();
}

/// Loaded state with living rooms data.
class LivingRoomsLoaded extends LivingRoomsState {
  final List<LivingRoom> rooms;
  final String? selectedCategory;

  const LivingRoomsLoaded({
    required this.rooms,
    this.selectedCategory,
  });

  /// Available categories extracted from loaded living rooms.
  List<String> get categories {
    final categorySet = rooms.map((r) => r.category).toSet();
    return categorySet.toList()..sort();
  }

  /// Filter living rooms by the selected category.
  List<LivingRoom> get filteredRooms {
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      return rooms;
    }
    return rooms.where((r) => r.category == selectedCategory).toList();
  }

  /// Create a copy with optional updates.
  LivingRoomsLoaded copyWith({
    List<LivingRoom>? rooms,
    String? selectedCategory,
  }) {
    return LivingRoomsLoaded(
      rooms: rooms ?? this.rooms,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [rooms, selectedCategory];
}

/// Error state when loading living rooms fails.
class LivingRoomsError extends LivingRoomsState {
  final Failure failure;

  const LivingRoomsError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}

/// State for a single living room detail.
sealed class LivingRoomDetailState extends Equatable {
  const LivingRoomDetailState();

  @override
  List<Object?> get props => [];
}

/// Initial state for living room detail.
class LivingRoomDetailInitial extends LivingRoomDetailState {
  const LivingRoomDetailInitial();
}

/// Loading state for living room detail.
class LivingRoomDetailLoading extends LivingRoomDetailState {
  const LivingRoomDetailLoading();
}

/// Loaded state with living room detail data.
class LivingRoomDetailLoaded extends LivingRoomDetailState {
  final LivingRoom livingRoom;
  final int quantity;

  const LivingRoomDetailLoaded({
    required this.livingRoom,
    this.quantity = 1,
  });

  /// Calculate total price based on quantity.
  double get totalPrice => livingRoom.price * quantity;

  /// Create a copy with optional updates.
  LivingRoomDetailLoaded copyWith({
    LivingRoom? livingRoom,
    int? quantity,
  }) {
    return LivingRoomDetailLoaded(
      livingRoom: livingRoom ?? this.livingRoom,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [livingRoom, quantity];
}

/// Error state for living room detail.
class LivingRoomDetailError extends LivingRoomDetailState {
  final Failure failure;

  const LivingRoomDetailError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}
