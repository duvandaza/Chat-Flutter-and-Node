const { comprobarJWT } = require('../helpers/jwt');
const { io } = require('../index');
const { usuarioConectado, usuarioDesconectado, grabarMensaje } = require('../controllers/socket')


// Mensajes de Sockets
io.on('connection', async (client) => {
    console.log('Cliente conectado!!');

    const [valido, uid] = comprobarJWT(client.handshake.headers['x-token']);

    // verificar autenticacion
    if(!valido) {return client.disconnect();}

    // Cliente autenticado
    await usuarioConectado(uid);

    // Ingresar al usuario a una sala en particular
    // sala global, cliente.id, uid
    client.join(uid);

    // Escuchar del cliente el mensaje-personal
    client.on('mensaje-personal', async (payload) => {
        //Todo: grabar mensaje
        await grabarMensaje(payload)
        io.to(payload.para).emit('mensaje-personal', payload);
    })

    client.on('disconnect', async() => {
        console.log('Cliente desconectado');
        await usuarioDesconectado(uid);
    });

    // client.on('mensaje', ( payload ) => {
    //     console.log('Mensaje', payload);

    //     io.emit( 'mensaje', { admin: 'Nuevo mensaje' } );
    // });


});
