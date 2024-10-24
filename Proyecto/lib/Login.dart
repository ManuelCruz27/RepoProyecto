import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:crypto/crypto.dart'; // Importamos la librería crypto para encriptar
import 'package:proyecto/Home.dart';
import 'package:proyecto/main.dart';
import 'package:proyecto/Home.dart';
import 'package:proyecto/Registro_Screen.dart'; // Importa la pantalla de registro
import 'package:shared_preferences/shared_preferences.dart'; // Importa SharedPreferences para almacenar datos localmente


// Clase que define el estado de la pantalla de inicio de sesión (LoginScreen)
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores para los campos de correo y contraseña
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Variable para controlar la visibilidad de la contraseña
  bool _isObscure = true;

  // Función asincrónica que maneja el inicio de sesión
  Future<void> _inicioSesion() async {
    String correo = correoController.text; // Obtiene el valor del campo de correo
    String password = passwordController.text; // Obtiene el valor del campo de contraseña

    // Verifica si ambos campos están llenos
    if (correo.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos.')), // Muestra un mensaje si faltan datos
      );
      return;
    }

    // Construye el cuerpo de la solicitud HTTP con los datos del usuario
    final Map<String, dynamic> requestBody = {
      'email': correo,
      'password': password
    };

    try {
      // Realiza la solicitud HTTP POST para iniciar sesión
      final response = await http.post(
        Uri.parse('http://192.168.100.19:3000/login'), // Cambia esta URL según tu configuración
        headers: {'Content-Type': 'application/json'}, // Cabecera para indicar que el contenido es JSON
        body: jsonEncode(requestBody), // Convierte el cuerpo de la solicitud a JSON
      );

      print('Response status: ${response.statusCode}'); // Imprime el estado de la respuesta (ej. 200)
      print('Response body: ${response.body}'); // Imprime el cuerpo de la respuesta

      // Si la respuesta es exitosa (código 200)
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Decodifica el cuerpo de la respuesta

        // Verifica si en la respuesta existen los campos 'token' y 'nombre'
        if (data.containsKey('token') && data.containsKey('nombre')) {
          final String token = data['token']; // Obtiene el token del usuario
          final String nombreUsuario = data['nombre']; // Obtiene el nombre del usuario

          // Almacena el token y el nombre del usuario en SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token); // Almacena el token
          await prefs.setString('nombreUsuario', nombreUsuario); // Almacena el nombre del usuario

          print(token);
          print('Nombre de usuario: ' + nombreUsuario);

          // Navega a la pantalla del menú principal, pasando el nombre del usuario
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MenuPrincipal(nombreUsuario: nombreUsuario), // Pasa el nombre del usuario
            ),
          );
        } else {
          // Muestra un mensaje de error si no se encuentran los campos 'token' o 'nombre'
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: No se encontró el campo "token" o "nombre".')),
          );
        }
      } else {
        // Muestra un mensaje de error si la respuesta no es exitosa
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error: $e'); // Imprime el error en la consola
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al conectar con el servidor')), // Muestra un mensaje de error si falla la conexión
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Encabezado con el logo y título de la aplicación
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[300], // Color de fondo del encabezado
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'GasWise', // Título de la aplicación
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Color del texto
                      ),
                    ),
                    Text(
                      'Gas siempre a la vista', // Subtítulo de la aplicación
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Botones para iniciar sesión y registrarse
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Color para el botón de iniciar sesión
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Iniciar sesión'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navega a la pantalla de registro
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Registro_Screen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Color para el botón de registrarse
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Registrarse'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Sección de bienvenida y campos de entrada para correo y contraseña
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenido a Gas Wise', // Mensaje de bienvenida
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: correoController, // Campo de texto para el correo
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: passwordController, // Campo de texto para la contraseña
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off), // Icono para mostrar/ocultar la contraseña
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure; // Cambia el estado de visibilidad de la contraseña
                            });
                          },
                        ),
                      ),
                      obscureText: _isObscure, // Si es verdadero, la contraseña se oculta
                    ),
                    SizedBox(height: 20),
                    // Botón para iniciar sesión
                    Center(
                      child: ElevatedButton(
                        onPressed: _inicioSesion, // Llama a la función para iniciar sesión
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        child: Text('Iniciar sesión'), // Texto del botón
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
