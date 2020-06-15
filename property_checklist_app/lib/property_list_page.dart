import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:property_checklist_app/property_page.dart';

import 'data/property.dart';
import 'data/storage_adapter.dart';


class PropertyListPage extends StatelessWidget {
  PropertyListPage({Key key, this.properties, @required this.itemDeletionCallback(Property property)}) : super(key: key);

  final StorageAdapter<Property> properties;
  final itemDeletionCallback;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: properties.getLength(),
        itemBuilder: (context, index) {
          final property = properties.getItem(index);
          return Slidable(
            actionPane: SlidableScrollActionPane(),
            actionExtentRatio: 0.2,
            child: ListTile(
                leading: FlutterLogo(size: 72.0),
                title: Text(property.name),
                subtitle: Text('This is where the flat summary goes.'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PropertyPage(
                                property: property,
                              )));
                }),
            actions: <Widget>[
              IconSlideAction(
                  caption: "Favourite",
                  color: Colors.yellow,
                  icon: Icons.star,
                  onTap: () {})
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                  caption: "Delete",
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    itemDeletionCallback(property);
                  })
            ],
          );
        },
      );
  }
}
