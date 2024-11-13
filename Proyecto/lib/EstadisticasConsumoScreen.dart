import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class EstadisticasConsumoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Título de la sección
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Estadísticas de consumo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ),

            // Gráfico de consumo con fl_chart
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    minY: 0,
                    maxY: 100,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: 10,
                          getTitlesWidget: (value, meta) {
                            return Text('${value.toInt()}%');
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            return Text('${value.toInt()}');
                          },
                        ),
                      ),
                    ),
                    gridData: FlGridData(show: true),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 100),
                          FlSpot(1, 95),
                          FlSpot(2, 90),
                          FlSpot(3, 85),
                          FlSpot(4, 75),
                          FlSpot(5, 65),
                          FlSpot(6, 55),
                          FlSpot(7, 45),
                          FlSpot(8, 35),
                          FlSpot(9, 25),
                          FlSpot(10, 15),
                          FlSpot(11, 5),
                        ],
                        isCurved: true,
                        color: Colors.orange,
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.orange.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Leyenda
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.black, size: 10),
                      SizedBox(width: 5),
                      Text("Transmisión del nivel de gas por día"),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.orange, size: 10),
                      SizedBox(width: 5),
                      Text("Alertas en el transcurso de 1 hr. máximo"),
                    ],
                  ),
                ],
              ),
            ),

            // Alerta de días restantes de gas
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.black, size: 50),
                  SizedBox(height: 10),
                  Text(
                    'Te quedarás sin gas en:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '90 días',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
