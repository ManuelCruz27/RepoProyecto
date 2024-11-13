import 'package:flutter/material.dart';
import 'ConfirmacionPedidoScreen.dart';
import 'PedidoNoAceptado.dart';

void main() {
  runApp(GasWiseApp());
}

class GasWiseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SolicitudPedidoScreen(),
    );
  }
}

class SolicitudPedidoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Solicitar pedido',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // Aquí se agrega el SingleChildScrollView
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Completa la información para solicitar un pedido',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Cantidad de litros',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Dirección',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.blueAccent),
                  backgroundColor: Colors.blueAccent,
                  minimumSize: Size(double.infinity, 50), // Ajustado para un botón más grande
                  padding: EdgeInsets.symmetric(horizontal: 40), // Espacio alrededor del texto
                ),
                child: Text(
                  'Usar ubicación actual',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Tipo de pago',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
              items: <String>['Efectivo', 'Tarjeta', 'Transferencia']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                // Acción para seleccionar tipo de pago
              },
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Comentarios',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20), // Ajusta el tamaño del espacio para evitar el overflow
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConfirmacionPedidoScreen()),
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.orange),
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 50), // Ancho del botón al máximo del contenedor
                padding: EdgeInsets.symmetric(horizontal: 40), // Espacio alrededor del texto
              ),
              child: Text(
                'Solicitar pedido',
                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
