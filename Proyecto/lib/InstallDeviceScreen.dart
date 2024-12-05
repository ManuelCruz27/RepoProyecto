import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Para abrir el video de YouTube
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart'; // Para escanear códigos QR y de barras

import 'InstallationSuccessScreen.dart';

class InstallDeviceScreen extends StatefulWidget {
  @override
  _InstallDeviceScreenState createState() => _InstallDeviceScreenState();
}

class _InstallDeviceScreenState extends State<InstallDeviceScreen> {
  // URL del video explicativo en YouTube
  final String videoUrl = "https://youtu.be/GQMlWwIXg3M?si=fgd_ARLxiTuKZEgL";

  // Controlador para el campo de texto del ID del dispositivo
  final TextEditingController _idController = TextEditingController();

  // Función para abrir el video de YouTube
  void _verVideo() async {
    Uri url = Uri.parse(videoUrl);
    if (await canLaunch(url.toString())) {
      await launch(url.toString(), forceWebView: true, forceSafariVC: true);
    } else {
      throw 'No se pudo abrir el video en $videoUrl';
    }
  }

  // Navegar a la pantalla de escaneo de QR
  void _abrirCamara(BuildContext context) async {
    String scanResult = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666", // Color del borde de la cámara
      "Cancelar", // Texto del botón para cancelar
      true, // Mostrar el botón de flash
      ScanMode.QR, // Modo de escaneo: QR
    );

    // Mostrar el resultado escaneado
    if (scanResult != "-1") {
      setState(() {
        // Asignar el código escaneado al TextField
        _idController.text = scanResult;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Código detectado: $scanResult'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Instala tu dispositivo',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _verVideo, // Abre el video explicativo
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text(
                    'Ver video explicativo',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Escanear código QR',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () => _abrirCamara(context), // Escanea el código QR
                  icon: Icon(Icons.camera_alt_outlined, color: Colors.orange),
                  label: Text(
                    'Abrir cámara',
                    style: TextStyle(color: Colors.orange),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.orange),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'ID del dispositivo',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _idController, // Usar el controlador
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InstallationSuccessScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  ),
                  child: Text(
                    'Instalar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
