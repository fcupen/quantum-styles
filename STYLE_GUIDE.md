# 🎨 Quantum AI Signals — Blog: Guía de Estilos

> Documentación completa del sistema de diseño, componentes y convenciones CSS del blog.
> **Stack**: PHP · Plain CSS · Inter · Iconify
> **Última actualización**: 2025

---

## Índice

1. [Arquitectura de Estilos](#1-arquitectura-de-estilos)
2. [Design Tokens (CSS Custom Properties)](#2-design-tokens-css-custom-properties)
3. [Sistema de Colores](#3-sistema-de-colores)
4. [Sistema Tipográfico](#4-sistema-tipográfico)
5. [Sistema de Espaciado](#5-sistema-de-espaciado)
6. [Sombras y Elevación](#6-sombras-y-elevación)
7. [Border Radius](#7-border-radius)
8. [Transiciones y Animaciones](#8-transiciones-y-animaciones)
9. [Componentes](#9-componentes)
10. [Clases Utilitarias](#10-clases-utilitarias)
11. [Z-Index Scale](#11-z-index-scale)
12. [Dark Theme](#12-dark-theme)
13. [Accesibilidad](#13-accesibilidad)
14. [Scrollbars](#14-scrollbars)
15. [Breakpoints y Responsive](#15-breakpoints-y-responsive)
16. [Blog-Front Angular Module (SCSS)](#16-blog-front-angular-module-scss)
17. [Convenciones y Buenas Prácticas](#17-convenciones-y-buenas-prácticas)
18. [Resumen Visual de la Paleta](#18-resumen-visual-de-la-paleta)

---

## 1. Arquitectura de Estilos

### Stack Tecnológico

| Tecnología | Uso | Notas |
|---|---|---|
| **PHP** | Aplicación del blog | Renderizado server-side con vistas en `views/` |
| **Plain CSS** | Estilos principales | Archivo único `blog.css` (~5570 líneas), sin preprocesador |
| **Inter** | Tipografía principal | Cargada vía Google Fonts |
| **Iconify** | Iconografía | Set de iconos universal, cargado vía script |
| **CSS Custom Properties** | Design tokens | Variables CSS en `:root` para temas y consistencia |

> **Nota**: El blog **NO** usa Angular ni SCSS directamente. Existe un módulo Angular `blog-front` en el backoffice que tiene sus propios SCSS (prefijados `bf-`), pero el blog PHP usa CSS puro.

### Estructura de Archivos

```
blog/
├── public/
│   └── assets/
│       ├── css/
│       │   └── blog.css          ← Hoja de estilos principal (~5570 líneas)
│       ├── js/                   ← JavaScript del blog
│       ├── img/                  ← Imágenes y assets estáticos
│       └── manifest.webmanifest  ← PWA manifest
├── views/
│   ├── layouts/                  ← Layouts base (main.php, etc.)
│   │   └── main.php              ← Layout principal (carga blog.css)
│   ├── blog/                     ← Vistas del blog
│   │   ├── list.php              ← Listado de posts (homepage)
│   │   ├── post.php              ← Detalle de post individual
│   │   ├── search.php            ← Página de búsqueda
│   │   ├── category.php          ← Archivo por categoría
│   │   └── tag.php               ← Archivo por tag
│   ├── errors/                   ← Páginas de error
│   │   ├── 404.php               ← Error 404
│   │   └── 500.php               ← Error 500
│   └── seo/                      ← Vistas relacionadas con SEO
├── app/                          ← Código PHP de la aplicación
├── config/                       ← Configuración
└── STYLE_GUIDE.md                ← Este archivo
```

#### Módulo Blog-Front en Backoffice (Angular/SCSS)

El backoffice incluye un módulo Angular `blog-front` con estilos SCSS propios para la vista previa del blog dentro del panel de administración:

```
backoffice/src/app/blog-front/styles/
├── blog-front-styles.scss        ← Punto de entrada (importa el partial)
├── _blog-front-styles.scss       ← Archivo partial principal
├── _blog-front-variables.scss    ← Design tokens (coincidentes con blog.css)
├── _blog-front-base.scss         ← Reset, keyframes, accesibilidad
├── _blog-front-components.scss   ← Componentes reutilizables (prefijo bf-)
└── _blog-front-utilities.scss    ← Clases utilitarias (prefijo bf-)
```

### Orden de Carga

1. **Blog PHP**: `blog.css` se carga en el layout principal (`views/layouts/main.php`) mediante un `<link>` en el `<head>`.
2. **Blog-Front Angular**: Los SCSS se importan vía `styleUrls` en los componentes Angular, scoped bajo `.blog-front-shell`.
3. **Iconify**: Se carga vía `<script>` en el layout para proveer iconos inline SVG.

---

## 2. Design Tokens (CSS Custom Properties)

Todos los tokens se definen en `:root` dentro de `blog.css`. A continuación se documentan todos los tokens existentes más los nuevos recomendados.

### Colores Base

```css
:root {
  /* Colors — Light theme */
  --color-bg: #f4f4f8;
  --color-surface: #ffffff;
  --color-surface-2: #eaeaf4;
  --color-primary: rgb(84, 192, 145);
  --color-primary-rgb: 84, 192, 145;
  --color-accent: rgb(243, 177, 102);
  --color-accent-rgb: 243, 177, 102;
}
```

### Colores Semánticos

```css
:root {
  --color-success: rgb(84, 192, 145);
  --color-warning: rgb(243, 177, 102);
  --color-danger: #e74c3c;
  --color-info: #0dcaf0;
}
```

### Gradientes

```css
:root {
  --gradient-primary: linear-gradient(135deg, rgb(84, 192, 145) 0%, rgb(243, 177, 102) 100%);
  --gradient-primary-r: linear-gradient(135deg, rgb(243, 177, 102) 0%, rgb(84, 192, 145) 100%);
  --gradient-bg: linear-gradient(180deg, #f4f4f8 0%, #eaeaf4 100%);
  --gradient-surface: linear-gradient(135deg, #ffffff 0%, #eaeaf4 100%);
  --gradient-glow: radial-gradient(ellipse 80% 50% at 50% -20%, rgba(84, 192, 145, 0.15) 0%, transparent 70%);
  --gradient-glow-accent: radial-gradient(ellipse 60% 40% at 80% 80%, rgba(243, 177, 102, 0.1) 0%, transparent 60%);
}
```

### Texto

```css
:root {
  --color-text: #0f0f1a;
  --color-text-muted: #5a5a78;
  --color-text-dim: #8a8aaa;
}
```

### Bordes

```css
:root {
  --color-border: rgba(84, 192, 145, 0.2);
  --color-border-subtle: rgba(0, 0, 0, 0.06);
}
```

### Tipografía

```css
:root {
  --font-family: "Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
  --font-mono: "Fira Code", "Consolas", monospace;

  --font-size-xs: 0.75rem;
  --font-size-sm: 0.875rem;
  --font-size-base: 1rem;
  --font-size-lg: 1.125rem;
  --font-size-xl: 1.25rem;
  --font-size-2xl: 1.5rem;
  --font-size-3xl: 1.875rem;
  --font-size-4xl: 2.25rem;
  --font-size-5xl: 3rem;
  --font-size-6xl: 3.75rem;
  --font-size-7xl: 4.5rem;
}
```

### Espaciado

```css
:root {
  --space-1: 0.25rem;
  --space-2: 0.5rem;
  --space-3: 0.75rem;
  --space-4: 1rem;
  --space-5: 1.25rem;
  --space-6: 1.5rem;
  --space-7: 1.75rem;
  --space-8: 2rem;
  --space-10: 2.5rem;
  --space-12: 3rem;
  --space-16: 4rem;
  --space-20: 5rem;
  --space-24: 6rem;
  --space-32: 8rem;
}
```

### Border Radius

```css
:root {
  --radius-sm: 0.375rem;
  --radius-md: 0.75rem;
  --radius-lg: 1rem;
  --radius-xl: 1.5rem;
  --radius-2xl: 2rem;
  --radius-full: 9999px;
}
```

### Sombras

```css
:root {
  --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
  --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.12);
  --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.15);
  --shadow-primary: 0 0 40px rgba(84, 192, 145, 0.15);
  --shadow-accent: 0 0 40px rgba(243, 177, 102, 0.12);
  --shadow-glow: 0 0 60px rgba(84, 192, 145, 0.1), 0 0 100px rgba(243, 177, 102, 0.06);
}
```

### Transiciones

```css
:root {
  --transition-fast: 150ms ease;
  --transition-base: 250ms ease;
  --transition-slow: 400ms ease;
  --transition-spring: 400ms cubic-bezier(0.34, 1.56, 0.64, 1);
}
```

### Tokens de Layout

```css
:root {
  --container-max: 1200px;
  --sidebar-width: 320px;
  --header-height: 64px;
}
```

### Z-Index Scale

```css
:root {
  --z-below: -1;
  --z-base: 0;
  --z-raised: 10;
  --z-overlay: 100;
  --z-modal: 1000;
  --z-nav: 9000;
  --z-toast: 9999;
}
```

---

## 3. Sistema de Colores

### Paleta Principal

| Token | Valor | Uso |
|---|---|---|
| `--color-bg` | `#f4f4f8` | Fondo general del body |
| `--color-surface` | `#ffffff` | Fondo de tarjetas y superficies elevadas |
| `--color-surface-2` | `#eaeaf4` | Superficies secundarias |
| `--color-primary` | `rgb(84, 192, 145)` | Color principal (verde lima) |
| `--color-primary-rgb` | `84, 192, 145` | Para uso con `rgba()` |
| `--color-accent` | `rgb(243, 177, 102)` | Color de acento (naranja dorado) |
| `--color-accent-rgb` | `243, 177, 102` | Para uso con `rgba()` |

### Paleta de Texto

| Token | Valor | Uso |
|---|---|---|
| `--color-text` | `#0f0f1a` | Texto principal |
| `--color-text-muted` | `#5a5a78` | Texto secundario |
| `--color-text-dim` | `#8a8aaa` | Texto terciario / deshabilitado |

### Paleta de Bordes

| Token | Valor | Uso |
|---|---|---|
| `--color-border` | `rgba(84, 192, 145, 0.2)` | Bordes con tinte primario |
| `--color-border-subtle` | `rgba(0, 0, 0, 0.06)` | Bordes sutiles / separadores |

### Paleta Semántica

| Token | Valor | Uso |
|---|---|---|
| `--color-success` | `rgb(84, 192, 145)` | Estados de éxito |
| `--color-warning` | `rgb(243, 177, 102)` | Advertencias |
| `--color-danger` | `#e74c3c` | Errores y estados críticos |
| `--color-info` | `#0dcaf0` | Información |

### Gradientes Clave

| Token | Valor | Uso |
|---|---|---|
| `--gradient-primary` | `135deg, primary → accent` | Botones, badges, textos con gradiente |
| `--gradient-primary-r` | `135deg, accent → primary` | Variante invertida |
| `--gradient-bg` | `180deg, #f4f4f8 → #eaeaf4` | Fondo del body |
| `--gradient-surface` | `135deg, #fff → #eaeaf4` | Fondos de tarjetas |
| `--gradient-glow` | `radial, primary 15%` | Efecto de resplandor superior |
| `--gradient-glow-accent` | `radial, accent 10%` | Resplandor decorativo |

### Color de Blobs Decorativos

Utilizados en secciones hero y fondos decorativos:

| Color | Valor | Uso |
|---|---|---|
| Blob primario | `rgba(84, 192, 145, 0.35)` | Blobs grandes en hero (`blog-hero::after`) |
| Blob accent | `rgba(243, 177, 102, 0.3)` | Blobs secundarios en hero |
| Blob terciario | `rgba(84, 192, 145, 0.2)` | Blob inferior en hero |
| Grid overlay | `rgba(255, 255, 255, 0.03)` | Líneas de grid en `::before` del hero |

### Color de Código

| Elemento | Valor | Uso |
|---|---|---|
| Fondo de bloques `<pre>` | `#1e1e2e` | Bloques de código (Catppuccin Mocha) |
| Texto de bloques `<pre>` | `#cdd6f4` | Texto dentro de `<pre>` |
| Scrollbar de código | `#45475a` | Scrollbar horizontal en `<pre>` |
| Fondo de inline `<code>` | `var(--color-border-subtle)` | Código inline |
| Texto de inline `<code>` | `#c0392b` | Código inline (rojo oscuro) |
| Fuente mono | `var(--font-mono)` | `"Fira Code", "Consolas", monospace` |

---

## 4. Sistema Tipográfico

### Fuente Principal

```css
--font-family: "Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
```

- **Inter**: Fuente principal del sistema, optimizada para pantallas.
- **Fallbacks**: Sistema operativo nativo (-apple-system, BlinkMacSystemFont, Segoe UI).

### Fuente Mono

```css
--font-mono: "Fira Code", "Consolas", monospace;
```

- Utilizada en bloques de código, la debug bar y elementos técnicos.
- Se referencia como `var(--blog-mono)` en el CSS del post content.

### Escala Tipográfica

| Token | Valor | Uso típico |
|---|---|---|
| `--font-size-xs` | `0.75rem` (12px) | Badges, timestamps, contadores |
| `--font-size-sm` | `0.875rem` (14px) | Texto secundario, meta, tags |
| `--font-size-base` | `1rem` (16px) | Texto body estándar |
| `--font-size-lg` | `1.125rem` (18px) | Texto ligeramente destacado |
| `--font-size-xl` | `1.25rem` (20px) | Subtítulos menores |
| `--font-size-2xl` | `1.5rem` (24px) | Títulos de sección |
| `--font-size-3xl` | `1.875rem` (30px) | Títulos grandes |
| `--font-size-4xl` | `2.25rem` (36px) | Hero titles |
| `--font-size-5xl` | `3rem` (48px) | Display text |
| `--font-size-6xl` | `3.75rem` (60px) | Títulos impactantes |
| `--font-size-7xl` | `4.5rem` (72px) | Hero máximo |

### Font Weights

| Peso | Valor | Uso |
|---|---|---|
| Light | 300 | Texto decorativo |
| Normal | 400 | Body text |
| Medium | 500 | Subtítulos, links, meta |
| Semibold | 600 | Navegación, labels |
| Bold | 700 | Headings, títulos de sección |
| Extrabold | 800 | Títulos principales (post title, hero) |
| Black | 900 | Display text (raro) |

### Estilos Globales de Tipografía

```css
/* Headings globales */
h1, h2, h3, h4, h5, h6 {
  font-weight: 700;
  line-height: 1.15;
  color: var(--color-text);
  letter-spacing: -0.02em;
}

/* Body */
body {
  font-family: var(--font-family);
  font-size: var(--font-size-base);
  font-weight: 400;
  line-height: 1.6;
  color: var(--color-text);
  background-color: var(--color-bg);
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

/* Párrafos */
p {
  color: var(--color-text-muted);
  margin-bottom: 1rem;
}
```

### Tipografía de Contenido de Post (`.post-content`)

El contenido del post usa una tipografía de prosa optimizada para lectura:

```css
.post-content {
  font-size: 1.0625rem;
  line-height: 1.8;
  color: var(--color-text);
  word-break: break-word;
  overflow-wrap: break-word;
}
```

#### Headings dentro de `.post-content`

| Elemento | Tamaño | Comportamiento |
|---|---|---|
| `h1` | `2em` | `margin-top: 2em; scroll-margin-top: calc(var(--header-height) + 1rem)` |
| `h2` | `1.5em` | Subrayado gradiente decorativo (`::after` con `--gradient-primary`, 60px × 3px) |
| `h3` | `1.25em` | Sin decoración adicional |
| `h4` | `1.1em` | Sin decoración adicional |
| `h5` / `h6` | `1em` | Sin decoración adicional |

```css
.post-content h1, .post-content h2, .post-content h3,
.post-content h4, .post-content h5, .post-content h6 {
  margin-top: 2em;
  margin-bottom: 0.75em;
  font-weight: 700;
  line-height: 1.3;
  color: var(--color-text);
  scroll-margin-top: calc(var(--header-height, 64px) + 1rem);
}

/* Gradiente decorativo bajo h2 */
.post-content h2::after {
  content: "";
  position: absolute;
  bottom: 0;
  left: 0;
  width: 60px;
  height: 3px;
  border-radius: 2px;
  background: var(--gradient-primary);
}
```

#### Bloques de Código

```css
/* Bloque <pre> */
.post-content pre {
  background: #1e1e2e;
  color: #cdd6f4;
  padding: 1.25rem;
  border-radius: var(--radius-md);
  overflow-x: auto;
  margin-bottom: 1.4em;
  font-family: var(--blog-mono);
  font-size: 0.875rem;
  line-height: 1.6;
  box-shadow: var(--shadow-md);
  scrollbar-width: thin;
  scrollbar-color: #45475a transparent;
}

/* Código inline */
.post-content :not(pre) > code {
  background: var(--color-border-subtle);
  color: #c0392b;
  padding: 0.15em 0.4em;
  border-radius: var(--radius-sm);
  font-family: var(--blog-mono);
  font-size: 0.875em;
}
```

#### Blockquote

```css
.post-content blockquote {
  margin: 1.75em 0;
  padding: 1.25rem 1.5rem;
  border-left: 4px solid transparent;
  border-image: var(--gradient-primary) 1;
  background: linear-gradient(135deg, rgba(84, 192, 145, 0.06) 0%, rgba(243, 177, 102, 0.04) 100%);
  border-radius: 0 var(--radius-md) var(--radius-md) 0;
  color: var(--color-text-muted);
  font-style: italic;
}
```

#### Links en Contenido

```css
.post-content a {
  color: var(--color-primary);
  text-decoration: underline;
  text-underline-offset: 0.2em;
  text-decoration-thickness: 1px;
}

.post-content a:hover {
  text-decoration-thickness: 2px;
}
```

#### Tablas

```css
.post-content table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 1.4em;
  font-size: 0.9375rem;
  overflow-x: auto;
  display: block;
}

.post-content th {
  background: var(--color-border-subtle);
  font-weight: 700;
  color: var(--color-text);
}

.post-content tr:nth-child(even) td {
  background: rgba(0, 0, 0, 0.015);
}
```

#### Details / Summary

```css
.post-content details {
  margin-bottom: 1.4em;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  overflow: hidden;
}

.post-content summary {
  padding: 0.75rem 1rem;
  background: var(--color-border-subtle);
  cursor: pointer;
  font-weight: 600;
  user-select: none;
}
```

#### Figures

```css
.post-content figure {
  margin: 1.75em 0;
}

.post-content figcaption {
  font-size: 0.875rem;
  color: var(--color-text-muted);
  text-align: center;
  margin-top: 0.5rem;
  font-style: italic;
}
```

### Texto con Gradiente (`.gradient-text`)

```css
.gradient-text {
  background: var(--gradient-primary);
  background-size: 200% auto;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  animation: gradientShift 4s ease infinite;
}
```

---

## 5. Sistema de Espaciado

### Escala Base (rem)

| Token | Valor | Pixels | Uso típico |
|---|---|---|---|
| `--space-1` | `0.25rem` | 4px | Micro-espaciado |
| `--space-2` | `0.5rem` | 8px | Gap mínimo |
| `--space-3` | `0.75rem` | 12px | Espaciado compacto |
| `--space-4` | `1rem` | 16px | Espaciado estándar |
| `--space-5` | `1.25rem` | 20px | Padding de widgets |
| `--space-6` | `1.5rem` | 24px | Gap de grid, paddings |
| `--space-7` | `1.75rem` | 28px | Espaciado intermedio |
| `--space-8` | `2rem` | 32px | Secciones internas |
| `--space-10` | `2.5rem` | 40px | Gap de layout |
| `--space-12` | `3rem` | 48px | Padding de secciones |
| `--space-16` | `4rem` | 64px | Secciones grandes |
| `--space-20` | `5rem` | 80px | Separadores grandes |
| `--space-24` | `6rem` | 96px | Márgenes de footer |
| `--space-32` | `8rem` | 128px | Espaciado hero |

### Layout-Specific Spacing

| Token | Valor | Uso |
|---|---|---|
| `--container-max` | `1200px` | Ancho máximo del contenedor |
| `--sidebar-width` | `320px` (280px en ≤1024px) | Ancho de la sidebar |
| `--header-height` | `64px` | Altura fija del header |

| Elemento | Offset | Descripción |
|---|---|---|
| `.blog-sidebar` sticky top | `calc(var(--header-height) + 1.5rem)` | Sidebar se queda debajo del header |
| `.blog-sidebar` max-height | `calc(100vh - var(--header-height) - 3rem)` | Altura máxima con scroll interno |
| `.blog-list__sidebar` sticky top | `calc(var(--header-height) + 1rem)` | Variante de sidebar en list.php |
| `.scroll-to-top` bottom/right | `2rem` | Posición del botón scroll-to-top |
| `.post-content` headings scroll-margin | `calc(var(--header-height) + 1rem)` | Offset para anchor links |

---

## 6. Sombras y Elevación

| Token | Valor | Uso |
|---|---|---|
| `--shadow-sm` | `0 1px 3px rgba(0,0,0,0.1)` | Elevación mínima (widgets, cards en reposo) |
| `--shadow-md` | `0 4px 16px rgba(0,0,0,0.12)` | Elevación media (cards hover, dropdowns) |
| `--shadow-lg` | `0 8px 32px rgba(0,0,0,0.15)` | Elevación alta (modales) |
| `--shadow-primary` | `0 0 40px rgba(84,192,145,0.15)` | Glow primario (botones, cards hover) |
| `--shadow-accent` | `0 0 40px rgba(243,177,102,0.12)` | Glow accent |
| `--shadow-glow` | `0 0 60px ... 0 0 100px ...` | Glow combinado primario + accent |

### Clases de Glow

```css
.glow-primary {
  box-shadow: var(--shadow-primary);
}

.glow-accent {
  box-shadow: var(--shadow-accent);
}

.glow-blob {
  position: absolute;
  border-radius: 50%;
  filter: blur(80px);
  pointer-events: none;
  z-index: var(--z-below, -1);
}

.glow-blob--primary {
  background: rgba(84, 192, 145, 0.25);
}

.glow-blob--accent {
  background: rgba(243, 177, 102, 0.18);
}
```

---

## 7. Border Radius

| Token | Valor | Uso |
|---|---|---|
| `--radius-sm` | `0.375rem` (6px) | Badges, inputs, small elements |
| `--radius-md` | `0.75rem` (12px) | Cards, dropdowns, code blocks |
| `--radius-lg` | `1rem` (16px) | Widgets, larger cards |
| `--radius-xl` | `1.5rem` (24px) | Post cards, hero sections |
| `--radius-2xl` | `2rem` (32px) | Elementos extra redondeados |
| `--radius-full` | `9999px` | Pills, avatares, botones |

---

## 8. Transiciones y Animaciones

### Transiciones Base

| Token | Valor | Uso |
|---|---|---|
| `--transition-fast` | `150ms ease` | Hover en links, cambios rápidos |
| `--transition-base` | `250ms ease` | Transiciones estándar |
| `--transition-slow` | `400ms ease` | Transiciones de layout, expandir |
| `--transition-spring` | `400ms cubic-bezier(0.34,1.56,0.64,1)` | Efecto rebote |

### Keyframes Disponibles

| Keyframe | Descripción | Duración típica |
|---|---|---|
| `fadeInUp` | Fade desde abajo (+20px) | 0.8s cubic-bezier(0.16,1,0.3,1) |
| `fadeInDown` | Fade desde arriba (-30px) | 0.8s cubic-bezier(0.16,1,0.3,1) |
| `fadeInLeft` | Fade desde la izquierda (-20px) | 0.8s cubic-bezier(0.16,1,0.3,1) |
| `fadeInRight` | Fade desde la derecha (+20px) | 0.8s cubic-bezier(0.16,1,0.3,1) |
| `fadeIn` | Fade simple (opacity) | 0.6s ease |
| `slideInLeft` | Slide desde la izquierda (-50px) | 0.6s ease |
| `slideInRight` | Slide desde la derecha (+50px) | 0.6s ease |
| `scaleIn` | Scale desde 0.95 a 1 | 0.8s cubic-bezier(0.16,1,0.3,1) |
| `float` | Flotación vertical (-18px) | 4s ease-in-out infinite |
| `floatSlow` | Flotación lenta con rotación | 7s ease-in-out infinite |
| `pulse` | Pulso de escala (1 → 1.05) | 2s ease-in-out infinite |
| `pulseDot` | Pulso de box-shadow | 2s ease-in-out infinite |
| `gradientShift` | Desplazamiento de gradiente | 4s ease infinite |
| `gradientShiftBg` | Desplazamiento de gradiente en 4 direcciones | 12s ease infinite |
| `rotate` | Rotación continua 360° | 20s linear infinite |
| `rotateReverse` | Rotación inversa | 20s linear infinite |
| `shimmer` | Efecto shimmer (background-position) | 2s ease-in-out infinite |
| `blink` | Parpadeo (opacity) | 1s step-end infinite |
| `ripple` | Efecto ripple (scale + opacity) | 0.6s ease |
| `orbitLeft` | Órbita animada izquierda | 6s ease-in-out infinite |
| `orbitRight` | Órbita animada derecha | 6s ease-in-out infinite |
| `particleFloat1` | Partícula flotante con rotación | 5s ease-in-out infinite |
| `particleFloat2` | Partícula flotante simple | 4s ease-in-out infinite |
| `countUp` | Aparición desde abajo (+20px) | 0.5s ease |
| `borderGlow` | Glow pulsante en borde | 3s ease-in-out infinite |
| `scanline` | Línea de escaneo vertical | 2s linear infinite |
| `dropdownIn` | Dropdown menu entrada (opacity + translateY) | 0.15s ease |
| `mobileMenuSlideIn` | Menú móvil slide desde arriba | 0.2s ease |
| `mobileOverlayFadeIn` | Overlay móvil fade in | 0.2s ease |
| `skeleton-loading` | Skeleton placeholder animado | 1.5s ease-in-out infinite |

### Clases de Animación

> **Nota**: Todas las clases de animación usan `will-change` y `!important` en blog.css para garantizar que se apliquen incluso si otros estilos compiten.

```css
.animate-fadeInUp   { will-change: transform, opacity; animation: fadeInUp 0.8s cubic-bezier(0.16,1,0.3,1) both !important; }
.animate-fadeIn     { will-change: opacity;           animation: fadeIn 0.6s ease both !important; }
.animate-fadeInLeft { will-change: transform, opacity; animation: fadeInLeft 0.8s cubic-bezier(0.16,1,0.3,1) both !important; }
.animate-fadeInRight{ will-change: transform, opacity; animation: fadeInRight 0.8s cubic-bezier(0.16,1,0.3,1) both !important; }
.animate-scaleIn    { will-change: transform, opacity; animation: scaleIn 0.8s cubic-bezier(0.16,1,0.3,1) both !important; }
.animate-fadeInDown { will-change: transform, opacity; animation: fadeInDown 0.8s cubic-bezier(0.16,1,0.3,1) both !important; }
.animate-float      { animation: float 4s ease-in-out infinite !important; }
.animate-float-slow { animation: floatSlow 7s ease-in-out infinite !important; }
.animate-pulse      { animation: pulse 2s ease-in-out infinite !important; }
.animate-rotate     { animation: rotate 20s linear infinite !important; }
.animate-shimmer    { animation: shimmer 2s ease-in-out infinite !important; }
```

### Clases de Delay

```css
.delay-100  { animation-delay: 100ms !important; }
.delay-200  { animation-delay: 200ms !important; }
.delay-300  { animation-delay: 300ms !important; }
.delay-400  { animation-delay: 400ms !important; }
.delay-500  { animation-delay: 500ms !important; }
.delay-600  { animation-delay: 0.6s; }
.delay-800  { animation-delay: 0.8s; }
.delay-1000 { animation-delay: 1s; }
```

---

## 9. Componentes

### 9.1 Botones (`.btn`)

#### Base `.btn`

```css
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-2);
  padding: 0.875rem var(--space-8);
  font-size: var(--font-size-base);
  font-weight: 600;
  line-height: 1.5;
  text-decoration: none;
  border-radius: var(--radius-full);
  border: 2px solid transparent;
  cursor: pointer;
  transition: all var(--transition-base);
  white-space: nowrap;
  user-select: none;
  position: relative;
  overflow: hidden;
}
```

#### `.btn--primary` (Gradiente + Shimmer)

```css
.btn--primary {
  background: var(--gradient-primary);
  background-size: 200% auto;
  color: #fff;
  border-color: transparent;
  border-radius: var(--radius-full);
  box-shadow: var(--shadow-primary);
}

.btn--primary:hover {
  background-position: right center;
  border-color: transparent;
  color: #fff;
  box-shadow: 0 8px 30px rgba(84, 192, 145, 0.5);
  transform: translateY(-2px);
}

/* Efecto shimmer en hover */
.btn--primary::before {
  content: "";
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(120deg, transparent 30%, rgba(255,255,255,0.25) 50%, transparent 70%);
  transition: left 0.5s ease;
  pointer-events: none;
}

.btn--primary:hover::before {
  left: 100%;
}
```

#### `.btn--outline` (Glassmorphism)

```css
.btn--outline {
  background: transparent;
  color: var(--color-text);
  border-color: var(--color-border);
}

.btn--outline:hover {
  border-color: var(--color-primary);
  color: var(--color-primary);
  transform: translateY(-2px);
  box-shadow: var(--shadow-primary);
}
```

#### `.btn--ghost`

```css
.btn--ghost {
  background: rgba(84, 192, 145, 0.1);
  color: var(--color-primary);
  border-color: transparent;
}

.btn--ghost:hover {
  background: rgba(84, 192, 145, 0.18);
  color: var(--color-primary);
  transform: translateY(-2px);
}
```

#### Tamaños

```css
.btn--sm { padding: 0.625rem var(--space-5); font-size: var(--font-size-sm); }
.btn--lg { padding: 1.125rem var(--space-10); font-size: var(--font-size-lg); }
```

#### `.btn--rss` (Naranja RSS)

```css
.btn--rss {
  background: #f26522;
  color: #fff;
  border-color: #f26522;
}

.btn--rss:hover {
  background: #d9561e;
  border-color: #d9561e;
  color: #fff;
}
```

#### `.btn--share` (Botón compacto)

```css
.btn--share {
  background: transparent;
  border: 1px solid var(--color-border);
  color: var(--color-text-muted);
  padding: var(--space-2) var(--space-3);
  font-size: var(--font-size-sm);
  border-radius: var(--radius-sm);
}

.btn--share:hover {
  background: rgba(84, 192, 145, 0.1);
  border-color: var(--color-primary);
  color: var(--color-primary);
}
```

#### Focus y Active

```css
.btn:focus-visible {
  outline: 2px solid var(--color-primary);
  outline-offset: 3px;
  border-radius: var(--radius-sm);
}

.btn:active {
  transform: translateY(1px);
}
```

#### Variantes Simples (Sección Debug/Error)

```css
.btn {
  padding: 0.6rem var(--space-5);
  border-radius: var(--radius-full);
  font-size: var(--font-size-sm);
  font-weight: 600;
  border: none;
  position: relative;
  overflow: hidden;
}

.btn-primary {
  background: var(--gradient-primary);
  background-size: 200% auto;
  color: #ffffff;
  box-shadow: 0 4px 20px rgba(var(--color-primary-rgb), 0.35);
}

.btn-primary:hover {
  background-position: right center;
  transform: translateY(-2px);
}

.btn-outline {
  background: transparent;
  color: var(--color-text);
  border: 1.5px solid var(--color-border);
  backdrop-filter: blur(10px);
}

.btn-lg {
  padding: 0.85rem var(--space-8);
  font-size: var(--font-size-base);
}
```

---

### 9.2 Badges / Tags

#### `.badge` Base

```css
.badge {
  display: inline-flex;
  align-items: center;
  gap: var(--space-1);
  padding: var(--space-1) var(--space-3);
  font-size: var(--font-size-xs);
  font-weight: 600;
  letter-spacing: 0.04em;
  line-height: 1.4;
  border-radius: var(--radius-full);
  text-decoration: none;
  white-space: nowrap;
  transition: all var(--transition-base);
}
```

#### Variantes

```css
.badge--primary {
  background: rgba(84, 192, 145, 0.15);
  border: 1px solid rgba(84, 192, 145, 0.3);
  color: var(--color-primary);
}

.badge--accent {
  background: rgba(243, 177, 102, 0.12);
  border: 1px solid rgba(243, 177, 102, 0.3);
  color: var(--color-accent);
}

.badge--green {
  background: rgba(0, 200, 100, 0.12);
  border: 1px solid rgba(0, 200, 100, 0.3);
  color: var(--color-success);
}

.badge--category {
  background: rgba(84, 192, 145, 0.15);
  color: var(--color-primary);
}

.badge--category:hover {
  background: var(--color-primary);
  color: #fff;
}

.badge--tag {
  background: var(--color-border-subtle);
  color: var(--color-text-muted);
}

.badge--tag:hover {
  background: rgba(84, 192, 145, 0.15);
  color: var(--color-primary);
}

.badge--featured {
  background: var(--gradient-primary);
  color: #fff;
  box-shadow: 0 2px 8px rgba(84, 192, 145, 0.25);
}

.badge--featured:hover {
  transform: scale(1.05);
  box-shadow: 0 4px 15px rgba(84, 192, 145, 0.35);
}
```

#### `.cat-dot`

```css
.cat-dot {
  display: inline-block;
  width: 8px;
  height: 8px;
  border-radius: 50%;
  flex-shrink: 0;
}
```

---

### 9.3 Header / Navegación

#### `.blog-header` — Sticky con Glassmorphism

```css
.blog-header {
  position: sticky;
  top: 0;
  z-index: 1000;
  background: transparent;
  border-bottom: 1px solid transparent;
  box-shadow: none;
  height: var(--header-height, 64px);
  transition: background 0.4s ease, border-color 0.4s ease,
              box-shadow 0.4s ease, backdrop-filter 0.4s ease;
}
```

#### `.blog-header--scrolled` — Glassmorphism al hacer scroll

```css
.blog-header--scrolled {
  background: rgba(255, 255, 255, 0.72);
  border-bottom: 1px solid var(--color-border);
  backdrop-filter: blur(24px) saturate(180%);
  -webkit-backdrop-filter: blur(24px) saturate(180%);
  box-shadow:
    0 4px 30px rgba(0, 0, 0, 0.06),
    0 1px 0 rgba(84, 192, 145, 0.08);
}
```

#### `.blog-header::after` — Línea de gradiente luminosa

```css
.blog-header::after {
  content: "";
  position: absolute;
  bottom: -1px;
  left: 0;
  right: 0;
  height: 2px;
  background: linear-gradient(90deg,
    transparent 0%,
    var(--color-primary, #54c091) 20%,
    var(--color-accent, var(--color-warning)) 50%,
    var(--color-primary, #54c091) 80%,
    transparent 100%
  );
  opacity: 0;
  transition: opacity 0.4s ease;
  pointer-events: none;
  z-index: 1;
}

.blog-header--scrolled::after {
  opacity: 0.7;
}
```

#### `.header-inner`

```css
.header-inner {
  display: flex;
  align-items: center;
  gap: 1rem;
  height: var(--header-height, 64px);
}
```

#### `.blog-logo`

```css
.blog-logo {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 1.25rem;
  font-weight: 800;
  color: var(--color-text);
  text-decoration: none;
  flex-shrink: 0;
  letter-spacing: -0.02em;
}

.blog-logo:hover .logo-icon {
  transform: scale(1.1) rotate(-5deg);
  filter: drop-shadow(0 0 8px rgba(84, 192, 145, 0.5));
}
```

#### `.blog-nav`, `.nav-toggle`, `.nav-toggle-bar`

```css
.blog-nav {
  flex: 1;
  display: flex;
  justify-content: center;
}

.nav-toggle {
  display: none; /* visible en ≤768px */
  flex-direction: column;
  gap: 5px;
  padding: 0.375rem;
  border-radius: var(--radius-sm);
  cursor: pointer;
}

.nav-toggle-bar {
  display: block;
  width: 22px;
  height: 2px;
  background: var(--color-text);
  border-radius: 1px;
  transition: transform var(--transition-base), opacity var(--transition-base);
}
```

#### `.nav-list`, `.nav-item`, `.nav-link`

```css
.nav-list {
  display: flex;
  align-items: center;
  gap: 0.25rem;
}

.nav-link {
  display: flex;
  align-items: center;
  gap: 0.25rem;
  padding: 0.4rem 0.75rem;
  font-size: 0.9375rem;
  font-weight: 500;
  color: var(--color-text-muted);
  border-radius: var(--radius-full);
}

.nav-link:hover, .nav-link--active {
  background: rgba(84, 192, 145, 0.15);
  color: var(--color-primary);
}
```

#### `.nav-dropdown`

```css
.nav-dropdown {
  display: none;
  position: absolute;
  top: calc(100% + 0.5rem);
  left: 50%;
  transform: translateX(-50%);
  min-width: 200px;
  background: var(--color-surface, #fff);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-md);
  padding: 0.5rem;
  z-index: 100;
}

.nav-dropdown--open {
  display: block;
  animation: dropdownIn 0.15s ease;
}
```

#### `.mobile-nav-overlay`

```css
.mobile-nav-overlay {
  display: none;
  position: fixed;
  inset: 0;
  top: var(--header-height, 64px);
  background: rgba(0, 0, 0, 0.45);
  backdrop-filter: blur(4px);
  z-index: 998;
  animation: mobileOverlayFadeIn 0.2s ease forwards;
}

.mobile-nav-overlay--visible {
  display: block;
}
```

---

### 9.4 Breadcrumbs

```css
.breadcrumbs {
  background: transparent;
  border-bottom: none;
  padding: 0.5rem 0;
}

.breadcrumb-list {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 0.1rem;
  font-size: 0.8125rem;
}

.breadcrumb-link {
  color: var(--color-text-dim, #8a8aaa);
  text-decoration: none;
  padding: 0.15rem 0.25rem;
  border-radius: var(--radius-sm);
  opacity: 0.7;
}

.breadcrumb-link:hover {
  color: var(--color-primary);
  opacity: 1;
}

.breadcrumb-current {
  color: var(--color-text-muted, #5a5a78);
  font-weight: 500;
}

.breadcrumb-sep {
  color: var(--color-text-dim, #8a8aaa);
  font-size: 0.65rem;
  opacity: 0.4;
}
```

---

### 9.5 Formulario de Búsqueda

#### Principal

```css
.search-form-inner {
  display: flex;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-full, 9999px);
  overflow: hidden;
  background: rgba(255, 255, 255, 0.5);
  backdrop-filter: blur(16px) saturate(140%);
  -webkit-backdrop-filter: blur(16px) saturate(140%);
  transition: border-color var(--transition-base),
              box-shadow var(--transition-base),
              background var(--transition-base);
}

.search-form-inner:focus-within {
  border-color: var(--color-primary);
  box-shadow:
    0 0 0 3px rgba(84, 192, 145, 0.12),
    0 4px 20px rgba(84, 192, 145, 0.1);
  background: rgba(255, 255, 255, 0.75);
}

.search-input {
  flex: 1;
  padding: 0.6rem 0.875rem;
  font-size: 0.9375rem;
  font-family: inherit;
  border: none;
  outline: none;
  background: transparent;
  color: var(--color-text);
  min-width: 0;
}

.search-btn {
  padding: 0.5rem 0.875rem;
  background: var(--color-primary);
  color: #fff;
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}
```

#### Variante Compacta (Header)

```css
.search-form--compact .search-form-inner {
  border-radius: 999px;
}

.search-input--compact {
  padding: 0.375rem 0.875rem;
  font-size: 0.875rem;
}

.search-btn--compact {
  padding: 0.375rem 0.75rem;
  border-radius: 0 999px 999px 0;
}
```

---

### 9.6 Sidebar Widgets

#### `.widget` (Glassmorphism)

```css
.widget {
  background: rgba(255, 255, 255, 0.6);
  backdrop-filter: blur(16px) saturate(140%);
  -webkit-backdrop-filter: blur(16px) saturate(140%);
  border: 1px solid var(--color-border-subtle);
  border-left: 3px solid var(--color-primary, #54c091);
  border-radius: var(--radius-lg);
  padding: 1.25rem;
  box-shadow: var(--shadow-sm), 0 0 0 1px rgba(84, 192, 145, 0.05);
}
```

#### `.widget-title` (Subrayado gradiente)

```css
.widget-title {
  font-size: 0.9375rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: var(--color-text);
  margin-bottom: 1rem;
  padding-bottom: 0.75rem;
  position: relative;
}

.widget-title::after {
  content: "";
  position: absolute;
  bottom: 0;
  left: 0;
  width: 40px;
  height: 3px;
  border-radius: 2px;
  background: var(--gradient-primary);
}
```

#### Posts Recientes

```css
.widget-post-list { display: flex; flex-direction: column; gap: 0.75rem; }

.widget-post { display: flex; gap: 0.625rem; align-items: flex-start; }

.widget-post-thumb {
  flex-shrink: 0;
  width: 60px;
  height: 60px;
  border-radius: var(--radius-sm);
  overflow: hidden;
}

.widget-post-title {
  font-size: 0.875rem;
  font-weight: 600;
  line-height: 1.4;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  overflow: hidden;
}
```

#### Categorías

```css
.widget-category-list { display: flex; flex-direction: column; gap: 0.25rem; }

.widget-category-link {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.4rem 0.5rem;
  font-size: 0.9rem;
  color: var(--color-text-muted);
  border-radius: var(--radius-sm);
}

.widget-category-link:hover {
  background: rgba(84, 192, 145, 0.15);
  color: var(--color-primary);
}
```

#### Nube de Tags

```css
.tag-cloud { display: flex; flex-wrap: wrap; gap: 0.4rem; }

.tag-cloud-item {
  padding: 0.3em 0.75em;
  font-size: 0.8125rem;
  font-weight: 500;
  color: var(--color-text-muted);
  border: 1px solid var(--color-border);
  border-radius: 999px;
}

.tag-cloud-item:hover, .tag-cloud-item--active {
  background: var(--color-primary);
  color: #fff;
  border-color: var(--color-primary);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(84, 192, 145, 0.25);
}
```

---

### 9.7 Post Cards

#### `.posts-grid`

```css
.posts-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: var(--space-6);
}
```

#### `.post-card` (Gradiente border glow en hover)

```css
.post-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border-subtle);
  border-radius: var(--radius-xl);
  overflow: hidden;
  box-shadow: var(--shadow-sm);
  display: flex;
  flex-direction: column;
  position: relative;
  transition: all var(--transition-slow);
}

.post-card:hover {
  border-color: var(--color-border);
  transform: translateY(-4px);
  box-shadow: var(--shadow-primary);
}

/* Gradiente border glow en hover */
.post-card::before {
  content: "";
  position: absolute;
  inset: -1px;
  border-radius: inherit;
  background: linear-gradient(135deg,
    rgba(84, 192, 145, 0.4), transparent 40%,
    transparent 60%, rgba(243, 177, 102, 0.3)
  );
  z-index: -1;
  opacity: 0;
  transition: opacity 0.4s ease;
  pointer-events: none;
}

.post-card:hover::before {
  opacity: 1;
}
```

#### `.post-card--featured`

```css
.post-card--featured {
  border-color: var(--color-primary);
  border-width: 2px;
}
```

#### Sub-elementos

```css
.post-card__image-wrap {
  position: relative;
  aspect-ratio: 16 / 9;
  overflow: hidden;
  background: var(--color-border-subtle);
}

.post-card__image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.post-card:hover .post-card__image {
  transform: scale(1.08);
}

.post-card__featured-badge {
  position: absolute;
  top: 0.75rem;
  left: 0.75rem;
  background: var(--gradient-primary);
  color: #fff;
  padding: 0.25em 0.75em;
  font-size: 0.7rem;
  font-weight: 700;
  text-transform: uppercase;
  border-radius: 999px;
  box-shadow: 0 4px 12px rgba(84, 192, 145, 0.3);
}

.post-card__body {
  flex: 1;
  padding: 1.25rem;
  display: flex;
  flex-direction: column;
  gap: 0.625rem;
}

.post-card__title {
  font-size: 1.0625rem;
  font-weight: 700;
  line-height: 1.4;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  overflow: hidden;
}

.post-card__excerpt {
  font-size: 0.9rem;
  color: var(--color-text-muted);
  line-height: 1.6;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  overflow: hidden;
  flex: 1;
}

.post-card__footer {
  padding: 0.875rem 1.25rem;
  border-top: 1px solid var(--color-border-subtle);
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.post-card__read-more {
  font-size: 0.875rem;
  font-weight: 600;
  color: var(--color-primary);
  position: relative;
}

/* Underline animado en read more */
.post-card__read-more::after {
  content: "";
  position: absolute;
  bottom: -2px;
  left: 0;
  width: 0;
  height: 2px;
  background: var(--gradient-primary);
  transition: width 0.35s ease;
}

.post-card__read-more:hover::after {
  width: 100%;
}
```

#### Variantes de list.php

```css
/* Cover link con overlay gradiente */
.post-card__cover-link { display: block; text-decoration: none; }

.post-card__cover-wrapper {
  position: relative;
  aspect-ratio: 16 / 9;
  overflow: hidden;
}

.post-card__cover-wrapper::after {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(0deg, rgba(0,0,0,0.06) 0%, transparent 40%);
  pointer-events: none;
}

/* Badge en cover */
.post-card__badge {
  position: absolute;
  top: 0.75rem;
  left: 0.75rem;
  padding: 0.25em 0.75em;
  font-size: 0.7rem;
  font-weight: 700;
  text-transform: uppercase;
  border-radius: 999px;
}

.post-card__badge--featured {
  background: var(--gradient-primary);
  color: #fff;
}

/* Categoría como pill */
.post-card__category {
  display: inline-flex;
  align-items: center;
  padding: 0.2em 0.6em;
  font-size: 0.75rem;
  font-weight: 600;
  color: var(--cat-color, var(--color-primary));
  background: rgba(84, 192, 145, 0.1);
  border: 1px solid rgba(84, 192, 145, 0.15);
  border-radius: 999px;
}

.post-card__category:hover {
  background: var(--cat-color, var(--color-primary));
  color: #fff;
}

/* Meta y tags */
.post-card__meta-main { display: flex; align-items: center; gap: 0.5rem; font-size: 0.8125rem; }
.post-card__views { display: inline-flex; align-items: center; gap: 0.25rem; }
.post-card__tag {
  padding: 0.2em 0.55em;
  font-size: 0.75rem;
  border: 1px solid var(--color-border);
  border-radius: 999px;
}

/* Read more con underline animado */
.post-card__read-more-link {
  position: relative;
  font-size: 0.875rem;
  font-weight: 600;
  color: var(--color-primary);
}

.post-card__read-more-link::after {
  content: "";
  position: absolute;
  bottom: -2px;
  left: 0;
  width: 0;
  height: 2px;
  background: var(--gradient-primary);
  transition: width 0.35s ease;
}

.post-card__read-more-link:hover::after {
  width: 100%;
}
```

---

### 9.8 Pagination

#### Base

```css
.pagination {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.375rem;
  margin-top: 2.5rem;
  flex-wrap: wrap;
}

.pagination__link {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 2.5rem;
  height: 2.5rem;
  padding: 0 0.5rem;
  font-size: 0.9375rem;
  color: var(--color-text-muted);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-full);
  background: var(--color-surface, #fff);
}

.pagination__link:hover {
  background: rgba(84, 192, 145, 0.15);
  border-color: var(--color-primary);
  color: var(--color-primary);
  box-shadow: 0 0 15px rgba(84, 192, 145, 0.15);
  transform: translateY(-1px);
}

.pagination__current {
  background: var(--gradient-primary);
  color: #fff;
  border: 1px solid transparent;
  border-radius: var(--radius-full);
  box-shadow: 0 4px 15px rgba(84, 192, 145, 0.3);
}

.pagination__ellipsis {
  color: var(--color-text-muted);
  cursor: default;
  pointer-events: none;
}

.pagination__prev, .pagination__next {
  gap: 0.35rem;
  font-size: 0.875rem;
}

.pagination__link--disabled {
  opacity: 0.4;
  pointer-events: none;
}
```

#### Variante list.php

```css
.blog-list__pagination {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.75rem;
  margin-top: 2.5rem;
}

.pagination__list {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.375rem;
  list-style: none;
}

.pagination__link--current {
  background: var(--gradient-primary);
  color: #fff;
  box-shadow: 0 4px 12px rgba(84, 192, 145, 0.25);
  font-weight: 600;
}

.pagination__info {
  font-size: 0.8125rem;
  color: var(--color-text-muted);
  text-align: center;
}
```

---

### 9.9 Post Detail

#### `.post-header`

```css
.post-header {
  margin-bottom: 2rem;
}

.post-header__categories {
  display: flex;
  flex-wrap: wrap;
  gap: 0.4rem;
  margin-bottom: 0.875rem;
}

.post-header__title {
  font-size: clamp(1.75rem, 4vw, 2.5rem);
  font-weight: 800;
  line-height: 1.2;
  letter-spacing: -0.02em;
}

.post-header__meta {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 1rem;
  font-size: 0.9rem;
  color: var(--color-text-muted);
  padding-bottom: 1.25rem;
  border-bottom: 1px solid var(--color-border-subtle);
}
```

#### `.post-cover`

```css
.post-cover {
  margin-bottom: 2rem;
  border-radius: var(--radius-lg);
  overflow: hidden;
  box-shadow: var(--shadow-md);
  aspect-ratio: 16 / 6;
}

.post-cover__img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.post-cover__caption {
  font-size: 0.8125rem;
  color: var(--color-text-muted);
  text-align: center;
  font-style: italic;
}
```

#### `.post-toc` / `.toc` — Tabla de Contenidos

```css
.post-toc {
  background: rgba(84, 192, 145, 0.15);
  border: 1px solid rgba(13, 110, 253, 0.2);
  border-radius: var(--radius-md);
  margin-bottom: 2rem;
  overflow: hidden;
}

.post-toc__header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0.75rem 1rem;
  cursor: pointer;
  user-select: none;
}

.post-toc__title {
  font-size: 0.9rem;
  font-weight: 700;
  color: var(--color-primary);
}

.post-toc__link:hover, .post-toc__link--active {
  color: var(--color-primary);
  padding-left: 0.375rem;
}

/* Indentación por nivel */
.post-toc__item--level-1 { padding-left: 0; }
.post-toc__item--level-2 { padding-left: 1rem; }
.post-toc__item--level-3 { padding-left: 2rem; }
.post-toc__item--level-4 { padding-left: 3rem; }
```

#### Tags y Compartir

```css
.post-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.4rem;
  margin-top: 2rem;
  padding-top: 1.25rem;
  border-top: 1px solid var(--color-border-subtle);
}

.post-share {
  display: flex;
  align-items: center;
  gap: 0.625rem;
  margin-top: 1.5rem;
}
```

#### Variantes de post.php

```css
.post__categories { display: flex; flex-wrap: wrap; gap: 0.4rem; }
.post__title { font-size: clamp(1.75rem, 4vw, 2.5rem); font-weight: 800; }
.post__meta {
  display: flex; align-items: center; flex-wrap: wrap; gap: 0.75rem;
  padding-bottom: 1.25rem; border-bottom: 1px solid var(--color-border-subtle);
}
.post__cover-wrapper { margin-bottom: 2rem; border-radius: var(--radius-xl); aspect-ratio: 16/7; }
.post__body { margin-bottom: 2rem; }
.post__tags { display: flex; flex-wrap: wrap; gap: 0.5rem; margin-top: 2rem; border-top: 1px solid var(--color-border-subtle); }
.post__tag {
  padding: 0.25em 0.65em; font-size: 0.8125rem;
  border: 1px solid var(--color-border); border-radius: 999px;
}
.post__share { display: flex; align-items: center; gap: 0.625rem; margin-top: 1.5rem; }
.post__share-link {
  padding: 0.375rem 0.75rem; font-size: 0.8125rem;
  border: 1px solid var(--color-border); border-radius: 999px;
}
```

---

### 9.10 Related Posts

```css
.related-posts {
  margin-top: 3rem;
  padding-top: 2rem;
  border-top: 2px solid var(--color-border-subtle);
}

.related-posts__title {
  font-size: 1.375rem;
  font-weight: 700;
  margin-bottom: 1.5rem;
}

.related-posts__grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
  gap: 1.25rem;
}

.related-post-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border-subtle);
  border-radius: var(--radius-lg);
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.related-post-card:hover {
  box-shadow: 0 8px 30px rgba(0,0,0,0.1), 0 0 20px rgba(84,192,145,0.06);
  transform: translateY(-3px);
}

.related-post-card__cover { width: 100%; height: 100%; object-fit: cover; }
.related-post-card__body { padding: 1rem 1.125rem; flex: 1; }
.related-post-card__title { font-size: 0.9375rem; font-weight: 700; -webkit-line-clamp: 2; }
.related-post-card__excerpt { font-size: 0.8125rem; -webkit-line-clamp: 2; }
.related-post-card__meta { font-size: 0.75rem; margin-top: auto; }
```

---

### 9.11 Blog Hero

```css
.blog-hero, .blog-list__hero {
  background: var(--gradient-primary) padding-box,
    linear-gradient(135deg, var(--color-primary) 0%, #2d8f6f 40%, #f3b166 100%) border-box;
  color: #fff;
  padding: 4rem 0 3rem;
  margin-bottom: 2rem;
  text-align: center;
  border-radius: 0 0 var(--radius-xl) var(--radius-xl);
  position: relative;
  overflow: hidden;
  background-size: 200% 200%;
  animation: gradientShiftBg 12s ease infinite;
}

/* Grid pattern overlay */
.blog-hero::before {
  content: "";
  position: absolute;
  inset: 0;
  background-image:
    linear-gradient(rgba(255,255,255,0.03) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255,255,255,0.03) 1px, transparent 1px);
  background-size: 60px 60px;
  pointer-events: none;
  z-index: 0;
}

/* Animated glow blobs */
.blog-hero::after {
  content: "";
  position: absolute;
  inset: 0;
  background:
    radial-gradient(ellipse 300px 200px at 25% 40%, rgba(84,192,145,0.35) 0%, transparent 70%),
    radial-gradient(ellipse 250px 180px at 75% 60%, rgba(243,177,102,0.3) 0%, transparent 70%),
    radial-gradient(ellipse 200px 150px at 50% 80%, rgba(84,192,145,0.2) 0%, transparent 70%);
  pointer-events: none;
  animation: floatSlow 8s ease-in-out infinite;
}

.blog-hero__eyebrow {
  font-size: 0.8125rem;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  font-weight: 600;
  opacity: 0.85;
}

.blog-hero__title {
  font-size: clamp(1.75rem, 5vw, 3rem);
  font-weight: 800;
  background: linear-gradient(135deg, #fff 0%, rgba(255,255,255,0.85) 50%, #fff 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.blog-hero__description {
  font-size: 1.0625rem;
  opacity: 0.92;
  max-width: 560px;
  margin-inline: auto;
}
```

---

### 9.12 Blog List Layout

```css
.blog-list__header {
  margin-bottom: 1.75rem;
  padding-bottom: 1.25rem;
  border-bottom: 2px solid rgba(84, 192, 145, 0.15);
}

.blog-list__heading {
  font-size: clamp(1.5rem, 4vw, 2.25rem);
  font-weight: 800;
}

.blog-list__count {
  font-size: 0.875rem;
  color: var(--color-text-muted);
}

.blog-list__layout {
  display: grid;
  grid-template-columns: 1fr;
  gap: 2.5rem;
  align-items: start;
}

.blog-list__grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 1.5rem;
  list-style: none;
  counter-reset: post-counter;
}

.blog-list__grid-item--featured {
  grid-column: 1 / -1;
}

.blog-list__sidebar {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
  position: sticky;
  top: calc(var(--header-height, 64px) + 1rem);
  max-height: calc(100vh - var(--header-height, 64px) - 2rem);
  overflow-y: auto;
}

.sidebar-widget {
  background: var(--color-surface, #fff);
  border: 1px solid var(--color-border-subtle);
  border-radius: var(--radius-lg);
  padding: 1.25rem;
}

.blog-list__empty {
  text-align: center;
  padding: 4rem 1.5rem;
}

.blog-list__empty-icon {
  width: 80px;
  height: 80px;
  color: var(--color-text-muted);
  opacity: 0.4;
}

.blog-list__empty-title {
  font-size: 1.375rem;
  font-weight: 700;
}
```

---

### 9.13 Archive Header

```css
.archive-header {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  padding: 1.5rem;
  background: rgba(255, 255, 255, 0.6);
  backdrop-filter: blur(12px) saturate(140%);
  border: 1px solid var(--color-border-subtle);
  border-left: 3px solid var(--color-primary, #54c091);
  border-radius: var(--radius-lg);
  margin-bottom: 1.75rem;
}

.archive-header__icon {
  width: 48px;
  height: 48px;
  border-radius: var(--radius-md);
  background: rgba(84, 192, 145, 0.15);
  color: var(--color-primary);
  font-size: 1.5rem;
  flex-shrink: 0;
}

.archive-header__title {
  font-size: 1.5rem;
  font-weight: 800;
}

.archive-header__description {
  font-size: 0.9375rem;
  color: var(--color-text-muted);
}

.archive-header__count {
  font-size: 0.875rem;
  color: var(--color-text-muted);
}
```

---

### 9.14 Search Page

```css
.search-page-header {
  background:
    radial-gradient(ellipse 80% 60% at 50% -10%, rgba(84,192,145,0.08) 0%, transparent 60%),
    var(--color-surface);
  border: 1px solid var(--color-border-subtle);
  border-radius: 0 0 var(--radius-xl) var(--radius-xl);
  padding: 2.5rem 0 2rem;
}

.search-page-input-wrap {
  display: flex;
  align-items: center;
  border: 2px solid var(--color-border);
  border-radius: 9999px;
}

.search-page-input-wrap:focus-within {
  border-color: var(--color-primary);
  box-shadow: 0 0 0 4px rgba(84, 192, 145, 0.1);
}

.search-page-submit {
  padding: 0.7rem 1.5rem;
  background: var(--gradient-primary);
  color: #fff;
  border-radius: 9999px;
}

.search-highlight {
  background: rgba(255, 193, 7, 0.3);
  font-weight: 600;
  border-radius: 2px;
}

.search-result-item {
  padding: 1.25rem;
  background: var(--color-surface);
  border: 1px solid var(--color-border-subtle);
  border-radius: var(--radius-lg);
}

.search-result-item:hover {
  box-shadow: var(--shadow-md);
  transform: translateX(4px);
}

.search-stats {
  font-size: 0.9375rem;
  color: var(--color-text-muted);
  padding-bottom: 1rem;
  border-bottom: 1px solid var(--color-border-subtle);
}
```

---

### 9.15 Alerts

```css
.alert {
  padding: 0.875rem 1.125rem;
  border-radius: var(--radius-md);
  margin-bottom: 1.25rem;
  font-size: 0.9375rem;
  display: flex;
  align-items: flex-start;
  gap: 0.625rem;
  border: 1px solid transparent;
}

.alert--danger {
  background: #f8d7da;
  color: #842029;
  border-color: #f5c2c7;
}

.alert--warning {
  background: #fff3cd;
  color: #664d03;
  border-color: #ffecb5;
}

.alert--info {
  background: rgba(84, 192, 145, 0.15);
  color: var(--color-primary);
  border-color: rgba(13, 110, 253, 0.2);
}

.alert--success {
  background: #d1e7dd;
  color: #0a3622;
  border-color: #badbcc;
}
```

---

### 9.16 Empty State

```css
.empty-state {
  text-align: center;
  padding: 3rem 1.5rem;
  color: var(--color-text-muted);
}

.empty-state__icon {
  font-size: 4rem;
  margin-bottom: 1rem;
  opacity: 0.4;
}

.empty-state__title {
  font-size: 1.375rem;
  font-weight: 700;
  margin-bottom: 0.5rem;
}

.empty-state__description {
  font-size: 0.9375rem;
  max-width: 400px;
  margin-inline: auto;
  margin-bottom: 1.5rem;
}
```

---

### 9.17 Footer

```css
.blog-footer {
  background: var(--color-text);
  color: var(--color-text-dim);
  padding: var(--space-12) 0 var(--space-6);
  margin-top: var(--space-12);
  position: relative;
}

/* Glow line en la parte superior */
.blog-footer::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 2px;
  background: linear-gradient(90deg,
    transparent 0%,
    var(--color-primary) 15%,
    var(--color-accent) 50%,
    var(--color-primary) 85%,
    transparent 100%
  );
  opacity: 0.6;
}

.footer-inner {
  display: grid;
  grid-template-columns: 1.5fr auto auto auto;
  gap: 2.5rem;
  padding-bottom: 2.5rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
}

.footer-logo {
  font-size: 1.25rem;
  font-weight: 800;
  color: #fff;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.footer-nav-title {
  font-size: 0.8125rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  color: rgba(255, 255, 255, 0.5);
}

.footer-link {
  color: var(--color-text-dim);
  font-size: 0.9rem;
}

.footer-link:hover {
  color: var(--color-primary);
  padding-left: 0.25rem;
}

.footer-link-dot {
  width: 4px;
  height: 4px;
  background: rgba(255, 255, 255, 0.15);
  border-radius: 50%;
}

.footer-social {
  display: flex;
  gap: 0.75rem;
}

.footer-social-link {
  width: 38px;
  height: 38px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.06);
  color: var(--color-text-dim);
}

.footer-social-link:hover {
  background: var(--color-primary);
  color: #fff;
  transform: translateY(-2px);
}

.footer-bottom {
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
}

.footer-copyright {
  font-size: 0.875rem;
  color: #6c757d;
}
```

---

### 9.18 Scroll-to-Top

```css
.scroll-to-top {
  position: fixed;
  bottom: 2rem;
  right: 2rem;
  z-index: var(--z-raised, 10);
  width: 48px;
  height: 48px;
  border-radius: var(--radius-full);
  background: var(--gradient-primary);
  color: #fff;
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.25rem;
  box-shadow: 0 4px 20px rgba(84, 192, 145, 0.35), 0 2px 8px rgba(0, 0, 0, 0.15);
  opacity: 0;
  visibility: hidden;
  transform: translateY(10px);
  transition: opacity 0.35s ease, visibility 0.35s ease,
              transform 0.35s ease, box-shadow 0.35s ease;
  pointer-events: none;
}

.scroll-to-top--visible {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
  pointer-events: auto;
}

.scroll-to-top:hover {
  box-shadow: 0 6px 30px rgba(84, 192, 145, 0.45), 0 4px 12px rgba(0, 0, 0, 0.15);
  transform: translateY(-3px);
}
```

---

### 9.19 Skeleton Loading

```css
@keyframes skeleton-loading {
  0%   { background-position: -200px 0; }
  100% { background-position: calc(200px + 100%) 0; }
}

.skeleton {
  background: linear-gradient(90deg,
    var(--color-border-subtle) 25%,
    var(--color-border) 50%,
    var(--color-border-subtle) 75%
  );
  background-size: 200px 100%;
  animation: skeleton-loading 1.5s ease-in-out infinite;
  border-radius: var(--radius-sm);
}
```

---

### 9.20 Debug Bar

```css
.debug-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 9998;
  background: #1a1d21;
  color: #cdd6f4;
  border-top: 2px solid var(--color-primary);
  font-family: var(--blog-mono);
  font-size: 0.8125rem;
}

.debug-bar-toggle {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.4rem 1rem;
  cursor: pointer;
  color: #cdd6f4;
  font-weight: 600;
}

.debug-badge {
  padding: 0.1em 0.5em;
  border-radius: 999px;
  font-size: 0.75rem;
}

.debug-badge--success { background: #198754; color: #fff; }
.debug-badge--warning { background: #ffc107; color: #000; }

.debug-table {
  border-collapse: collapse;
  width: 100%;
  font-size: 0.8125rem;
}

.debug-table th { color: #89b4fa; font-weight: 600; }
```

---

### 9.21 Error Pages

```css
.error-page {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 50vh;
  padding: var(--space-8);
}

.error-content { text-align: center; }

.error-title {
  font-size: 5rem;
  font-weight: 800;
  background: var(--gradient-primary);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  line-height: 1;
  margin-bottom: var(--space-2);
}

.error-content h2 {
  font-size: var(--font-size-2xl);
  margin-bottom: var(--space-3);
}

.error-content p {
  color: var(--color-text-muted);
  margin-bottom: var(--space-6);
}

.error-actions {
  display: flex;
  gap: var(--space-4);
  justify-content: center;
}

.error-debug {
  margin-top: var(--space-4);
  padding: var(--space-4);
  background: var(--color-text);
  color: #4ade80;
  border-radius: var(--radius-md);
  font-family: var(--font-mono);
  font-size: var(--font-size-sm);
}
```

---

### 9.22 Static Pages

```css
.page-header {
  margin-bottom: 2rem;
  padding-bottom: 1.5rem;
  border-bottom: 2px solid rgba(84, 192, 145, 0.15);
}

.page-header__title {
  font-size: clamp(1.75rem, 4vw, 2.25rem);
  font-weight: 800;
  letter-spacing: -0.02em;
}

.page-header__updated {
  font-size: 0.875rem;
  color: var(--color-text-muted);
}

.page-content {
  font-size: 1.0625rem;
  line-height: 1.8;
}
```

---

## 10. Clases Utilitarias

### Layout — Flex

```css
.d-flex        { display: flex; }
.align-center  { align-items: center; }
.gap-1         { gap: 0.25rem; }
.gap-2         { gap: 0.5rem; }
.gap-3         { gap: 1rem; }
```

### Espaciado

```css
.mt-1 { margin-top: 0.25rem; }
.mt-2 { margin-top: 0.5rem; }
.mt-3 { margin-top: 1rem; }
.mt-4 { margin-top: 1.5rem; }
.mb-1 { margin-bottom: 0.25rem; }
.mb-2 { margin-bottom: 0.5rem; }
.mb-3 { margin-bottom: 1rem; }
.mb-4 { margin-bottom: 1.5rem; }
```

### Texto

```css
.text-muted  { color: var(--color-text-muted); }
.text-center { text-align: center; }
.text-right  { text-align: right; }
```

### Contenedor

```css
.container {
  width: 100%;
  max-width: var(--container-max, 1200px);
  margin-inline: auto;
  padding-inline: 1.25rem;
}
```

### Accesibilidad

```css
.skip-link {
  position: absolute;
  top: -100%;
  left: 0;
  z-index: 9999;
  padding: 0.75rem 1.5rem;
  background: var(--color-primary);
  color: #fff;
  text-decoration: none;
  font-weight: 600;
  border-radius: 0 0 var(--radius-md) 0;
  transition: top var(--transition-base);
}

.skip-link:focus {
  top: 0;
}

.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}
```

### Efectos

```css
.gradient-text {
  background: var(--gradient-primary);
  background-size: 200% auto;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  animation: gradientShift 4s ease infinite;
}

.divider-glow {
  height: 1px;
  background: linear-gradient(90deg, transparent, var(--color-primary), var(--color-accent), var(--color-primary), transparent);
  opacity: 0.4;
  margin: 2rem 0;
}
```

### Blog-Front Utility Classes (prefijo `bf-`)

Todas estas clases están scoped bajo `.blog-front-shell` en el módulo Angular:

#### Layout

| Clase | CSS | Descripción |
|---|---|---|
| `bf-flex` | `display: flex` | Flex container |
| `bf-flex-col` | `flex-direction: column` | Flex columna |
| `bf-flex-center` | `align-items: center; justify-content: center` | Centrado completo |
| `bf-flex-between` | `align-items: center; justify-content: space-between` | Espaciado entre |
| `bf-items-center` | `align-items: center` | Alinear items al centro |
| `bf-grid` | `display: grid` | Grid container |

#### Gap

| Clase | Valor |
|---|---|
| `bf-gap-2` | `var(--space-2)` |
| `bf-gap-4` | `var(--space-4)` |
| `bf-gap-6` | `var(--space-6)` |
| `bf-gap-8` | `var(--space-8)` |

#### Texto

| Clase | CSS |
|---|---|
| `bf-text-center` | `text-align: center` |
| `bf-text-left` | `text-align: left` |
| `bf-text-right` | `text-align: right` |
| `bf-text-primary` | `color: var(--color-primary) !important` |
| `bf-text-accent` | `color: var(--color-accent) !important` |
| `bf-text-muted` | `color: var(--color-text-muted) !important` |
| `bf-text-white` | `color: #ffffff !important` |

#### Font Weight

| Clase | Valor |
|---|---|
| `bf-font-light` | `300` |
| `bf-font-normal` | `400` |
| `bf-font-semibold` | `600` |
| `bf-font-bold` | `700` |
| `bf-font-black` | `900` |

#### Spacing

| Clase | CSS |
|---|---|
| `bf-mt-auto` | `margin-top: auto` |
| `bf-mx-auto` | `margin-left: auto; margin-right: auto` |

#### Display

| Clase | CSS |
|---|---|
| `bf-d-none` | `display: none` |
| `bf-d-block` | `display: block` |
| `bf-cursor-pointer` | `cursor: pointer` |
| `bf-sr-only` | Screen reader only (clipped) |

#### Animaciones (prefijo `bf-animate-`)

| Clase | Keyframe | Duración |
|---|---|---|
| `bf-animate-fadeInUp` | `bf-fadeInUp` | 0.7s ease |
| `bf-animate-fadeIn` | `bf-fadeIn` | 0.6s ease |
| `bf-animate-fadeInDown` | `bf-fadeInDown` | 0.6s ease |
| `bf-animate-slideInLeft` | `bf-slideInLeft` | 0.6s ease |
| `bf-animate-slideInRight` | `bf-slideInRight` | 0.6s ease |
| `bf-animate-scaleIn` | `bf-scaleIn` | 0.5s ease |
| `bf-animate-float` | `bf-float` | 4s infinite |
| `bf-animate-float-slow` | `bf-floatSlow` | 7s infinite |
| `bf-animate-pulse` | `bf-pulse` | 2s infinite |
| `bf-animate-pulse-dot` | `bf-pulseDot` | 2s infinite |
| `bf-animate-gradient-shift` | `bf-gradientShift` | 4s infinite |
| `bf-animate-rotate` | `bf-rotate` | 20s infinite |
| `bf-animate-shimmer` | `bf-shimmer` | 2s infinite |
| `bf-animate-border-glow` | `bf-borderGlow` | 3s infinite |

#### Delays (prefijo `bf-delay-`)

`bf-delay-100` (0.1s), `bf-delay-200` (0.2s), `bf-delay-300` (0.3s), `bf-delay-400` (0.4s), `bf-delay-500` (0.5s), `bf-delay-600` (0.6s), `bf-delay-800` (0.8s), `bf-delay-1000` (1s)

#### Responsive Visibility

| Clase | Media Query | Efecto |
|---|---|---|
| `bf-hide-lg` | `max-width: 1024px` | `display: none !important` |
| `bf-hide-md` | `max-width: 768px` | `display: none !important` |
| `bf-hide-sm` | `max-width: 480px` | `display: none !important` |
| `bf-show-mobile` | `min-width: 769px` | `display: none !important` |

#### Contenedores y Secciones

| Clase | Descripción |
|---|---|
| `bf-container` | Contenedor centrado con max-width |
| `bf-container-sm` | Contenedor estrecho |
| `bf-container-xs` | Contenedor extra estrecho |
| `bf-section-padding` | Padding vertical de sección |
| `bf-section-padding-sm` | Padding vertical reducido |
| `bf-section-label` | Label de sección (eyebrow) |
| `bf-section-title` | Título de sección |
| `bf-section-subtitle` | Subtítulo de sección |

#### Componentes Blog-Front

| Clase | Descripción |
|---|---|
| `bf-btn*` | Botones con variantes |
| `bf-card` | Tarjeta base |
| `bf-badge*` | Badges con variantes |
| `bf-divider*` | Divisores con variantes |
| `bf-gradient-text` | Texto con gradiente |
| `bf-glow-*` | Efectos de glow |

---

## 11. Z-Index Scale

| Token | Valor | Uso |
|---|---|---|
| `--z-below` | `-1` | Elementos detrás del contenido (glow blobs) |
| `--z-base` | `0` | Contenido normal |
| `--z-raised` | `10` | Elementos elevados (scroll-to-top) |
| `--z-overlay` | `100` | Overlays, dropdowns |
| `--z-modal` | `1000` | Modales |
| `--z-nav` | `9000` | Navegación |
| `--z-toast` | `9999` | Notificaciones toast |
| **Debug bar** | `9998` | Barra de debug (fija abajo) |

---

## 12. Dark Theme

### Activación

El dark theme se activa con la clase `.dark-theme` en el `<body>` o `<html>`. También se soporta `prefers-color-scheme: dark` como media query.

### Tokens que Cambian

| Token | Light | Dark |
|---|---|---|
| `--color-bg` | `#f4f4f8` | `#0a0a0f` |
| `--color-surface` | `#ffffff` | `#12121a` |
| `--color-surface-2` | `#eaeaf4` | `#1a1a2e` |
| `--color-text` | `#0f0f1a` | `#ffffff` |
| `--color-text-muted` | `#5a5a78` | `#a0a0b8` |
| `--color-text-dim` | `#8a8aaa` | `#6a6a8a` |
| `--color-border-subtle` | `rgba(0,0,0,0.06)` | `rgba(255,255,255,0.06)` |
| `--gradient-bg` | `180deg, #f4f4f8 → #eaeaf4` | `180deg, #0a0a0f → #0d0d1a` |
| `--gradient-surface` | `135deg, #fff → #eaeaf4` | `135deg, #12121a → #1a1a2e` |
| `--shadow-sm` | `0 1px 3px rgba(0,0,0,0.1)` | `0 1px 3px rgba(0,0,0,0.4)` |
| `--shadow-md` | `0 4px 16px rgba(0,0,0,0.12)` | `0 4px 16px rgba(0,0,0,0.5)` |
| `--shadow-lg` | `0 8px 32px rgba(0,0,0,0.15)` | `0 8px 32px rgba(0,0,0,0.6)` |

### Colores que NO Cambian

- `--color-primary` (siempre `rgb(84, 192, 145)`)
- `--color-accent` (siempre `rgb(243, 177, 102)`)
- `--color-success`, `--color-warning`, `--color-danger`, `--color-info`
- `--color-border` (siempre con tinte primario)
- Tipografía, espaciado, border-radius, transiciones

### Componentes con Overrides Dark

#### Body y Headings

```css
.dark-theme body { color: var(--color-text); background-color: var(--color-bg); }
.dark-theme h1, .dark-theme h2, .dark-theme h3, .dark-theme h4,
.dark-theme h5, .dark-theme h6 { color: var(--color-text); }
```

#### Post Card

```css
.dark-theme .post-card {
  background: var(--color-surface);
  border-color: rgba(255, 255, 255, 0.06);
}

.dark-theme .post-card:hover {
  border-color: rgba(84, 192, 145, 0.25);
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.4), 0 0 30px rgba(84, 192, 145, 0.06);
}
```

#### Widget

```css
.dark-theme .widget {
  background: rgba(18, 18, 26, 0.6);
  backdrop-filter: blur(16px) saturate(140%);
  border-color: rgba(255, 255, 255, 0.06);
  border-left-color: var(--color-primary, #54c091);
}
```

#### Blog Header

```css
.dark-theme .blog-header {
  background: rgba(18, 18, 26, 0.8);
  border-color: var(--color-border);
}

.dark-theme .blog-header--scrolled {
  background: rgba(18, 18, 26, 0.75);
  backdrop-filter: blur(24px) saturate(180%);
  border-bottom: 1px solid rgba(84, 192, 145, 0.15);
  box-shadow: 0 4px 30px rgba(0, 0, 0, 0.3), 0 1px 0 rgba(84, 192, 145, 0.08);
}
```

#### Search Form

```css
.dark-theme .search-form-inner {
  background: rgba(18, 18, 26, 0.5);
  border-color: rgba(255, 255, 255, 0.08);
}

.dark-theme .search-form-inner:focus-within {
  background: rgba(18, 18, 26, 0.7);
  border-color: var(--color-primary);
  box-shadow: 0 0 0 3px rgba(84, 192, 145, 0.15), 0 4px 20px rgba(84, 192, 145, 0.08);
}
```

#### Blockquote

```css
.dark-theme .post-content blockquote {
  background: linear-gradient(135deg, rgba(84,192,145,0.08) 0%, rgba(243,177,102,0.04) 100%);
}
```

#### Tag Cloud

```css
.dark-theme .tag-cloud-item {
  border-color: rgba(255, 255, 255, 0.1);
  background: transparent;
}

.dark-theme .tag-cloud-item:hover,
.dark-theme .tag-cloud-item--active {
  background: var(--color-primary);
  border-color: var(--color-primary);
}
```

#### Blog Footer

```css
.dark-theme .blog-footer { background: #08080d; }
.dark-theme .blog-footer::before { opacity: 0.4; }
```

#### Scroll-to-Top

```css
.dark-theme .scroll-to-top {
  box-shadow: 0 4px 20px rgba(84, 192, 145, 0.25), 0 2px 8px rgba(0, 0, 0, 0.4);
}

.dark-theme .scroll-to-top:hover {
  box-shadow: 0 6px 30px rgba(84, 192, 145, 0.35), 0 4px 12px rgba(0, 0, 0, 0.4);
}
```

#### Código

```css
.dark-theme pre, .dark-theme code { background: #1a1a2e; }
```

#### Mobile Nav (Dark)

```css
.dark-theme .nav-list {
  background: rgba(18, 18, 26, 0.98);
  border-top-color: rgba(84, 192, 145, 0.15);
  box-shadow: 0 -4px 24px rgba(0, 0, 0, 0.35);
}

.dark-theme .nav-link { border-bottom-color: rgba(255, 255, 255, 0.06); }
.dark-theme .nav-dropdown { background: rgba(255, 255, 255, 0.03); }
.dark-theme .nav-toggle-bar { background: var(--color-text, #e8e8f0); }
.dark-theme .mobile-nav-overlay { background: rgba(0, 0, 0, 0.6); }
```

#### prefers-color-scheme: dark

Se aplican los mismos overrides que `.dark-theme` usando la media query `@media (prefers-color-scheme: dark)` para elementos del menú móvil y search compacto.

---

## 13. Accesibilidad

### Focus Visible

```css
:focus-visible {
  outline: 2px solid var(--color-primary);
  outline-offset: 3px;
  border-radius: var(--radius-sm);
}

:focus:not(:focus-visible) {
  outline: none;
}
```

### Skip Navigation

```css
.skip-link {
  position: absolute;
  top: -100%;
  left: 0;
  z-index: 9999;
  padding: 0.75rem 1.5rem;
  background: var(--color-primary);
  color: #fff;
  text-decoration: none;
  font-weight: 600;
  border-radius: 0 0 var(--radius-md) 0;
  transition: top var(--transition-base);
}

.skip-link:focus {
  top: 0;
}
```

### Selección de Texto

```css
::selection {
  background: rgba(84, 192, 145, 0.35);
  color: #ffffff;
}
```

### Screen Reader Only

```css
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}
```

### Scroll Suave

```css
html {
  scroll-behavior: smooth;
}
```

### prefers-reduced-motion

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

---

## 14. Scrollbars

### WebKit (Chrome, Safari, Edge)

```css
::-webkit-scrollbar {
  width: 6px;
  height: 6px;
}

::-webkit-scrollbar-track {
  background: var(--color-bg);
}

::-webkit-scrollbar-thumb {
  background: linear-gradient(180deg, var(--color-primary), var(--color-accent));
  border-radius: var(--radius-full);
}

::-webkit-scrollbar-thumb:hover {
  background: var(--color-primary);
}
```

### Firefox

```css
* {
  scrollbar-width: thin;
  scrollbar-color: var(--color-primary) var(--color-bg);
}
```

### Scrollbar en Código

```css
.post-content pre {
  scrollbar-width: thin;
  scrollbar-color: #45475a transparent;
}

.post-content pre::-webkit-scrollbar { height: 6px; }
.post-content pre::-webkit-scrollbar-track { background: transparent; }
.post-content pre::-webkit-scrollbar-thumb { background: #45475a; border-radius: 3px; }
```

---

## 15. Breakpoints y Responsive

### Breakpoints del Blog

| Breakpoint | Cambios principales |
|---|---|
| **1024px** | Sidebar colapsa, grid a 1 columna, `--sidebar-width: 280px` |
| **768px** | Layout a 1 columna, nav móvil (hamburger), sidebar static, footer a 1 columna |
| **480px** | Compact spacing, fuentes menores, padding reducido |

### Detalle por Breakpoint

#### ≤ 1024px

```css
@media (max-width: 1024px) {
  :root { --sidebar-width: 280px; }
  .blog-layout { gap: 1.75rem; }
  .blog-list__layout { grid-template-columns: 1fr; }
  .blog-list__sidebar { position: static; max-height: none; }
}
```

#### ≤ 768px

```css
@media (max-width: 768px) {
  .blog-layout { grid-template-columns: 1fr; }
  .blog-sidebar { position: static; max-height: none; }

  /* Mobile nav */
  .nav-toggle { display: flex; }
  .nav-list { position: fixed; top: var(--header-height); flex-direction: column; }
  .nav-list--open { animation: mobileMenuSlideIn 0.2s ease; }

  /* Grid a 1 columna */
  .posts-grid { grid-template-columns: 1fr; }
  .blog-list__grid { grid-template-columns: 1fr; }

  /* Footer */
  .footer-inner { grid-template-columns: 1fr; }
  .footer-bottom { flex-direction: column; text-align: center; }

  /* Hero */
  .blog-hero { padding: 3rem 0 2rem; }
  .blog-list__hero { padding: 2.5rem 0 2rem; }

  /* Post */
  .post-header__title { font-size: 1.75rem; }
  .post__title { font-size: 1.5rem; }
  .post__cover-wrapper { aspect-ratio: 16/9; }
  .related-posts__grid { grid-template-columns: 1fr; }

  /* Scroll-to-top */
  .scroll-to-top { bottom: 1.25rem; right: 1.25rem; width: 42px; height: 42px; }
}
```

#### ≤ 480px

```css
@media (max-width: 480px) {
  .container { padding-inline: 1rem; }
  .blog-wrapper { padding: 1.25rem 0; }
  .blog-hero { padding: 2rem 0 1.5rem; }
  .blog-list__hero { padding: 2rem 0 1.5rem; }
  .blog-list__grid { gap: 1rem; }
  .post-card__body { padding: 1rem; }
  .post-card__footer { flex-direction: column; align-items: flex-start; }
  .pagination__link { min-width: 2rem; height: 2rem; font-size: 0.8125rem; }
}
```

### Print Styles

```css
@media print {
  .blog-header, .blog-sidebar, .blog-footer,
  .post-share, .related-posts, .pagination,
  .debug-bar, .skip-link, .breadcrumbs {
    display: none !important;
  }

  body { background: #fff; color: #000; font-size: 12pt; line-height: 1.5; }
  .blog-layout { grid-template-columns: 1fr; }
  .blog-wrapper { padding: 0; }

  .post-content a::after {
    content: " (" attr(href) ")";
    font-size: 0.8em;
    color: #666;
  }

  .post-content pre { white-space: pre-wrap; word-break: break-all; }
  h1, h2, h3 { page-break-after: avoid; }
  img { page-break-inside: avoid; }
  a { color: #000; }
}
```

---

## 16. Blog-Front Angular Module (SCSS)

El módulo `blog-front` en el backoffice Angular tiene sus propios archivos SCSS, **independientes** de `blog.css`. Todos los estilos están scoped bajo `.blog-front-shell`.

### Archivos

| Archivo | Descripción |
|---|---|
| `blog-front-styles.scss` | Entry point (importa el partial) |
| `_blog-front-styles.scss` | Archivo partial principal |
| `_blog-front-variables.scss` | Design tokens (coincidentes con `blog.css`) |
| `_blog-front-base.scss` | Reset, keyframes, accesibilidad |
| `_blog-front-components.scss` | Componentes reutilizables |
| `_blog-front-utilities.scss` | Clases utilitarias |

### Convenciones del Módulo

1. **Prefijo `bf-`**: Todos los componentes, utilidades y keyframes usan el prefijo `bf-` para evitar conflictos con el resto del backoffice Angular.
2. **Scope `.blog-front-shell`**: Todas las clases están anidadas bajo este selector para isolación.
3. **Keyframes prefijados**: `bf-fadeInUp`, `bf-scaleIn`, `bf-float`, etc.
4. **Tokens idénticos**: Los CSS Custom Properties en `_blog-front-variables.scss` coinciden exactamente con los de `blog.css` para consistencia visual.
5. **No ViewEncapsulation**: Los estilos se aplican globalmente dentro del shell, no usan Angular ViewEncapsulation.

### Diferencias con blog.css

| Aspecto | blog.css (PHP) | blog-front (Angular) |
|---|---|---|
| Lenguaje | Plain CSS | SCSS |
| Prefijo | Sin prefijo | `bf-` |
| Scope | Global | `.blog-front-shell` |
| Carga | `<link>` en layout | `styleUrls` en componentes |
| Keyframes | `fadeInUp` | `bf-fadeInUp` |

---

## 17. Convenciones y Buenas Prácticas

### Nomenclatura BEM

Se usa BEM (Block Element Modifier) con **doble guion** para modificadores:

```
.block {}
.block__element {}
.block--modifier {}
.block__element--modifier {}
```

**Ejemplos del blog**:

```css
/* Block */
.post-card {}

/* Element */
.post-card__title {}
.post-card__body {}
.post-card__footer {}

/* Modifier */
.post-card--featured {}

/* Element + Modifier */
.post-card__badge--featured {}
```

### Patrón Glassmorphism

El blog usa glassmorphism en varios componentes (header, widgets, search form):

```css
.elemento {
  background: rgba(255, 255, 255, 0.6);     /* Fondo semi-transparente */
  backdrop-filter: blur(16px) saturate(140%); /* Desenfoque + saturación */
  -webkit-backdrop-filter: blur(16px) saturate(140%); /* Safari */
  border: 1px solid var(--color-border-subtle);
}
```

### Patrón Gradient Border Glow

Técnica usada en post cards y otros elementos para crear un borde con gradiente luminoso en hover:

```css
.post-card {
  position: relative;
  overflow: hidden; /* El overflow del card no afecta al ::before */
}

.post-card::before {
  content: "";
  position: absolute;
  inset: -1px;                    /* 1px más grande que el card */
  border-radius: inherit;
  background: linear-gradient(135deg,
    rgba(84, 192, 145, 0.4),
    transparent 40%,
    transparent 60%,
    rgba(243, 177, 102, 0.3)
  );
  z-index: -1;                    /* Detrás del contenido */
  opacity: 0;
  transition: opacity 0.4s ease;
  pointer-events: none;
}

.post-card:hover::before {
  opacity: 1;
}
```

### Patrón de Dark Theme en Componentes

Para componentes que necesitan overrides específicos en dark mode:

```css
/* Light: valores por defecto en :root */
.mi-componente {
  background: rgba(255, 255, 255, 0.6);
  border-color: var(--color-border-subtle);
}

/* Dark: override con clase .dark-theme */
.dark-theme .mi-componente {
  background: rgba(18, 18, 26, 0.6);
  border-color: rgba(255, 255, 255, 0.06);
}
```

### Uso de Variables CSS

**Siempre** usar variables CSS para colores, espaciado y tipografía. No hardcodear valores:

```css
/* ✅ Correcto */
color: var(--color-text-muted);
padding: var(--space-4);
font-size: var(--font-size-sm);

/* ❌ Incorrecto */
color: #5a5a78;
padding: 1rem;
font-size: 0.875rem;
```

### CSS Custom Property Fallbacks

En algunos componentes se usan fallbacks inline por seguridad:

```css
border-left-color: var(--color-primary, #54c091);
background: var(--color-surface, #fff);
```

### Composición de Componentes

Los componentes se construyen combinando clases utilitarias con clases de componente:

```html
<article class="post-card">
  <div class="post-card__image-wrap">
    <img class="post-card__image" src="..." alt="...">
  </div>
  <div class="post-card__body">
    <div class="post-card__categories">
      <span class="badge badge--category">Categoria</span>
    </div>
    <h3 class="post-card__title">
      <a class="post-card__title-link" href="#">Título</a>
    </h3>
    <p class="post-card__excerpt">Extracto...</p>
  </div>
  <div class="post-card__footer">
    <div class="post-card__meta">
      <span class="post-card__date">Ene 2025</span>
    </div>
    <a class="post-card__read-more" href="#">Leer más →</a>
  </div>
</article>
```

### PostCSS

El blog usa PostCSS para procesamiento de CSS (autoprefixer, etc.) como parte del build pipeline.

### Formatos de Imagen

- Usar **WebP** como formato principal con fallback a **JPEG/PNG**.
- Imágenes de cards con `object-fit: cover` y `aspect-ratio` definido.
- Iconos via **Iconify** (SVG inline) en vez de sprites.

### Consideraciones de Print

- Elementos no esenciales (header, footer, sidebar, share, debug) se ocultan con `display: none !important`.
- Links en contenido muestran la URL: `.post-content a::after { content: " (" attr(href) ")"; }`.
- Código preformatted usa `white-space: pre-wrap`.
- Page breaks: `h1, h2, h3 { page-break-after: avoid; }` y `img { page-break-inside: avoid; }`.

### Consideraciones de prefers-reduced-motion

El blog respeta `prefers-reduced-motion: reduce` desactivando todas las animaciones y transiciones:

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

### Consideraciones de prefers-color-scheme

El blog soporta detección automática de dark mode mediante `prefers-color-scheme: dark` como complemento a la clase `.dark-theme`. Los overrides principales se aplican a la navegación móvil y el formulario de búsqueda compacto.

---

## 18. Resumen Visual de la Paleta

### Colores Principales

```
┌─────────────────────────────────────────────────┐
│  ■ #f4f4f8   Background                        │
│  ■ #ffffff   Surface                           │
│  ■ #eaeaf4   Surface 2                         │
│  ■ #0f0f1a   Text                              │
│  ■ #5a5a78   Text Muted                        │
│  ■ #8a8aaa   Text Dim                          │
└─────────────────────────────────────────────────┘
```

### Gradiente Principal

```
┌─────────────────────────────────────────────────┐
│  ██  rgb(84, 192, 145) → rgb(243, 177, 102)   │
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  │
└─────────────────────────────────────────────────┘
```

### Paleta Semántica

```
┌─────────────────────────────────────────────────┐
│  ● rgb(84, 192, 145)   Success (Primary)       │
│  ● rgb(243, 177, 102)   Warning (Accent)       │
│  ● #e74c3c              Danger                  │
│  ● #0dcaf0              Info                    │
└─────────────────────────────────────────────────┘
```

### Bordes

```
┌─────────────────────────────────────────────────┐
│  ── rgba(84, 192, 145, 0.2)   Border           │
│  ── rgba(0, 0, 0, 0.06)       Border Subtle    │
└─────────────────────────────────────────────────┘
```

### Código

```
┌─────────────────────────────────────────────────┐
│  ■ #1e1e2e   Code Background (pre)             │
│  ■ #cdd6f4   Code Text (pre)                   │
│  ■ #45475a   Code Scrollbar                    │
│  ■ #c0392b   Inline Code Text                  │
└─────────────────────────────────────────────────┘
```

---

> **Documento mantenido por el equipo de desarrollo de Quantum AI Signals.**
> Para cambios en los estilos, actualizar este archivo simultáneamente.
