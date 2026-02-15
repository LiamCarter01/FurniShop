import 'package:furnishop/features/bedrooms/domain/repositories/bedroom_repository.dart';
import 'package:furnishop/features/bedrooms/data/datasources/bedroom_datasource.dart';

class BedroomRepositoryImpl implements BedroomRepository {
  final BedroomDataSource dataSource;

  BedroomRepositoryImpl(this.dataSource);

  @override
  Future<List<BedroomEntity>> getBedrooms() {
    return dataSource.fetchBedrooms();
  }
}