import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/HistorialPedidosScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:proyecto/RecuperarContraseña.dart';
import 'package:proyecto/Registro_Screen.dart';
import 'package:proyecto/main.dart';
import 'ConfigurarContrasena.dart';
import 'ConfigurarDispositivo.dart';
import 'EstadisticasConsumoScreen.dart';
import 'Login.dart';
import 'SeguimientoPedidoScreen.dart';
import 'SolicitarPedidoScreen.dart';

class MenuPrincipal extends StatelessWidget {
  final String nombreUsuario;

  // Constructor que requiere el parámetro nombreUsuario
  MenuPrincipal({required this.nombreUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Sin sombra en la appBar
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.orange),
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PerfilScreen()),
                );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context), // Sección modularizada del Drawer
      body: SingleChildScrollView(
        child: Column(
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
                      bottom: Radius.circular(100), // Círculo invertido
                    ),
                  ),
                ),
                Positioned(
                  top: 40, // Ajusta la posición según sea necesario
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/logo.png', // Cambia esto por tu imagen del logo
                        height: 130,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Nivel del tanque
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  SizedBox(height: 10),

                  Text(
                    'Bienvenido a Gas Wise',
                    style: TextStyle(
                      color: Colors.orange,
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

                  SizedBox(height: 10),

                  Text(
                    'Nivel del tanque',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '70%', // Aquí se mostrará el nivel del tanque (extraído de la BD)
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Última lectura',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today, color: Colors.orange),
                      SizedBox(width: 5),
                      Text('12/12/24'), // Fecha de la última lectura
                      SizedBox(width: 15),
                      Icon(Icons.access_time, color: Colors.orange),
                      SizedBox(width: 5),
                      Text('12:00 pm'), // Hora de la última lectura
                    ],
                  ),
                ],
              ),
            ),
            // Sección de estadísticas de consumo
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatisticRow(
                      'Promedio consumo diario',
                      '34.15 lts', // Este valor se extraerá de la BD
                    ),
                    Divider(),
                    _buildStatisticRow(
                      'Sin gas en:',
                      '+90 días', // Este valor se extraerá de la BD
                      icon: Icons.info_outline,
                    ),
                    Divider(),
                    _buildStatisticRow(
                      'Capacidad del tanque',
                      '1,000 lts', // Este valor se extraerá de la BD
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
            leading: Icon(Icons.construction),
            title: Text('Configuracion de tanque'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfiguracionDispositivoScreen()),
              );
            },

          ),
          ListTile(
            leading: Icon(Icons.assessment),
            title: Text('Consumo Diario'),
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EstadisticasConsumoScreen()),
                );
              },

          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Historial de pedidos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistorialPedidosScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Solicitar pedido'),
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SolicitudPedidoScreen()),
                );
            },
          ),
          ListTile(
            leading: Icon(Icons.local_shipping),
            title: Text('Seguimiento de pedido'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SeguimientoPedidoScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar Sesión'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('token'); // Elimina el token de sesión

              // Redirigir a la pantalla de inicio de sesión
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  // Widget helper para construir cada fila de estadísticas
  Widget _buildStatisticRow(String label, String value, {IconData? icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null) Icon(icon, color: Colors.orange),
            if (icon != null) SizedBox(width: 5),
            Text(label),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
