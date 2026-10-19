// app.js - Buscador de Pokémon con fetch + async/await
// Documentación de la API: https://pokeapi.co/docs/v2#pokemon

const API_URL = "https://pokeapi.co/api/v2/pokemon/";

const formulario = document.getElementById("formulario");
const inputNombre = document.getElementById("nombre");
const btnBuscar = document.getElementById("btnBuscar");
const mensaje = document.getElementById("mensaje");
const tarjeta = document.getElementById("tarjeta");

// Colores por tipo (solo decorativo)
const coloresTipo = {
  fire: "#f08030", water: "#6890f0", grass: "#78c850", electric: "#f8d030",
  ice: "#98d8d8", fighting: "#c03028", poison: "#a040a0", ground: "#e0c068",
  flying: "#a890f0", psychic: "#f85888", bug: "#a8b820", rock: "#b8a038",
  ghost: "#705898", dragon: "#7038f8", dark: "#705848", steel: "#b8b8d0",
  fairy: "#ee99ac", normal: "#a8a878",
};

formulario.addEventListener("submit", (e) => {
  e.preventDefault();
  buscarPokemon();
});

async function buscarPokemon() {
  const nombre = inputNombre.value.trim().toLowerCase();

  // Validación: campo vacío
  if (!nombre) {
    mostrarMensaje("Escribe el nombre de un pokémon.", "error");
    return;
  }

  // Estado de carga
  tarjeta.classList.add("oculto");
  mostrarMensaje("Cargando...", "cargando");
  btnBuscar.disabled = true;

  try {
    const response = await fetch(API_URL + encodeURIComponent(nombre));

    // Validar response.ok (fetch NO lanza error con 404, hay que revisarlo)
    if (!response.ok) {
      if (response.status === 404) {
        throw new Error(`El pokémon "${nombre}" no existe. Revisa el nombre.`);
      }
      throw new Error(`Error del servidor (código ${response.status}).`);
    }

    const data = await response.json();
    mostrarPokemon(data);
    mostrarMensaje("", "");
  } catch (error) {
    // Si fetch falla por red, el mensaje es técnico ("Failed to fetch"); lo traducimos
    const texto = error instanceof TypeError
      ? "No se pudo conectar con la PokeAPI. Revisa tu conexión a internet."
      : error.message;
    mostrarMensaje(texto, "error");
  } finally {
    btnBuscar.disabled = false;
  }
}

function mostrarPokemon(data) {
  // Conversiones: peso en hectogramos -> kg (÷10), altura en decímetros -> m (÷10)
  const pesoKg = data.weight / 10;
  const alturaM = data.height / 10;

  const imagen =
    data.sprites.other?.["official-artwork"]?.front_default ||
    data.sprites.front_default;

  document.getElementById("pokeNombre").textContent =
    `#${data.id} ${data.name.charAt(0).toUpperCase() + data.name.slice(1)}`;

  const img = document.getElementById("imagen");
  img.src = imagen || "";
  img.alt = `Imagen de ${data.name}`;

  const tipos = document.getElementById("tipos");
  tipos.innerHTML = "";
  data.types.forEach(({ type }) => {
    const span = document.createElement("span");
    span.className = "tipo";
    span.textContent = type.name;
    span.style.background = coloresTipo[type.name] || "#888";
    tipos.appendChild(span);
  });

  document.getElementById("peso").textContent = `${pesoKg} kg`;
  document.getElementById("altura").textContent = `${alturaM} m`;

  tarjeta.classList.remove("oculto");
}

function mostrarMensaje(texto, tipo) {
  mensaje.textContent = texto;
  mensaje.className = `mensaje ${tipo}`;
}
