import 'package:flutter/material.dart';

import '../../domain/entities/bedroom_entity.dart';

class BedroomGrid extends StatelessWidget {
  final List<Bedroom> bedrooms;
  final ValueChanged<Bedroom> onBedroomTap;

  const BedroomGrid({
    required this.bedrooms,
    required this.onBedroomTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: bedrooms.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final bedroom = bedrooms[index];
        return GestureDetector(
          onTap: () => onBedroomTap(bedroom),
          child: Card(
            child: Column(
              children: [
                Image.network(bedroom.imageUrl),
                Text(bedroom.name),
                Text('\$${bedroom.price}'),
              ],
            ),
          ),
        );
      },
    );
  }
}