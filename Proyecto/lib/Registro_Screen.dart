import 'dart:convert';
import 'dart:io'; // Para HttpOverrides
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Pantalla de Registro
class Registro_Screen extends StatefulWidget {
  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

// HttpOverrides para aceptar certificados autofirmados
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

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

    return tieneMinimo6Caracteres &&
        tieneMayuscula &&
        tieneMinuscula &&
        tieneNumero &&
        tieneCaracterEspecial;
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
          SnackBar(
              content: Text(
                  'La contraseña debe tener al menos 6 caracteres, con mayúsculas, minúsculas, números y símbolos.')),
        );
      }
      return;
    }

    final Map<String, dynamic> requestBody = {
      'nombre': nombre,
      'email': correo,
      'contraseña': password,
    };

    try {
      final response = await http.post(
        Uri.parse('https://192.168.100.27:3000/register'), // Cambié a https
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
            SnackBar(
                content: Text(
                    'Error al registrar usuario: ${response.statusCode} - ${response.reasonPhrase}')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al conectar con el servidor: $e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    HttpOverrides.global = MyHttpOverrides(); // Acepta certificados autofirmados
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // **Fondo e Imagen de Cabecera**
          Positioned(
            top: -90,
            left: 0,
            right: 0,
            child: ClipOval(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Image.asset(
                  'assets/bg1.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 35,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/logo.png', fit: BoxFit.contain),
            ),
          ),
          // **Formulario de Registro**
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 180),
                  TextField(
                    controller: nombreController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: correoController,
                    decoration: InputDecoration(
                      labelText: 'Correo',
                      border: OutlineInputBorder(),
                    ),
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
                  ElevatedButton(
                    onPressed: _registrarUsuario,
                    child: Text('Registrar'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.orange,
                    ),
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
