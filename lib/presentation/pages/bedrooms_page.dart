import 'package:flutter/material.dart';
import 'package:your_project_path/presentation/state/bedrooms_state.dart';
import 'package:provider/provider.dart';
import 'package:your_project_path/domain/entities/bedroom_entity.dart';

class BedroomsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bedrooms'),
      ),
      body: Consumer<BedroomsState>(
        builder: (context, state, child) {
          if (state.bedrooms.isEmpty) {
            return Center(child: Text('No bedrooms available')); 
          }
          return ListView.builder(
            itemCount: state.bedrooms.length,
            itemBuilder: (context, index) {
              final bedroom = state.bedrooms[index];
              return ListTile(
                title: Text(bedroom.name),
                subtitle: Text(bedroom.description),
                leading: Image.network(bedroom.imageUrl,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
              );
            },
          );
        },
      ),
    );
  }
}