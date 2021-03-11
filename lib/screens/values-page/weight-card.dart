import 'package:flutter/material.dart';

class WeightCard extends StatelessWidget {
  final String weightText;
  final String dateText;

  const WeightCard({Key key, this.weightText, this.dateText}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(weightText),
            Text(dateText),
          ],
        ),
      ),
    );
  }
}
