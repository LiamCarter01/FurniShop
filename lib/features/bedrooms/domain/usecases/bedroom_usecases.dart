import 'package:furnishop/features/bedrooms/domain/repositories/bedroom_repository.dart';

class GetBedroomsUseCase {
  final BedroomRepository repository;

  GetBedroomsUseCase(this.repository);

  Future<List<BedroomEntity>> execute() {
    return repository.getBedrooms();
  }
}