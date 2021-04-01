import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      elevation: 4,
      gradient: LinearGradient(colors: [Colors.black45  , Colors.grey]),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          GFDrawerHeader(
            decoration: BoxDecoration(color: Colors.white70),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: null,
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: null,
          ),
        ],
      ),
    );
  }
}