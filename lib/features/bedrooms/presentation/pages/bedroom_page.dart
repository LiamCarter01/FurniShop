import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/bedrooms_providers.dart';
import '../widgets/bedroom_grid.dart';

class BedroomPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bedroomsProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Bedrooms')),
      body: state.when(
        initial: () => Center(child: CircularProgressIndicator()),
        loading: () => Center(child: CircularProgressIndicator()),
        loaded: (bedrooms) => BedroomGrid(bedrooms: bedrooms, onBedroomTap: (bedroom) {}),
        error: (message) => Center(child: Text('Error: $message')),
      ),
    );
  }
}