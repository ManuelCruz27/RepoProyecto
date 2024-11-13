import 'package:flutter/material.dart';

void main() {
  runApp(PedidoNoAceptado());
}

class PedidoNoAceptado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Container(
            width: 300, // Ajusta el ancho según sea necesario
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Título principal
                Text(
                  "No hay unidades\ndisponibles en este\nmomento",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),

                // Icono de cara triste
                Icon(
                  Icons.sentiment_dissatisfied,
                  size: 50,
                  color: Colors.black,
                ),
                SizedBox(height: 20),

                // Mensaje secundario
                Text(
                  "Por el momento no se encuentran unidades disponibles dentro de tu zona, ¡Puedes volver a intentarlo después de un rato!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 30),

                // Botón "Aceptar y salir"
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {
                    // Acción al presionar el botón
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Aceptar y salir",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
