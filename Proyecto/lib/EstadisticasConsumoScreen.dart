import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class EstadisticasConsumoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Sin sombra en la appBar
        title: Text('GASWISE', style: TextStyle(color: Colors.orange)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estadísticas de consumo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            SizedBox(height: 15),
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 100),
                        FlSpot(10, 80),
                        FlSpot(20, 60),
                        FlSpot(30, 40),
                        FlSpot(40, 20),
                        FlSpot(50, 10),
                      ],
                      isCurved: true,
                      color: Colors.orange,
                      barWidth: 4,
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toStringAsFixed(0),  // Formatear como entero
                            style: TextStyle(fontSize: 10, color: Colors.black),  // Estilo para los títulos
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toStringAsFixed(0),  // Formatear como entero
                            style: TextStyle(fontSize: 10, color: Colors.black),  // Estilo para los títulos
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Te quedarás sin gas en:',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                '90 días',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
