const logger = require("./config/logger");
const { closeDBPool } = require("./config/database");

const closeServer = (server) => {
  return new Promise((resolve, reject) => {
    logger.info("Shutting down the server...");
    server.close((err) => {
      if (err) {
        logger.error("Error shutting down the server", err);
        reject(err);
      } else {
        logger.info("Server shut down.");
        resolve();
      }
    });
  });
};

const gracefulShutdown = (server) => async () => {
  logger.info("SIGINT/SIGTERM received. Shutting down gracefully...");

  try {
    await closeServer(server);
    await closeDBPool();
    logger.info("Graceful shutdown complete.");
    process.exit(0);
  } catch (err) {
    logger.error("Error during graceful shutdown", err);
    process.exit(1);
  }
};

module.exports = { gracefulShutdown };
