import 'package:your_project_path/domain/entities/bedroom_entity.dart';
import 'package:your_project_path/domain/repositories/bedroom_repository.dart';

class BedroomUseCases {
  final BedroomRepository repository;

  BedroomUseCases(this.repository);

  Future<List<Bedroom>> getAllBedrooms() async {
    return await repository.getAllBedrooms();
  }

  Future<void> addBedroom(Bedroom bedroom) async {
    await repository.addBedroom(bedroom);
  }
}