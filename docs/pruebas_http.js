// Pruebas de los 5 métodos HTTP sobre JSONPlaceholder usando fetch
// Ejecutar con:  node docs/pruebas_http.js   (Node 18 o superior)

const URL = "https://jsonplaceholder.typicode.com/posts";
const headers = { "Content-Type": "application/json" };

async function probar(nombre, url, opciones = {}) {
  try {
    const res = await fetch(url, opciones);
    const data = await res.json();
    console.log(`\n===== ${nombre} =====`);
    console.log(`URL:    ${opciones.method || "GET"} ${url}`);
    if (opciones.body) console.log(`Body:   ${opciones.body}`);
    console.log(`Status: ${res.status} ${res.statusText}`);
    console.log("Respuesta:", data);
  } catch (error) {
    console.error(`${nombre} falló:`, error.message);
  }
}

(async () => {
  await probar("GET", `${URL}/1`);

  await probar("POST", URL, {
    method: "POST",
    headers,
    body: JSON.stringify({ title: "Mi primer post", body: "Contenido de prueba para la práctica de Web III", userId: 1 }),
  });

  await probar("PUT", `${URL}/1`, {
    method: "PUT",
    headers,
    body: JSON.stringify({ id: 1, title: "Título reemplazado", body: "Este body reemplaza todo el post", userId: 1 }),
  });

  await probar("PATCH", `${URL}/1`, {
    method: "PATCH",
    headers,
    body: JSON.stringify({ title: "Solo cambio el título" }),
  });

  await probar("DELETE", `${URL}/1`, { method: "DELETE" });
})();
