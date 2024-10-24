import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Librería para realizar solicitudes HTTP
import 'package:proyecto/Login.dart';
import 'dart:async';
import 'package:proyecto/RecuperarContraseña.dart'; // Importa la pantalla para recuperar la contraseña
import 'package:proyecto/Registro_Screen.dart'; // Importa la pantalla de registro
import 'package:proyecto/Home.dart'; // Importa la pantalla principal
import 'package:proyecto/Menu.dart'; // Importa el menú de la aplicación
import 'package:shared_preferences/shared_preferences.dart'; // Importa SharedPreferences para almacenar datos localmente

// Función principal que inicializa la aplicación
void main() {
  runApp(GasWiseApp());
}

// Clase principal de la aplicación (GasWiseApp)
class GasWiseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuScreen(), // La pantalla inicial será la pantalla de login
    );
  }
}
class MenuScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
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
              child: Text('Inicio de sesion'),
            ),

          ],
        ),
      ),
    );
  }
}
