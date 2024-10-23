import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:proyecto/MenuScreen.dart';
import 'package:proyecto/RecuperarContraseña.dart';
import 'package:proyecto/Registro_Screen.dart';

class MenuPrincipal extends StatelessWidget {
  final String nombreUsuario;

  // Constructor que requiere el parámetro nombreUsuario
  MenuPrincipal({required this.nombreUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GASWISE'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Aquí puedes agregar la funcionalidad para el perfil
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text(
                'GasWise Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Text(
              'Hola, $nombreUsuario!',  // Uso del nombreUsuario
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                Navigator.pop(context); // Para cerrar el menú después de selección
              },
            ),
            ListTile(
              leading: Icon(Icons.assessment),
              title: Text('Consumo Diario'),
              onTap: () {
                // Agrega navegación o funcionalidad aquí
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Historial de Consumo'),
              onTap: () {
                // Agrega navegación o funcionalidad aquí
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Solicitar pedido'),
              onTap: () {
                // Agrega navegación o funcionalidad aquí
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Seguimiento de pedido'),
              onTap: () {
                // Agrega navegación o funcionalidad aquí
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar Sesión'),
              onTap: () {
                // Agrega navegación o funcionalidad aquí
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Bienvenido a Gas Wise, $nombreUsuario!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
