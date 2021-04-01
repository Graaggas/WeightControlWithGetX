import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_control/misc/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeightChart extends StatelessWidget {
  final double startWeight;
  final double wantedWeight;
  final List<ChartWeights> list;

  const WeightChart({Key key, this.list, this.startWeight, this.wantedWeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 3,
          child: Container(
            child: SfCartesianChart(
              // Initialize category axis
              primaryXAxis: CategoryAxis(
                rangePadding: ChartRangePadding.none,
              ),
              primaryYAxis: CategoryAxis(
                minimum: wantedWeight-10,
                maximum: startWeight+20,
              ),
              title: ChartTitle(
                text: 'Показания веса',
                textStyle: GoogleFonts.robotoSlab(
                  // fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              series: <LineSeries<ChartWeights, String>>[
                LineSeries<ChartWeights, String>(
                  // Bind data source
                  dataSource: list,
                  xValueMapper: (ChartWeights data, _) => data.date,
                  yValueMapper: (ChartWeights data, _) => data.value,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
