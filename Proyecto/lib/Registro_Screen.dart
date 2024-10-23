import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:crypto/crypto.dart'; // Importamos la librería crypto para encriptar

// Pantalla de Registro
class Registro_Screen extends StatefulWidget {
  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}
// Pantalla de Registro (sin hash en el cliente)
class _RegistroScreenState extends State<Registro_Screen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObscure = true;
  double _passwordStrength = 0.0;

  bool validarContrasena(String password) {
    bool tieneMinimo6Caracteres = password.length >= 6;
    bool tieneMayuscula = password.contains(RegExp(r'[A-Z]'));
    bool tieneMinuscula = password.contains(RegExp(r'[a-z]'));
    bool tieneNumero = password.contains(RegExp(r'[0-9]'));
    bool tieneCaracterEspecial = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return tieneMinimo6Caracteres && tieneMayuscula && tieneMinuscula && tieneNumero && tieneCaracterEspecial;
  }

  void _actualizarFuerzaContrasena(String password) {
    double fuerza = 0.0;

    if (password.length >= 6) fuerza += 0.2;
    if (password.contains(RegExp(r'[A-Z]'))) fuerza += 0.2;
    if (password.contains(RegExp(r'[a-z]'))) fuerza += 0.2;
    if (password.contains(RegExp(r'[0-9]'))) fuerza += 0.2;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) fuerza += 0.2;

    setState(() {
      _passwordStrength = fuerza;
    });
  }

  Future<void> _registrarUsuario() async {
    String nombre = nombreController.text;
    String correo = correoController.text;
    String password = passwordController.text;

    if (nombre.isEmpty || correo.isEmpty || password.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, completa todos los campos')),
        );
      }
      return;
    }

    if (!validarContrasena(password)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('La contraseña debe tener al menos 6 caracteres, con mayúsculas, minúsculas, números y símbolos.')),
        );
      }
      return;
    }

    final Map<String, dynamic> requestBody = {
      'nombre': nombre,
      'email': correo,
      'contraseña': password,  // Enviar la contraseña en texto plano
    };

    try {
      final response = await http.post(
        Uri.parse('http://192.168.100.19:3000/register'), // la IPv4 cambia dependiendo de la red que estés conectado
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Usuario registrado con éxito')),
          );
        }
        Navigator.pop(context); // Redirigir al inicio de sesión después del registro
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al registrar usuario: ${response.statusCode}')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al conectar con el servidor')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Registro de Usuario', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            TextField(
              controller: correoController,
              decoration: InputDecoration(labelText: 'Correo', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: _isObscure,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              onChanged: _actualizarFuerzaContrasena,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: !_isObscure,
                  activeColor: Colors.green,
                  onChanged: (bool? value) {
                    setState(() {
                      _isObscure = !value!;
                    });
                  },
                ),
                Expanded(child: Text('Mostrar Contraseña')),
              ],
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: _passwordStrength,
              backgroundColor: Colors.redAccent,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              minHeight: 10,
            ),
            SizedBox(height: 20),
            Text(
              'La contraseña debe cumplir con los siguientes requisitos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Al menos 6 caracteres'),
            Text('Una letra mayúscula'),
            Text('Una letra minúscula'),
            Text('Un número'),
            Text('Un símbolo especial (ej: !@#/&*^)'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registrarUsuario,
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
