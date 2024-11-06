import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Login.dart'; // Assuming Login and Registro_Screen are your login and registration screens
import 'Registro_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GasWise',
      theme: ThemeData(
        primarySwatch: Colors.orange, // Use orange as the primary color
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con degradado (solo para el manómetro)
          Positioned(
             // Adjust vertical position
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.orange, // Adjust orange shades as desired
                    Colors.deepOrange,
                  ],
                ),
              ),
              child: Image.asset(
                'assets/bg.png', // Replace with your background image
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Logo en la parte superior (más pequeño)
          Positioned(
            top: 50, // Adjust vertical position
            left: 20,
            right: 20,
            child: SizedBox(
              height: 200, // Adjust logo size
              width: 200, // Adjust logo size
              child: Image.asset(
                'assets/logo.png', // Replace with your logo image
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Sección del contenido (abajo)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Restrict column size
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text('Iniciar Sesión'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Use deep orange for button
                      foregroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('¿No tienes una cuenta?',
                  style: TextStyle(
                    color: Colors.white, // Establecemos el color del texto a blanco
                  ),
          ),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Registro_Screen()),
                          );
                        },
                        child: Text('Regístrate'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.orange, // Use deep orange for text
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}