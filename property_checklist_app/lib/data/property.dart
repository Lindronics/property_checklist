import 'feature.dart';

class Property {
  String name;
  Uri posting;
  DateTime availableOn;
  String address;
  List<Feature> features = [];
  Status status;
  int montlyRent;
  int bedrooms;
  int bathrooms;

  Property({this.name}) {
    features = [
      CountFeature("Number of bedrooms", 1),
      BooleanFeature("Test", true),
    ];
  }
}

enum Status { FOUND, ENQUIRED, SCHEDULED, VIEWED }
