import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:proyecto/RecuperarContraseña.dart';
import 'package:proyecto/Registro_Screen.dart';
import 'package:proyecto/main.dart';


class MenuPrincipal extends StatelessWidget {
  final String nombreUsuario;

  // Constructor que requiere el parámetro nombreUsuario
  MenuPrincipal({required this.nombreUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, //sin sombra en la appBar
        title: Text('GASWISE',style: TextStyle(color: Colors.orange)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.orange),
            onPressed: () {
              // Aquí puedes agregar la funcionalidad para el perfil
            },
          ),
        ],
      ),

      drawer: _buildDrawer(context), // Sección modularizada del Drawer
      body: Column(
        children: [
          // Círculo naranja de fondo
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange, // Color naranja
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(100), // Crea el círculo invertido
                  ),
                ),
              ),
              Positioned(
                top: 50, // Ajusta la posición según sea necesario
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    /*Image.asset(
                      'assets/logo.png', // Cambia esto por tu imagen del logo
                      height: 100,
                    ),*/
                    Text(
                      'Bienvenido a Gas Wise',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$nombreUsuario',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Resto del contenido debajo del círculo
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Nivel del tanque',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  // Función para construir el Drawer
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
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
            leading: Icon(Icons.shopping_cart),
            title: Text('Solicitar pedido'),
            onTap: () {
              // Agrega navegación o funcionalidad aquí
            },
          ),
          ListTile(
            leading: Icon(Icons.local_shipping),
            title: Text('Seguimiento de pedido'),
            onTap: () {
              // Agrega navegación o funcionalidad aquí
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar Sesión'),
            onTap: () async {
              // Funcionalidad de cerrar sesión
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('token'); // Elimina el token de sesión

              // Redirigir a la pantalla de inicio de sesión
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()), // Ajusta con tu pantalla de login
              );
            },
          ),
        ],
      ),
    );
  }
}