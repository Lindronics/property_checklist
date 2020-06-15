import 'package:flutter/material.dart';

import 'data/feature.dart';


class FeatureManagerPage extends StatefulWidget {
  FeatureManagerPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FeatureManagerPageState createState() => _FeatureManagerPageState();
}

class _FeatureManagerPageState extends State<FeatureManagerPage> {
  List<Feature> features;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: features.length,
      itemBuilder: (BuildContext context, int index) {
        var feature = features[index];
        return ListTile(
          title: Text(feature.name),
        );
      },
    );
  }
}
