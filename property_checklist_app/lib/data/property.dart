import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'feature.dart';

class Property {
  String name;
  Uri posting;
  DateTime availableOn;
  String address;
  List<Feature> features = [];
  Status status;
  int monthlyRent;
  int bedrooms;
  int bathrooms;
  LatLng location;

  Property({this.name, this.bedrooms, this.bathrooms, this.monthlyRent, this.address}) {
    features = [
      CountFeature("Number of bedrooms", 1),
      BooleanFeature("Test", true),
    ];
  }

  void setAddress(String address, void callback(Property property)) {
    this.address = address;
    getCoords(address).then((LatLng coords) {
      this.location = coords;
      callback(this);
    });
  }

  Future<LatLng> getCoords(String address) async {
    var addresses = await Geocoder.local.findAddressesFromQuery(address);
    // TODO error handling
    var coords = addresses.first.coordinates;
    return LatLng(coords.latitude, coords.longitude);
  }
}

enum Status { FOUND, ENQUIRED, SCHEDULED, VIEWED }
