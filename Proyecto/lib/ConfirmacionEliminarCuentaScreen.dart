import 'package:flutter/material.dart';

import 'EliminacionCuentaDialog.dart';

class EliminarCuentaDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, // Fondo blanco
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
      ),
      content: Container(
        padding: EdgeInsets.all(20.0),
        child: Text(
          '¿Estás seguro de eliminar la cuenta?',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EliminacionCuentaDialog()),
            );
          },
          child: Text('Confirmar', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Cierra el diálogo
          },
          child: Text('Cancelar', style: TextStyle(color: Colors.orange)),
        ),
      ],
    );
  }
}