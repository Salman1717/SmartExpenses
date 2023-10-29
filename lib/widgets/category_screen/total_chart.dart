import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/database_provider.dart';

class TotalChart extends StatefulWidget {
  const TotalChart({super.key});

  @override
  State<TotalChart> createState() => _TotalChartState();
}

class _TotalChartState extends State<TotalChart> {
  // final List<Color> pieColors = [
  //   Color(0xFFc78a44),
  //   Color(0xff1b1719),
  //   Color(0xFF393d3a),
  //   Color(0xff3f5843),
  //   Color(0xFFb69b7d),
  //   Color(0xFF4d1635),
  //   // Add more monochromatic colors as needed
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white60.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),

        ),
        child: Consumer<DatabaseProvider>(builder: (_, db, __) {
          var list = db.categories;
          var total = db.calculateTotalExpenses();
          return Row(
            children: [
              Expanded(
                flex: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      alignment: Alignment.center,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Total Expenses: ${NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(total)}',
                        textScaleFactor: 1.5,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ...list.map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            Container(
                              width: 8.0,
                              height: 8.0,
                              color: Colors.primaries[list.indexOf(e)],
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              e.title,
                            ),
                            const SizedBox(width: 5.0),
                            Text(total == 0
                                ? '0%'
                                : '${((e.totalAmount / total) * 100).toStringAsFixed(2)}%'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 30,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 10.0,
                    sections: total != 0
                        ? list
                            .map(
                              (e) => PieChartSectionData(
                                showTitle: false,
                                value: e.totalAmount,
                                color: Colors.primaries[list.indexOf(e)],
                              ),
                            )
                            .toList()
                        : list
                            .map(
                              (e) => PieChartSectionData(
                                showTitle: false,
                                color: Colors.primaries[list.indexOf(e)],
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
