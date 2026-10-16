# Portfolio DevOps — Franco Notte

Portfolio personal construido durante el **Certificado DevOps — ORT ATI**.
Publicado automáticamente en cada push a `main`:

👉 **https://franconotte.github.io/portfolio-devops**

## Pipeline

Cada push a `main` dispara `.github/workflows/deploy.yml`:

```
scan (Trivy)  →  quality (SonarCloud)  →  deploy (GitHub Pages)
```

| Etapa | Herramienta | Qué controla |
| ----- | ----------- | ------------ |
| Security gate | Trivy | CVEs en la imagen Docker (imagen base incluida) |
| Quality gate | SonarCloud | bugs, vulnerabilidades, code smells y cobertura |
| Deploy | GitHub Pages | publica el sitio solo si pasan los dos gates |

Si alguno de los gates falla, el deploy no se ejecuta y el sitio queda en la última versión buena.

## Estructura

```text
portfolio-devops/
├── index.html                # Estructura del portfolio
├── style.css                 # Estilos
├── theme.js                  # Toggle de tema claro/oscuro
├── theme.test.js             # Tests unitarios (Vitest)
├── package.json              # Scripts y dependencias
├── Dockerfile                # Imagen nginx para correrlo containerizado
├── docker-compose.yml        # Entorno de desarrollo con live-reload
└── sonar-project.properties  # Configuración del análisis de calidad
```

## Correr localmente

### Desarrollo, con recarga en vivo

```bash
docker compose up
```

Abrir `http://localhost:8080`. Los cambios en `index.html` o `style.css` se ven al refrescar, sin reconstruir la imagen.

### Como imagen construida

La imagen usa `cgr.dev/chainguard/nginx`, que corre como usuario no-root y escucha en el **8080**:

```bash
docker build -t portfolio-devops .
docker run -d -p 8080:8080 --name mi-portfolio portfolio-devops
```

## Tests

```bash
npm ci
npm test              # tests unitarios
npm run test:coverage # tests + reporte de cobertura (coverage/lcov.info)
```

## Stack

- HTML5 + CSS3, sin frameworks
- Fuentes: [Syne](https://fonts.google.com/specimen/Syne) y [DM Mono](https://fonts.google.com/specimen/DM+Mono)
- Contenedor: [Chainguard nginx](https://images.chainguard.dev/directory/image/nginx/versions) (cero CVEs conocidos)
- CI/CD: GitHub Actions · Trivy · SonarCloud · GitHub Pages
