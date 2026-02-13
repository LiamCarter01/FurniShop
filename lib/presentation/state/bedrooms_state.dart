import 'package:flutter/foundation.dart';
import 'package:your_project_path/domain/entities/bedroom_entity.dart';

class BedroomsState extends ChangeNotifier {
  List<Bedroom> _bedrooms = [];

  List<Bedroom> get bedrooms => _bedrooms;

  void setBedrooms(List<Bedroom> bedrooms) {
    _bedrooms = bedrooms;
    notifyListeners();
  }

  void addBedroom(Bedroom bedroom) {
    _bedrooms.add(bedroom);
    notifyListeners();
  }
}