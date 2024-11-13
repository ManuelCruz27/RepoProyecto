import 'package:flutter/material.dart';

import 'GasLevelWarning.dart';
import 'InstallDeviceScreen.dart';
import 'InstallationSuccessScreen.dart';

class ConfirmacionPedidoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            SizedBox(height: 20),
            Center(
            child:Text(
              'Pedido aceptado',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
            ),
            SizedBox(height: 10),
            Icon(
              Icons.check,
              size: 50,
              color: Colors.black,
            ),
            SizedBox(height: 10),
            Text(
              'Tu pedido ha sido aceptado, si estás de acuerdo con el total, confirma tu abastecimiento',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Información del Trabajador
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Datos del Trabajador', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Nombre: Juan Pérez'),
                  Text('Teléfono: 555-1234'),
                  Text('Empresa: Gas Exprés'),
                  Text('Unidad: No. 45'),
                  Text('Precio del gas: \$15.00 por litro'),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Información del Pedido
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Datos del Pedido', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Cantidad solicitada: 20 litros'),
                  Text('Costo total: \$300.00'),
                  Text('Hora estimada de llegada: 15:30'),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Botones
            ElevatedButton(
              onPressed: () {
                // Acción para confirmar pedido
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InstallDeviceScreen()),
                );
              },
              child: Text('Confirmar Abastecimiento'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white, // Color del texto a blanco
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Acción para cancelar pedido
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GasLevelWarning()),
                );
              },
              child: Text('Cancelar Surtido'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black),
                foregroundColor: Colors.orange, // Color del texto a blanco
              ),
            ),
          ],
        ),
      ),
    );
  }
}
