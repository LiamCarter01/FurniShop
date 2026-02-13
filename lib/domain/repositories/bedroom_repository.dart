abstract class BedroomRepository {
  Future<List<Bedroom>> getAllBedrooms();
  Future<void> addBedroom(Bedroom bedroom);
}