const express = require('express');
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const { v4: uuidv4 } = require('uuid');

const app = express();
const PORT = process.env.PORT || 3000;
const SECRET_KEY = 'your_secret_key';

// Sample user data
const users = [
  { id: '1', username: 'admin', password: '$2b$10$CS8nUS3pItLhcvwMOW/wVOwJW9ETzbB42JATLZk.Tap.8NwTZVzom', role: 'admin' } // password: admin123
];

// Middleware for JSON body parsing
app.use(bodyParser.json());

// Middleware for authentication
const authenticateJWT = (req, res, next) => {
  const token = req.headers.authorization;
  if (!token) {
    return res.status(401).json({ message: 'Unauthorized' });
  }
  jwt.verify(token, SECRET_KEY, (err, user) => {
    if (err) {
      return res.status(403).json({ message: 'Forbidden' });
    }
    req.user = user;
    next();
  });
};

// Login endpoint
app.post('/login', (req, res) => {
  const { username, password } = req.body;
  const user = users.find(u => u.username === username);
  if (!user || !bcrypt.compareSync(password, user.password)) {
    return res.status(401).json({ message: 'Invalid username or password' });
  }
  const accessToken = jwt.sign({ username: user.username, role: user.role }, SECRET_KEY);
  res.json({ accessToken });
});

// Database management and API Gateway endpoints
// (Assuming routes for user management, inventory, sales, etc.)

// Sample route for user management
app.get('/users', authenticateJWT, (req, res) => {
  if (req.user.role !== 'admin') {
    return res.status(403).json({ message: 'Forbidden' });
  }
  // Logic for fetching users from the database
  res.json(users);
});

// Event-driven architecture (e.g., using EventEmitter)
// (Not implemented in this example)

// Plugin and Extension Framework
// (Not implemented in this example)

// Logging and Monitoring
// (Not implemented in this example)

// Integration with Third-Party Services
// (Not implemented in this example)

// Scalability and High Availability
// (Not implemented in this example)

// Security Measures
// (Implemented authentication, password hashing with bcrypt, but other security measures such as data encryption, API rate limiting, etc., need to be added)

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
