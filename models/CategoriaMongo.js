const mongoose = require('mongoose');

const juegoSchema = new mongoose.Schema({
  titulo: String,
  descripcion: String,
  precio: Number,
  disponible: Boolean
});

const categoriaSchema = new mongoose.Schema({
  categoria: { type: String, required: true },
  juegos: [juegoSchema]
});

module.exports = mongoose.model('CategoriaMongo', categoriaSchema);
