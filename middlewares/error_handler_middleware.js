const logger = require("../config/logger");

// errorHandler.js
const errorHandler = (err, req, res, next) => {
  // Log the error stack for debugging
  logger.error({
    message: err.message, // Log the error message
    stack: err.stack, // Log the stack trace
    route: req.originalUrl, // Log the route where the error occurred
    method: req.method, // Log the HTTP method
    status: err.statusCode || 500,
  });

  const statusCode = err.statusCode || 500; // Use the error's status code or default to 500
  res.status(statusCode).json({
    message: err.message || "An internal server error occurred",
    // Show detailed error in development mode, otherwise show a generic message
    error: process.env.NODE_ENV === "development" ? err.stack : {},
  });
};

module.exports = errorHandler;
