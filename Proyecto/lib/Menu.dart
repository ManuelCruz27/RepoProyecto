import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GasWise',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: GasWiseHome(),
    );
  }
}

class GasWiseHome extends StatelessWidget {
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
              title: Text('Ajustes'),
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
          'Bienvenido a Gas Wise, Alejandra!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
