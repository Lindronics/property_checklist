import 'package:flutter/material.dart';

abstract class Feature {
  String name;

  Feature(this.name);

  Widget getWidget(void Function(void Function()) fn);
}

class BooleanFeature extends Feature {
  final bool defaultValue;
  bool value;

  BooleanFeature(name, this.defaultValue) : super(name) {
    value = defaultValue;
  }

  @override
  Widget getWidget(void Function(void Function()) fn) {
    return CheckboxListTile(
      title: Text(this.name),
      value: this.value,
      onChanged: (bool newValue) {
        fn(() {
          this.value = newValue;
          print(newValue);
        });
      },
    );
  }
}

class CountFeature extends Feature {
  final int defaultValue;
  int value;

  CountFeature(name, this.defaultValue) : super(name) {
    value = defaultValue;
  }

  @override
  Widget getWidget(void Function(void Function()) fn) {
    return ListTile(
        title: Text(this.name),
        trailing: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
                width: 60,
                child: OutlineButton(
                  onPressed: () {
                    fn(() {
                      if (value > 0) {
                        value--;
                      }
                    });
                  },
                  child: Icon(Icons.expand_more),
                )),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(value.toString())),
            SizedBox(
                width: 60,
                child: OutlineButton(
                  onPressed: () {
                    fn(() {
                      value++;
                    });
                  },
                  child: Icon(Icons.expand_less),
                )),
          ],
        ));
  }
}
