const {
  addColors,
  createLogger,
  transports,
  format: { printf, combine, timestamp, simple },
} = require("winston");

// Define custom colors for log levels
addColors({
  error: "red",
  warn: "yellow",
  info: "green",
  http: "magenta",
  verbose: "cyan",
  debug: "blue",
  silly: "grey",
  custom: "blue", // Adding a custom level
});

const logFormat = printf(({ level, message, timestamp, stack }) => {
  return `${timestamp} ${level}: ${stack || message}`; // Include stack if it's an error
});

// Create a custom logger
const logger = createLogger({
  level: "info", // Set the default logging level
  format: combine(
    timestamp(), // Include a timestamp
    logFormat
  ),
  transports: [
    new transports.Console(), // Log to console
  ],
});

// If you want to log in a production environment, you could also add:
if (process.env.NODE_ENV !== "production") {
  logger.add(
    new transports.Console({
      format: simple(), // Use simple format in development
    })
  );
}

module.exports = logger; // Export the logger
