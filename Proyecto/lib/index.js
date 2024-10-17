const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const bcrypt = require('bcrypt');
const crypto = require('crypto');
const nodemailer = require('nodemailer');
require('dotenv').config();
const cors = require('cors');


const app = express();

app.use(cors());
app.use(bodyParser.json());

console.log('GMAIL_USER:', process.env.GMAIL_USER);
console.log('GMAIL_PASS:', process.env.GMAIL_PASS);


const pool = mysql.createPool({
  connectionLimit: 10,
  host: 'bdgaswise.cdcyk6yawygn.us-east-2.rds.amazonaws.com',
  user: 'admin',
  password: 'Super3quipo*',
  database: 'DBGasWise',
  connectTimeout: 20000 // Tiempo de espera aumentado a 20 segundos
});


app.listen(3000, () => {
  console.log('Servidor corriendo en el puerto 3000');
});

// Registro de usuario con contraseña encriptada
app.post('/register', async (req, res) => {
  const { nombre, email, contraseña } = req.body;

  if (!nombre || !email || !contraseña) {
    return res.status(400).send('Faltan datos obligatorios');
  }

  try {
    // Encriptar la contraseña
    const hashedPassword = await bcrypt.hash(contraseña, 10);

    const query = 'INSERT INTO Usuario (Nombre, Email, Contraseña) VALUES (?, ?, ?)';
    pool.query(query, [nombre, email, hashedPassword], (err, result) => {
      if (err) {
        console.error('Error al insertar usuario:', err);
        return res.status(500).send('Error al registrar usuario');
      }
      res.send('Usuario registrado con éxito');
    });
  } catch (err) {
    console.error('Error al encriptar la contraseña:', err);
    res.status(500).send('Error interno al procesar la solicitud');
  }
});

// Login con comparación de contraseña encriptada
app.post('/login', (req, res) => {
  const { email, password } = req.body;  // Asegúrate de usar 'password'

  // Verificar que los campos no estén vacíos
  if (!email || !password) {
    return res.status(400).send('Faltan datos obligatorios');
  }

  const query = 'SELECT * FROM Usuario WHERE Email = ?';
  pool.query(query, [email], async (err, result) => {
    if (err) {
      return res.status(500).send('Error al buscar usuario');
    }

    if (result.length === 0) {
      return res.status(401).send('Credenciales incorrectas');
    }

    const usuario = result[0];

    // Verifica si la contraseña almacenada existe
    if (!usuario.Contraseña) {
      return res.status(500).send('Error: No se encontró la contraseña en la base de datos.');
    }

    // Compara la contraseña encriptada
    try {
      const isMatch = await bcrypt.compare(password, usuario.Contraseña);  // Usar 'password' recibido
      console.log('Resultado de la comparación:', isMatch);

      if (!isMatch) {
        return res.status(401).send('Credenciales incorrectas');
      }

      res.json({ nombre: usuario.Nombre });
    } catch (err) {
      console.error('Error al comparar contraseñas:', err);
      return res.status(500).send('Error interno al procesar la solicitud.');
    }
  });
});

/*app.post('/login', (req, res) => {
  const { email, contraseña } = req.body;

    console.log('Email. recibido: ', email);
    console.log('Contraseña recibida: ', contraseña);

  const query = 'SELECT * FROM Usuario WHERE Email = ?';
   pool.query(query, [email], async (err, result) => {
      if (err) {
        console.error('Error al buscar usuario:', err);
        return res.status(500).send('Error al buscar usuario');
      }

     if (result.length === 0) {
          console.log('No se encontró usuario con ese correo.');
          return res.status(401).send('Credenciales incorrectas');
        }

        const usuario = result[0];
        console.log('Usuario encontrado:', usuario);

     // Asegúrate de que la contraseña encriptada existe
        if (!usuario.Contraseña) {
          console.error('Error: No se encontró la contraseña en la base de datos.');
          return res.status(500).send('Error: No se encontró la contraseña en la base de datos.');
        }

    console.log('Hash de la contraseña almacenada:', usuario.Contraseña);

    try {
      // Compara la contraseña ingresada con el hash almacenado
      const isMatch = await bcrypt.compare(contraseña, usuario.Contraseña);
      console.log('Resultado de la comparación:', isMatch);

      if (!isMatch) {
        return res.status(401).send('Credenciales incorrectas');
      }

      res.json({ nombre: usuario.Nombre });
    } catch (e) {
      console.error('Error al comparar contraseñas:', e);
      return res.status(500).send('Error al comparar contraseñas');
    }
  });
});
*/


// Configurar transporte de Nodemailer para enviar correos



// Crear el transporte de nodemailer
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: process.env.GMAIL_USER, // Tu correo de Gmail
    pass: process.env.GMAIL_PASS  // La contraseña de aplicación generada
  }
});


// Ruta para solicitar la recuperación de contraseña
app.post('/solicitar-recuperacion', (req, res) => {
  const { email } = req.body;

  pool.query('SELECT * FROM Usuario WHERE Email = ?', [email], (err, result) => {
    if (err) {
      console.error('Error del servidor:', err);  // Captura el error en la consola
      return res.status(500).send('Error del servidor');
    }

    if (result.length === 0) {
      console.log('No se encontró ninguna cuenta con este correo');
      return res.status(404).send('No se encontró ninguna cuenta con este correo');
    }

    const token = crypto.randomBytes(20).toString('hex');
    const expiration = new Date();
    expiration.setHours(expiration.getHours() + 1);

    const query = 'UPDATE Usuario SET resetPasswordToken = ?, resetPasswordExpires = ? WHERE Email = ?';
    pool.query(query, [token, expiration, email], (err, result) => {
      if (err) {
        console.error('Error al guardar el token:', err);  // Captura el error
        return res.status(500).send('Error al guardar el token');
      }

      const mailOptions = {
        from: process.env.GMAIL_USER,
        to: email,
        subject: 'Recuperación de Contraseña',
        text: `Has solicitado restablecer tu contraseña. Haz clic en el siguiente enlace para continuar:
        http://localhost:3000/reset-password/${token}`
      };

      transporter.sendMail(mailOptions, (err, info) => {
        if (err) {
          console.error('Error al enviar el correo:', err);  // Captura el error
          return res.status(500).send('Error al enviar el correo');
        }

        console.log('Correo enviado con éxito:', info.response);
        res.send('Se ha enviado un correo con las instrucciones para restablecer la contraseña');
      });
    });
  });
});

// Ruta para restablecer la contraseña
app.post('/reset-password/:token', (req, res) => {
  const { token } = req.params;
  const { newPassword } = req.body;

  const query = 'SELECT * FROM Usuario WHERE resetPasswordToken = ? AND resetPasswordExpires > NOW()';
  pool.query(query, [token], async (err, result) => {
    if (err) {
      return res.status(500).send('Error del servidor');
    }

    if (result.length === 0) {
      return res.status(400).send('Token inválido o expirado');
    }

    const usuario = result[0];
    const hashedPassword = await bcrypt.hash(newPassword, 10);

    const updateQuery = 'UPDATE Usuario SET Contraseña = ?, resetPasswordToken = NULL, resetPasswordExpires = NULL WHERE Email = ?';
    pool.query(updateQuery, [hashedPassword, usuario.Email], (err, result) => {
      if (err) {
        return res.status(500).send('Error al actualizar la contraseña');
      }

      res.send('Contraseña actualizada con éxito');
    });
  });
});

app.listen(3001, () => {
  console.log('Servidor corriendo en el puerto 3001');
});

