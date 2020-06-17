import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:property_checklist_app/property_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'data/property.dart';
import 'data/storage_adapter.dart';

class PropertyListPage extends StatelessWidget {
  PropertyListPage(
      {Key key,
      this.properties,
      this.markers,
      @required this.itemDeletionCallback(BuildContext context, Property property)})
      : super(key: key);

  final StorageAdapter<Property> properties;
  final itemDeletionCallback;

  final Set<Marker> markers;

  Widget _scrollingList(ScrollController sc) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        Expanded(
          child: ListView.builder(
            controller: sc,
            itemCount: properties.getLength(),
            itemBuilder: (context, index) {
              final property = properties.getItem(index);
              return Slidable(
                actionPane: SlidableScrollActionPane(),
                actionExtentRatio: 0.2,
                child: ListTile(
                    leading: FlutterLogo(size: 72.0),
                    title: Text(property.name),
                    subtitle: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("£${property.monthlyRent}pcm"),
                        ),
                        Expanded(
                          child: Text("\u{1f6cf} ${property.bedrooms}"),
                        ),
                        Expanded(
                            child: Text("\u{1f6c1} ${property.bathrooms}")),
                      ],
                    ),
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
                        itemDeletionCallback(context, property);
                      })
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      defaultPanelState: PanelState.OPEN,
      parallaxEnabled: true,
      parallaxOffset: 0.65,
      maxHeight: 600, // TODO remove hard-coded number
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          blurRadius: 20.0,
          color: Colors.grey,
        ),
      ],
      panelBuilder: (ScrollController sc) => _scrollingList(sc),
      body: GoogleMap(
          myLocationEnabled: true,
          compassEnabled: true,
          markers: markers,
          // polygons: [],
          // onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(55.8714224, -4.2884796),
            zoom: 16.0,
          )),
    );
  }
}
