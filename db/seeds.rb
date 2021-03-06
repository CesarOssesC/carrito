# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#podemos destruir todo antes de guardar nuevamente añadiendo 
#TiposPago.destroy_all por ejemplo antes del create para que no duplique los datos.

EstadosProducto.create([
    {estado: 'activo'},
    {estado: 'inactivo'},
])



TiposPago.create ([
    {pago: 'efectivo'},
    {pago: 'tarjeta'},
])




EstadosPedido.create ([
    {estado: 'Solicitado'},
    {estado: 'Enviado'},
    {estado: 'Entregado'},
    {estado: 'Cancelado'}
])




Region.create ([
    {nombre: 'Región de Arica y Parinacota.'},
    {nombre: 'Región de Tarapacá.'},
    {nombre: 'Región de Antofagasta.'},
    {nombre: 'Región de Atacama.'},
    {nombre: 'Región de Coquimbo.'},
    {nombre: 'Región de Valparaíso.'},
    {nombre: 'Región Metropolitana de Santiago.'},
    {nombre: 'Región del Libertador General Bernardo O’Higgins.'},
    {nombre: 'Región del Maule.'},
    {nombre: 'Región del Ñuble.'},
    {nombre: 'Región del Biobío.'},
    {nombre: 'Región de La Araucanía.'},
    {nombre: 'Región de Los Ríos.'},
    {nombre: 'Región de Los Lagos.'},
    {nombre: 'Región de Aysén del General Carlos Ibáñez del Campo.'},
    {nombre: 'Región de Magallanes y la Antártica Chilena.'},
    {nombre: 'Sin Región'}
])

# Este queda comentado porque destino no es unico entonces cada vez que se hace el seed se repite. 
# Destino.create(
#     {nombre: 'Sin Destino', region: Region.find_by(nombre: 'Sin Región')}
# )


# Administrador.create([
#     {nombre: 'César Osses', correo: 'cesar.osses@gmail.com', password: Rails.application.credentials.admin[:password1]},
#     { nombre: "Coni López", correo: "coni.lopez@gmail.com", password: Rails.application.credentials.admin[:password2]}
# ])

TipoUsuario.create([
    { tipo: 'administrador'},
    { tipo: 'cliente'}
])

Usuario.create!([
    { email:'cesar.osses@gmail.com',
    password:'123456',
    password_confirmation:'123456',
    nombre:'César Osses',
    direccion:'calle falsa #123',
    telefono:'+56911111111',
    tipo_usuario: TipoUsuario.find_by(tipo: 'administrador')}

])