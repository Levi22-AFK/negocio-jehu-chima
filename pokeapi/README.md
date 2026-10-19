# PokeAPI

API pública usada en la Parte 4: https://pokeapi.co
Documentación: https://pokeapi.co/docs/v2#pokemon

## Endpoint usado

```
GET https://pokeapi.co/api/v2/pokemon/{nombre o id}
```

- No necesita API key ni registro.
- El nombre va en **minúsculas** (`pikachu`, no `Pikachu`).
- Si el pokémon no existe, responde **404 Not Found**.

## Campos que usa la app

| Dato | Campo en la respuesta | Conversión |
|---|---|---|
| Nombre | `name` | – |
| Imagen | `sprites.other["official-artwork"].front_default` (o `sprites.front_default`) | – |
| Tipos | `types[].type.name` | – |
| Peso | `weight` (hectogramos) | ÷ 10 → kg |
| Altura | `height` (decímetros) | ÷ 10 → m |

Ejemplo: Pikachu tiene `weight: 60` → **6 kg** y `height: 4` → **0.4 m**.

El código de la aplicación está en [`../frontend/`](../frontend/).
