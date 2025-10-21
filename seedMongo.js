// seedMongo.js
const mongoose = require("mongoose");
const CategoriaMongo = require("./models/CategoriaMongo");

mongoose.connect("mongodb://localhost:27017/steamdb_mongo");

(async () => {
  await CategoriaMongo.deleteMany({});

  await CategoriaMongo.insertMany([
    {
      categoria: "Acción",
      juegos: [
        { titulo: "GTA V", precio: 19.99, disponible: true },
        { titulo: "Half-Life 3", precio: 59.99, disponible: false }
      ]
    },
    {
      categoria: "RPG",
      juegos: [
        { titulo: "The Witcher 3", precio: 29.99, disponible: true },
        { titulo: "Cyberpunk 2077", precio: 49.99, disponible: true }
      ]
    },
    {
      categoria: "Aventura",
      juegos: [
        { titulo: "Uncharted 4", precio: 39.99, desarrollador: true },
        { titulo: "The Last of Us", precio: 34.99, disponible: true }
      ]
    },
    {
      categoria: "Terror",
      juegos: [
        { titulo: "Resident Evil Village", precio: 44.99, disponible: true },
        { titulo: "Silent Hill 2", precio: 29.99, disponible: true }
      ]
    }
  ]);

  console.log("Datos cargados en Mongo");
  mongoose.connection.close();
})();