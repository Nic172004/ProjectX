const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const mysql = require('mysql2/promise');
const bcrypt = require('bcrypt');

// WARNING: There are duplicate server files! This one and server/server.js
// Make sure only one server is running to avoid duplicate login handlers
console.warn('WARNING: Multiple server files detected! This server.js conflicts with server/server.js');
console.warn('Only one server should be running to avoid duplicate login handlers');

const app = express();
const PORT = 8080;

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// MySQL connection pool
const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'projectx',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Helper function to log user actions
function logUserAction(username, actionType, status = null, details = null) {
  const timestamp = new Date().toISOString().slice(0, 19).replace('T', ' ');
  
  pool.execute(
    'INSERT INTO logs (username, action_type, status, details, timestamp) VALUES (?, ?, ?, ?, ?)',
    [username, actionType, status, details, timestamp]
  ).catch(err => {
    console.error('Error logging user action:', err);
  });
}

// Login endpoint - checks all three user tables
app.post('/login', async (req, res) => {
  const { username, password } = req.body;
  
  if (!username || !password) {
    return res.json({ success: false, message: 'Username and password are required' });
  }
  
  try {
    let connection;
    try {
      connection = await pool.getConnection();
      
      console.log(`Login attempt from: ${username}`);
      
      // Check admin table first
      console.log('Checking admin table for user:', username);
      const [adminRows] = await connection.execute(
        'SELECT id_admin, fname, lname, email, username, password, ctn FROM admin WHERE username = ?',
        [username]
      );
      
      console.log('Admin query results:', JSON.stringify(adminRows));
      
      if (adminRows.length > 0) {
        const admin = adminRows[0];
        console.log('Found matching admin user:', JSON.stringify(admin));
        
        // For simplicity, plain text password comparison (use bcrypt in production)
        if (admin.password === password) {
          console.log('Successful admin login from admin table:', username);
          logUserAction(username, 'login', 'success', 'admin login');
          
          const responseData = {
            success: true,
            message: 'Login successful',
            role: 'admin', // Explicitly lowercase
            user: admin
          };
          
          console.log('Sending admin response data:', JSON.stringify(responseData));
          return res.json(responseData);
        } else {
          console.log('Admin password verification failed');
        }
      } else {
        console.log('No matching admin found, checking lecturer table');
      }
      
      // Check lecturers table next
      const [lecturerRows] = await connection.execute(
        'SELECT * FROM lecturers WHERE username = ?',
        [username]
      );
      
      if (lecturerRows.length > 0) {
        const lecturer = lecturerRows[0];
        
        // For simplicity, plain text password comparison (use bcrypt in production)
        if (lecturer.password === password) {
          console.log('Successful lecturer login from lecturers table:', username);
          logUserAction(username, 'login', 'success', 'lecturer login');
          
          return res.json({
            success: true,
            message: 'Login successful',
            role: 'lecturer',
            user: lecturer
          });
        }
      }
      
      // Check student table last
      const [studentRows] = await connection.execute(
        'SELECT * FROM student WHERE username = ?',
        [username]
      );
      
      if (studentRows.length > 0) {
        const student = studentRows[0];
        
        // For simplicity, plain text password comparison (use bcrypt in production)
        if (student.password === password) {
          console.log('Successful student login from students table:', username);
          logUserAction(username, 'login', 'success', 'student login');
          
          return res.json({
            success: true,
            message: 'Login successful',
            role: 'student',
            user: student
          });
        }
      }
      
      // If we get here, no valid user was found or password was incorrect
      console.log('Invalid login attempt:', username);
      logUserAction(username, 'login', 'failed', 'invalid credentials');
      return res.json({ success: false, message: 'Invalid username or password' });
      
    } finally {
      if (connection) connection.release();
    }
  } catch (error) {
    console.error('Login error:', error);
    logUserAction(username, 'login', 'error', error.message);
    res.json({ success: false, message: 'An error occurred during login' });
  }
});

// Logout endpoint
app.post('/logout', (req, res) => {
  const { username } = req.body;
  
  if (!username) {
    return res.json({ success: false, message: 'Username is required' });
  }
  
  logUserAction(username, 'logout', 'success');
  res.json({ success: true, message: 'Logout successful' });
});

// Endpoint to get classes for a student
app.get('/student-classes/:studentId', async (req, res) => {
  const { studentId } = req.params;
  console.log(`Fetching classes for student ID: ${studentId}`);
  
  try {
    let connection;
    try {
      connection = await pool.getConnection();
      
      // Query to get classes for a student
      const [rows] = await connection.execute(`
        SELECT c.class_id, c.class_name, c.class_code, c.description, 
               COUNT(e.enrollment_id) as student_count
        FROM enrollment e
        JOIN class c ON e.class_id = c.class_id
        WHERE e.student_id = ?
        GROUP BY c.class_id
      `, [studentId]);
      
      console.log(`Found ${rows.length} classes for student ID: ${studentId}`);
      
      // Return the classes
      return res.json({
        success: true,
        classes: rows
      });
      
    } finally {
      if (connection) connection.release();
    }
  } catch (error) {
    console.error('Error fetching student classes:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to fetch classes'
    });
  }
});

// Endpoint to get classes for a lecturer
app.get('/lecturer-classes/:lecturerId', async (req, res) => {
  const { lecturerId } = req.params;
  console.log(`Fetching classes for lecturer ID: ${lecturerId}`);
  
  try {
    let connection;
    try {
      connection = await pool.getConnection();
      
      // Query to get classes for a lecturer
      const [rows] = await connection.execute(`
        SELECT c.class_id, c.class_name, c.class_code, c.description, 
               COUNT(e.enrollment_id) as student_count
        FROM class c
        LEFT JOIN enrollment e ON c.class_id = e.class_id
        WHERE c.lecturer_id = ?
        GROUP BY c.class_id
      `, [lecturerId]);
      
      console.log(`Found ${rows.length} classes for lecturer ID: ${lecturerId}`);
      
      // Return the classes
      return res.json({
        success: true,
        classes: rows
      });
      
    } finally {
      if (connection) connection.release();
    }
  } catch (error) {
    console.error('Error fetching lecturer classes:', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to fetch classes'
    });
  }
});

// Start the server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
  console.log(`Server accessible at http://192.168.68.133:${PORT}`);
  console.log('Server endpoints:');
  console.log('- POST /login - Login endpoint');
  console.log('- POST /logout - Logout endpoint');
  console.log('- GET /view-logs - View all logs');
  console.log('- GET /class-students/:classId - Get students in a class');
  console.log('- GET /logs-schema - Get logs schema');
  console.log('- POST /add-class - Add class endpoint');
  console.log('- POST /add-lecturer - Add lecturer endpoint');
  console.log('- GET /lecturers - Get lecturers endpoint');
  console.log('- GET /class-details/:id - Get class details');
  console.log('- POST /assign-instructor - Assign instructor to a class');
  console.log('- GET /lecturer-classes/:lecturerId - Get classes assigned to a lecturer');
}); 