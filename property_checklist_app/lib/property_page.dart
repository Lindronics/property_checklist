import 'package:flutter/material.dart';

import 'data/property.dart';

class PropertyPage extends StatefulWidget {
  PropertyPage({Key key, this.property}) : super(key: key);

  final Property property;

  @override
  _PropertyPageState createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.property.name),
      ),
      body: ListView.builder(
        itemCount: widget.property.features.length,
        itemBuilder: (context, index) {
          final feature = widget.property.features[index];

          return feature.getWidget(setState);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: "Finish editing",
        label: Text("Finish"),
        icon: Icon(Icons.check),
      ),
    );
  }
}
