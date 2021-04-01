import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white,),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: Text("Info"),
      ),
    );
  }
}
