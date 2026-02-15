import 'package:flutter/material.dart';
import 'package:furnishop/features/bedrooms/data/models/bedroom_model.dart';

class BedroomGrid extends StatelessWidget {
  final List<BedroomModel> bedrooms;
  
  BedroomGrid({required this.bedrooms});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: bedrooms.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final bedroom = bedrooms[index];
        return Card(
          child: Column(
            children: [
              Text(bedroom.name),
              Text(bedroom.description),
            ],
          ),
        );
      },
    );
  }
}