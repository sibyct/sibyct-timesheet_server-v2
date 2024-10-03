const createError = require("http-errors");
const express = require("express");
const path = require("path");
const cookieParser = require("cookie-parser");
const logger = require("morgan");
const app = express();
const helmet = require("helmet");

const authRoute = require("./routes/auth_route");
const { connectDB } = require("./config/database");
const errorHandler = require("./middlewares/error_handler_middleware");

(async () => {
  await connectDB();
})();

//application middlewares
app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "public")));
app.use(helmet()); // Helmet sets various HTTP headers for security

//routes
app.use("/api/user", authRoute);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(errorHandler);

module.exports = app;
