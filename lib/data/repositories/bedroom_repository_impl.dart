import 'package:your_project_path/data/datasources/bedroom_datasource.dart';
import 'package:your_project_path/domain/entities/bedroom_entity.dart';
import 'package:your_project_path/domain/repositories/bedroom_repository.dart';

class BedroomRepositoryImpl implements BedroomRepository {
  final BedroomDataSource dataSource;

  BedroomRepositoryImpl(this.dataSource);

  @override
  Future<List<Bedroom>> getAllBedrooms() async {
    return dataSource.getAllBedrooms();
  }

  @override
  Future<void> addBedroom(Bedroom bedroom) async {
    dataSource.addBedroom(BedroomModel(
      id: bedroom.id,
      name: bedroom.name,
      description: bedroom.description,
      imageUrl: bedroom.imageUrl,
    ));
  }
}