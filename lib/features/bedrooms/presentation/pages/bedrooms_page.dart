import 'package:flutter/material.dart';
import 'package:furnishop/features/bedrooms/data/datasources/bedroom_datasource.dart';
import 'package:furnishop/features/bedrooms/presentation/widgets/bedroom_grid.dart';

class BedroomsPage extends StatelessWidget {
  final BedroomDataSource dataSource = BedroomDataSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bedrooms')),
      body: FutureBuilder(
        future: dataSource.fetchBedrooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: \${snapshot.error}');
          } else {
            return BedroomGrid(bedrooms: snapshot.data);
          }
        },
      ),
    );
  }
}