import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LinesGraphWidget extends StatefulWidget {
  final List<double> data;

  const LinesGraphWidget({ Key? key, required this.data})
      : super(key: key);

  @override
  _LinesGraphWidgetState createState() => _LinesGraphWidgetState();
}

class _LinesGraphWidgetState extends State<LinesGraphWidget> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(enabled: true),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              widget.data.length,
                  (index) => FlSpot(index.toDouble(), widget.data[index]),
            ),
            color: Colors.blue,
          ),
        ],
        minY: 0,
        titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: bottomTitleWidgets,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: leftTitleWidgets,
              ),
            )),
        borderData: FlBorderData(
          show: true,
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('01', style: style);
        break;
      case 4:
        text = const Text('05', style: style);
        break;
      case 9:
        text = const Text('10', style: style);
        break;
      case 14:
        text = const Text('15', style: style);
        break;
      case 19:
        text = const Text('20', style: style);
        break;
      case 24:
        text = const Text('25', style: style);
        break;
      case 29:
        text = const Text('30', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black45,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text=value.toInt().toString();

    return Text(text, style: style, textAlign: TextAlign.left);
  }
}

