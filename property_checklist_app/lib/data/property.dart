import 'feature.dart';

class Property {
  String name;
  Uri posting;
  DateTime availableOn;
  String address;
  List<Feature> features = [];

  Property({this.name}) {
    features = [
      CountFeature("Number of bedrooms", 1),
      BooleanFeature("Test", true),
    ];
  }
}