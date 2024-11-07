import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConfiguracionDispositivoScreen(),
    );
  }
}

class ConfiguracionDispositivoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Configuración del dispositivo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24),
            _buildTextField('Nombre del dispositivo'),
            SizedBox(height: 16),
            _buildDropdown('Cantidad del tanque (lts)'),
            SizedBox(height: 16),
            _buildDropdown('Hora de transmisión'),
            SizedBox(height: 16),
            _buildDropdown('Nivel de alarma de gas bajo'),
            SizedBox(height: 32),
            _buildButton(context, 'Guardar', Colors.orange),
            SizedBox(height: 16),
            _buildButton(context, 'Cancelar', Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: [
        DropdownMenuItem(value: '1', child: Text('Opción 1')),
        DropdownMenuItem(value: '2', child: Text('Opción 2')),
      ],
      onChanged: (value) {
        // Acción al cambiar la selección
      },
    );
  }

  Widget _buildButton(BuildContext context, String text, Color color) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          // Acción al presionar el botón
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
