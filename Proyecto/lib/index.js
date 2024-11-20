const express = require('express'); // Importa Express para crear el servidor
const mysql = require('mysql'); // Importa MySQL para realizar consultas a la base de datos
const bodyParser = require('body-parser'); // Middleware para manejar JSON y datos en las peticiones
const bcrypt = require('bcryptjs'); // Importa bcryptjs para encriptar y comparar contraseñas
const crypto = require('crypto'); // Importa Crypto para generar tokens de recuperación de contraseña
const nodemailer = require('nodemailer'); // Importa Nodemailer para enviar correos electrónicos
const jwt = require('jsonwebtoken'); // Importa JWT para la autenticación basada en tokens
const fs = require('fs'); // Importa fs para leer los archivos del certificado
const https = require('https'); // Importa https para crear el servidor HTTPS
require('dotenv').config(); // Carga las variables de entorno desde un archivo .env
const cors = require('cors'); // Middleware para permitir solicitudes desde otros dominios (Cross-Origin Resource Sharing)

const secretKey = 'Super3quipo*'; // Clave secreta para firmar los tokens JWT (debe ser mantenida segura)
const app = express(); // Inicializa la aplicación de Express

// Habilita CORS y body-parser
app.use(cors());
app.use(bodyParser.json());

// Configura la conexión a la base de datos
const pool = mysql.createPool({
  connectionLimit: 10,
  host: 'bdgaswise.cdcyk6yawygn.us-east-2.rds.amazonaws.com',
  user: 'admin',
  password: 'Super3quipo*',
  database: 'DBGasWise',
  connectTimeout: 20000,
});

// Configuración del certificado SSL
// Cargar los archivos del certificado y la clave privada
const httpsOptions = {
  key: fs.readFileSync('../server.key'), // Ajusta esta ruta según la ubicación de server.key
  cert: fs.readFileSync('../server.cert') // Ajusta esta ruta según la ubicación de server.cert
};

º
// Rutas de ejemplo
app.get('/', (req, res) => {
  res.send('Servidor HTTPS funcionando correctamente');
});

// Ruta para registrar usuario
app.post('/register', async (req, res) => {
  const { nombre, email, contraseña } = req.body;

  if (!nombre || !email || !contraseña) {
    return res.status(400).send('Faltan datos obligatorios');
  }

  try {
    const hashedPassword = await bcrypt.hash(contraseña, 10);
    const query = 'INSERT INTO Usuario (Nombre, Email, Contraseña, PerfilID) VALUES (?, ?, ?, 2)';
    pool.query(query, [nombre, email, hashedPassword], (err) => {
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

// Ruta de inicio de sesión (login)
app.post('/login', (req, res) => {
  const { email, password } = req.body;

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
    try {
      const isMatch = await bcrypt.compare(password, usuario.Contraseña);
      if (!isMatch) {
        return res.status(401).send('Credenciales incorrectas');
      }

      const token = jwt.sign({ id: usuario.UsuarioID }, secretKey, { expiresIn: '1h' });
      res.json({ token, nombre: usuario.Nombre });
    } catch (err) {
      console.error('Error al comparar contraseñas:', err);
      return res.status(500).send('Error interno al procesar la solicitud.');
    }
  });
});

// Inicia el servidor HTTPS
https.createServer(httpsOptions, app).listen(3000, () => {
  console.log('Servidor HTTPS corriendo en el puerto 3000');
});
