const { Pool } = require("pg");
const { config } = require("dotenv");
const logger = require("./logger");

config();

const pool = new Pool({
  host: process.env.DB_HOST, // PostgreSQL host
  user: process.env.DB_USER, // Database username
  database: process.env.DB_NAME, // Database name
  password: process.env.DB_PASSWORD, // Database password
  port: process.env.DB_PORT, // Default PostgreSQL port
});

// Function to connect and test the database connection
const connectDB = async () => {
  try {
    await pool.connect();
    logger.info("Connected to PostgreSQL Database!");
  } catch (error) {
    logger.error("Database connection error:", { stack: error.stack });
    process.exit(1); // Exit process with failure
  }
};

const closeDBPool = async () => {
  try {
    await pool.end();
    logger.info("Pool has been closed.");
  } catch (err) {
    logger.error("Error on pool closing", { stack: error.stack });
  }
};

module.exports = { connectDB, pool, closeDBPool };
