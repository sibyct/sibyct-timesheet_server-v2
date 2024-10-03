const express = require("express");
const router = express.Router();
const { login, register } = require("../controllers/auth_controller");

// login the user
router.post("/login", login);

// register the user
router.post("/register", register);

module.exports = router;
