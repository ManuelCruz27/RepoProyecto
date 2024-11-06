import 'package:flutter/material.dart';

void main() {
  runApp(GasWiseApp());
}

class GasWiseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.orange,
          selectionColor: Colors.orange.withOpacity(0.3), // Color de selección
          selectionHandleColor: Colors.orange,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white, // Fondo blanco para todos los TextFields
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange), // Borde naranja al enfocar
          ),
        ),
      ),
      home: HistorialPedidosScreen(),
    );
  }
}

class HistorialPedidosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Historial de pedidos',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar por fecha',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              keyboardType: TextInputType.datetime,
              onSubmitted: (value) {
                // Acción para buscar pedidos por fecha
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView(
                  children: [
                    PedidoItem(
                      fecha: 'Fecha de surtido',
                      hora: 'Hora',
                      litros: 'Cantidad de litros surtidos',
                      trabajador: 'Trabajador que surtió el pedido',
                      unidad: 'No. unidad',
                      telefono: 'Teléfono',
                    ),
                    // Aquí puedes añadir más instancias de PedidoItem para cada pedido encontrado
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PedidoItem extends StatelessWidget {
  final String fecha;
  final String hora;
  final String litros;
  final String trabajador;
  final String unidad;
  final String telefono;

  PedidoItem({
    required this.fecha,
    required this.hora,
    required this.litros,
    required this.trabajador,
    required this.unidad,
    required this.telefono,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: fecha,
          decoration: InputDecoration(
            labelText: 'Fecha de surtido',
            border: OutlineInputBorder(),
          ),
          readOnly: true,
        ),
        SizedBox(height: 10),
        TextFormField(
          initialValue: hora,
          decoration: InputDecoration(
            labelText: 'Hora',
            border: OutlineInputBorder(),
          ),
          readOnly: true,
        ),
        SizedBox(height: 10),
        TextFormField(
          initialValue: litros,
          decoration: InputDecoration(
            labelText: 'Cantidad de litros surtidos',
            border: OutlineInputBorder(),
          ),
          readOnly: true,
        ),
        SizedBox(height: 10),
        TextFormField(
          initialValue: trabajador,
          decoration: InputDecoration(
            labelText: 'Trabajador que surtió el pedido',
            border: OutlineInputBorder(),
          ),
          readOnly: true,
        ),
        SizedBox(height: 10),
        TextFormField(
          initialValue: unidad,
          decoration: InputDecoration(
            labelText: 'No. unidad',
            border: OutlineInputBorder(),
          ),
          readOnly: true,
        ),
        SizedBox(height: 10),
        TextFormField(
          initialValue: telefono,
          decoration: InputDecoration(
            labelText: 'Teléfono',
            border: OutlineInputBorder(),
          ),
          readOnly: true,
        ),
        Divider(height: 30, color: Colors.grey),
      ],
    );
  }
}
