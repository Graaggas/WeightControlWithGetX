import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_control/misc/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatelessWidget {
  final double startValue;
  final double wantedValue;
  final List<ChartValues> list;
  final String text;

  const Chart(
      {Key key, this.list, this.startValue, this.wantedValue, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 3,
          child: Container(
            child: SfCartesianChart(
              zoomPanBehavior: ZoomPanBehavior(
                enablePanning: true,
                enablePinching: true,
                enableDoubleTapZooming: true,
              ),
              // Initialize category axis
              primaryXAxis: CategoryAxis(
                rangePadding: ChartRangePadding.none,
              ),
              primaryYAxis: CategoryAxis(
                minimum: wantedValue - 10,
                maximum: startValue + 20,
              ),
              title: ChartTitle(
                text: text,
                textStyle: GoogleFonts.robotoSlab(
                  // fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              series: <LineSeries<ChartValues, String>>[
                LineSeries<ChartValues, String>(
                  // Bind data source
                  dataSource: list,
                  xValueMapper: (ChartValues data, _) => data.date,
                  yValueMapper: (ChartValues data, _) => data.value,
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
