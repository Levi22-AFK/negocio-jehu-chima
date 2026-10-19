# Métodos HTTP

API usada para las pruebas: **https://jsonplaceholder.typicode.com/posts**
Herramienta: Thunder Client (VS Code) / Postman y también `fetch` (ver `docs/pruebas_http.js`).

> **Nota:** JSONPlaceholder es una API falsa. Simula la creación, edición y borrado, devuelve una respuesta correcta, pero **no guarda nada**. Por eso un GET posterior no muestra los cambios.

| Método | ¿Qué hace? | ¿Lleva body? | Código esperado |
|---|---|---|---|
| GET | Lee/obtiene datos | No | 200 OK |
| POST | Crea un recurso nuevo | Sí | 201 Created |
| PUT | Reemplaza un recurso completo | Sí (completo) | 200 OK |
| PATCH | Modifica solo algunos campos | Sí (parcial) | 200 OK |
| DELETE | Elimina un recurso | No | 200 OK |

---

## 1. GET – Obtener datos

**Para qué sirve:** pedir información al servidor sin modificar nada. Es el método que usa el navegador al abrir una página. Es *seguro* (no cambia datos) e *idempotente* (repetirlo da el mismo resultado).

**Cómo se usa:** se pone la URL del recurso. Se puede pedir la lista completa (`/posts`) o uno solo por su id (`/posts/1`).

**Ejemplo**

- **URL:** `GET https://jsonplaceholder.typicode.com/posts/1`
- **Body:** no lleva
- **Código de estado:** `200 OK`

```js
const res = await fetch("https://jsonplaceholder.typicode.com/posts/1");
console.log(res.status);       // 200
console.log(await res.json());
```

**Respuesta:**
```json
{
  "userId": 1,
  "id": 1,
  "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum..."
}
```

---

## 2. POST – Crear un recurso

**Para qué sirve:** enviar datos al servidor para que cree algo nuevo (un registro, un usuario, un post). No es idempotente: si lo envías dos veces, se crean dos recursos.

**Cómo se usa:** se apunta a la colección (`/posts`, sin id) y en el body se mandan los datos en JSON con la cabecera `Content-Type: application/json`. El servidor asigna el id.

**Ejemplo**

- **URL:** `POST https://jsonplaceholder.typicode.com/posts`
- **Headers:** `Content-Type: application/json`
- **Body:**
```json
{
  "title": "Mi primer post",
  "body": "Contenido de prueba para la práctica de Web III",
  "userId": 1
}
```
- **Código de estado:** `201 Created`

```js
const res = await fetch("https://jsonplaceholder.typicode.com/posts", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ title: "Mi primer post", body: "Contenido de prueba para la práctica de Web III", userId: 1 })
});
console.log(res.status); // 201
```

**Respuesta:** (el servidor agrega el `id: 101`)
```json
{
  "title": "Mi primer post",
  "body": "Contenido de prueba para la práctica de Web III",
  "userId": 1,
  "id": 101
}



## 3. PUT – Reemplazar un recurso completo

**Para qué sirve:** actualizar un recurso existente **reemplazándolo entero** por lo que se envía. Es idempotente: enviarlo varias veces deja el mismo resultado.

**Cómo se usa:** se apunta al recurso con su id (`/posts/1`) y se envían **todos** los campos. Si falta alguno, ese campo se pierde.

**Ejemplo**

- **URL:** `PUT https://jsonplaceholder.typicode.com/posts/1`
- **Headers:** `Content-Type: application/json`
- **Body:**
```json
{
  "id": 1,
  "title": "Título reemplazado",
  "body": "Este body reemplaza todo el post",
  "userId": 1
}
```
- **Código de estado:** `200 OK`

```js
const res = await fetch("https://jsonplaceholder.typicode.com/posts/1", {
  method: "PUT",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ id: 1, title: "Título reemplazado", body: "Este body reemplaza todo el post", userId: 1 })
});
console.log(res.status); // 200
```

**Respuesta:**
```json
{
  "id": 1,
  "title": "Título reemplazado",
  "body": "Este body reemplaza todo el post",
  "userId": 1
}


## 4. PATCH – Modificar parcialmente

**Para qué sirve:** cambiar **solo algunos campos** de un recurso, sin tocar el resto.

**Cómo se usa:** se apunta al recurso con su id y en el body se manda únicamente lo que se quiere cambiar.

**Ejemplo**

- **URL:** `PATCH https://jsonplaceholder.typicode.com/posts/1`
- **Headers:** `Content-Type: application/json`
- **Body:**
```json
{
  "title": "Solo cambio el título"
}
```
- **Código de estado:** `200 OK`

```js
const res = await fetch("https://jsonplaceholder.typicode.com/posts/1", {
  method: "PATCH",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ title: "Solo cambio el título" })
});
console.log(res.status); // 200
```

**Respuesta:** (el título cambia, `body` y `userId` se mantienen)
```json
{
  "userId": 1,
  "id": 1,
  "title": "Solo cambio el título",
  "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum..."
}



## 5. DELETE – Eliminar un recurso

**Para qué sirve:** borrar un recurso del servidor. Es idempotente: borrar algo que ya se borró deja el mismo estado.

**Cómo se usa:** se apunta al recurso con su id. No lleva body.

**Ejemplo**

- **URL:** `DELETE https://jsonplaceholder.typicode.com/posts/1`
- **Body:** no lleva
- **Código de estado:** `200 OK`

```js
const res = await fetch("https://jsonplaceholder.typicode.com/posts/1", { method: "DELETE" });
console.log(res.status); // 200
```

**Respuesta:**
```json
{}



## Diferencia entre PUT y PATCH

Los dos sirven para actualizar, pero de forma distinta. **PUT reemplaza el recurso completo**: tengo que mandar todos los campos, y lo que no mande se pierde (es como cambiar la ficha entera por una nueva). **PATCH solo modifica lo que envío**: si mando solo el `title`, únicamente cambia el título y los demás campos quedan igual (es como corregir un dato con corrector). En la práctica, PUT se usa cuando editas un formulario completo y PATCH cuando cambias algo puntual, como el estado de un pedido o el stock de un producto.
