import 'package:flutter/material.dart';

class EliminacionCuentaDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            size: 48,
            color: Colors.green,
          ),
          SizedBox(height: 16),
          Text(
            '¡Has eliminado la cuenta de manera exitosa!',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Agradecemos tu estadía en nuestra App',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Aquí puedes implementar la lógica para cerrar la sesión del usuario y redirigirlo a la pantalla de inicio de sesión
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/Login.dart', // Reemplaza '/login' con la ruta de tu pantalla de inicio de sesión
                  (route) => false,
            );
          },
          child: Text(
            'Continuar y salir de la aplicación',
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ],
    );
  }
}