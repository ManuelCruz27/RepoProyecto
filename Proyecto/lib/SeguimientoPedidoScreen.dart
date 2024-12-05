import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Home.dart';

class SeguimientoPedidoScreen extends StatefulWidget {
  @override
  _SeguimientoPedidoScreenState createState() => _SeguimientoPedidoScreenState();
}

class _SeguimientoPedidoScreenState extends State<SeguimientoPedidoScreen> {
  late GoogleMapController mapController;

  final LatLng _initialPosition = LatLng(19.4326, -99.1332); // Coordenadas iniciales (CDMX)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Seguimiento de pedido',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '####',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),

            // Google Map
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black12),
                ),
                child: GoogleMap(
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 14.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId("pedido"),
                      position: _initialPosition, // Posición inicial del pedido
                      infoWindow: InfoWindow(title: "Pedido Actual"),
                    ),
                  },
                ),
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuPrincipal(nombreUsuario: ''),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Salir',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Si decides salir de esta sección, puedes volver a ella desde el menú lateral seleccionado "SEGUIMIENTO DE PEDIDO"',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
