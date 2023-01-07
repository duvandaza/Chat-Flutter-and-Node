/*
    path: api/login
*/
const { Router} = require('express');
const { check } = require('express-validator');

const { crearUsuario } = require('../controllers/auth');
const { validarCampos } = require('../middlewares/validar-campo');
const router = Router();

router.post('/new', [
    check('nombre', 'El nombre es obligatorio').not().isEmpty(),
    check('password', 'Correo invalido').isLength({min:6}),
    check('email', 'Email no valido').isEmail(),
    validarCampos
] ,crearUsuario);


module.exports = router;