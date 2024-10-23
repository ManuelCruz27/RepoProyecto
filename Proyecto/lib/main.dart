import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:proyecto/MenuScreen.dart';
import 'package:proyecto/RecuperarContraseña.dart';
import 'package:proyecto/Registro_Screen.dart';
import 'package:proyecto/Home.dart';
import 'package:proyecto/Menu.dart';


void main() {
  runApp(GasWiseApp());
}

class GasWiseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObscure = true; // Controla si se muestra la contraseña

  Future<void> _inicioSesion() async {
    String correo = correoController.text;
    String password = passwordController.text;

    if (correo.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
      return;
    }

    final Map<String, dynamic> requestBody = {
      'email': correo,
      'password': password // Corregido a 'password'
    };

    print('Correo: ${correoController.text}');
    print('Contraseña: ${passwordController.text}');

    try {
      // Realiza la petición HTTP POST para iniciar sesión
      final response = await http.post(
        Uri.parse('http://192.168.100.19:3000/login'), // la IPv4 cambia dependiendo de la red que estés conectado
        headers: {'Content-Type': 'application/json'}, // Cabeceras de la solicitud
        body: jsonEncode(requestBody), // Convierte el cuerpo de la solicitud a JSON
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Si la respuesta es exitosa (código 200)
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Decodifica el cuerpo de la respuesta

        // Verifica si en la respuesta existe el campo 'nombre'
        if (data.containsKey('nombre')) {
          final String nombreUsuario = data['nombre']; // Obtiene el nombre del usuario
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MenuPrincipal(nombreUsuario: nombreUsuario)), // Navega a la pantalla del menú
          );
        } else {
          // Muestra un error si no se encuentra el campo 'nombre' en la respuesta
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: No se encontró el campo "nombre".')),
          );
        }
      } else {
        // Muestra un error si el código de estado no es 200
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión: ${response.statusCode}')),
        );
      }
    } catch (e) {
      // Muestra un mensaje de error si falla la conexión con el servidor
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al conectar con el servidor')),
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
              // Imagen superior del tanque de gas y el logo de Gas Wise
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[300],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'GasWise',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Gas siempre a la vista',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Tabs de Login/Sign Up
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
                        backgroundColor: Colors.orange, // Color para Log in
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Iniciar sesión'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Registro_Screen()),
                        ); // Reemplaza 'FormularioPage' por la página de tu formulario
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Color para Sign up
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
              // Bienvenida y campos de texto
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenido a Gas Wise',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: correoController,
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                      obscureText: _isObscure,
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _inicioSesion, // Ejecuta la función de inicio de sesión
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        child: Text('Iniciar sesión'),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => GasWiseHome()),
                              (Route<dynamic> route) => false,
                        );
                      },
                      child: Text('Home'),
                    ),

                    SizedBox(height: 20),
                    // Botón para recuperar la contraseña
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecuperarContrasena(),
                          ),
                        );
                      },
                      child: Text(
                        'Olvidé mi contraseña',
                        style: TextStyle(color: Colors.orange),
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


/*
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App de Inicio de Sesión',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObscure = true; // Controla si se muestra la contraseña

  Future<void> _inicioSesion() async {
    String correo = correoController.text;
    String password = passwordController.text;

    if (correo.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    final Map<String, dynamic> requestBody = {
      'email': correo, // Asegúrate que este campo esté bien
      'contraseña': password // Y este también
    };

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey('nombre')) {
          final String nombreUsuario = data['nombre'];
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MenuScreen(nombreUsuario: nombreUsuario)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: No se encontró el campo "nombre".')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al conectar con el servidor')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bienvenido',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: correoController,
                decoration: InputDecoration(labelText: 'Correo electrónico'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: _isObscure,
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
              ElevatedButton(
                onPressed: _inicioSesion,
                child: Text('Iniciar sesión'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registro_Screen()),
                  );
                },
                child: Text('¿No tienes una cuenta? Regístrate aquí'),
              ),


              SizedBox(height: 20),
              TextButton(onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder:
                (context) => RecuperarContrasena()),
                );
              },
               child: Text('Olvide mi contraseña'),
               ),

            ],
          ),
        ),
      ),
    );
  }
}



*/