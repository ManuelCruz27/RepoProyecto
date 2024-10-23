import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:crypto/crypto.dart'; // Importamos la librería crypto para encriptar
import 'package:proyecto/Home.dart';
import 'package:proyecto/main.dart';
import 'package:proyecto/Home.dart';
// Pantalla principal a la que se redirige después de iniciar sesión.
class MenuScreen extends StatelessWidget {
  final String nombreUsuario;

  MenuScreen({required this.nombreUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hola, $nombreUsuario!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false,
                );
              },
              child: Text('Volver al Inicio'),
            ),

          ],
        ),
      ),
    );
  }
}
