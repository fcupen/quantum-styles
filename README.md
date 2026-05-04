# 🎨 Quantum AI Signals — Shared Styles

Archivos CSS compartidos entre blog, support y otros proyectos del ecosistema Quantum AI Signals.

## Estructura

```
styles/
├── tokens.css        ← Design tokens compartidos (CSS Custom Properties)
├── base.css          ← Reset, estilos globales, dark theme overrides, utilidades compartidas
├── animations.css    ← Keyframes, efectos, scroll-to-top, skeleton loading
├── components.css    ← Componentes del blog (header, nav, cards, pagination, post, footer, etc.)
├── blog.css          ← Bundle CDN blog (tokens + base + components + animations)
├── blog.min.css      ← Bundle CDN blog minimizado (producción)
├── support.css       ← Componentes específicos del Help Desk / Support
├── STYLE_GUIDE.md    ← Documentación completa del sistema de estilos
└── README.md         ← Este archivo
```

## Arquitectura

```
                    ┌──────────────┐
                    │  tokens.css  │  ← Variables CSS (:root, .dark-theme)
                    └──────┬───────┘
                           │
                    ┌──────▼───────┐
                    │   base.css   │  ← Reset, scrollbar, utilidades compartidas
                    └──────┬───────┘
                           │
                    ┌──────▼───────┐
                    │animations.css│  ← @keyframes, .animate-*, delays, skeleton
                    └──────┬───────┘
                           │
              ┌────────────┼────────────┐
              │            │            │
     ┌────────▼───┐ ┌─────▼──────┐ ┌──▼──────────┐
     │components  │ │ support.css│ │ (futuro     │
     │  .css      │ │ (support-  │ │  proyecto)  │
     │ (blog)     │ │  specific) │ │             │
     └────────────┘ └────────────┘ └─────────────┘
```

## Orden de Carga

### Blog

1. **tokens.css** — Variables CSS compartidas
2. **base.css** — Reset, estilos globales, utilidades
3. **animations.css** — Keyframes y efectos
4. **components.css** — Componentes del blog

O en bundle: `blog.css` (concatenación de los 4)

### Support

1. **tokens.css** — Variables CSS compartidas
2. **base.css** — Reset, estilos globales, utilidades
3. **animations.css** — Keyframes y efectos
4. **support.css** — Componentes específicos del support

## Variables CSS Disponibles

Todas las variables están en `tokens.css`. Las principales:

| Categoría | Variables |
|---|---|
| Colores | `--color-bg`, `--color-surface`, `--color-primary`, `--color-accent`, `--color-text` |
| Semánticos | `--color-success`, `--color-warning`, `--color-danger`, `--color-info` |
| Tipografía | `--font-family`, `--font-mono`, `--font-size-xs` → `--font-size-7xl` |
| Espaciado | `--space-1` → `--space-32` |
| Bordes | `--radius-sm` → `--radius-full` |
| Sombras | `--shadow-sm` → `--shadow-glow` |
| Transiciones | `--transition-fast`, `--transition-base`, `--transition-slow`, `--transition-spring` |
| Layout | `--container-max`, `--container-sm`, `--container-xs`, `--sidebar-width`, `--header-height` |
| Z-Index | `--z-below` → `--z-toast` |

## Proyectos que usan estos estilos

| Proyecto | Archivos base | Archivos específicos |
|---|---|---|
| **Blog** | tokens + base + animations | components.css |
| **Support** | tokens + base + animations | support.css |

## Dark Theme

Se activa con la clase `.dark-theme` en `<html>` o `<body>`. Los tokens que cambian están en `tokens.css`. Los overrides por componente están en:
- `base.css` — overrides genéricos (scroll-to-top, focus)
- `components.css` — overrides del blog
- `support.css` — overrides del support

## Convenciones

- **BEM**: `.block__element--modifier` (doble guion para modificadores)
- **Glassmorphism**: `backdrop-filter: blur() saturate()` en headers, widgets, search
- **Gradient Border Glow**: `::before` con gradiente + `z-index: -1` en cards
- **CSS Custom Properties**: Usar siempre `var(--token)` en vez de valores hardcoded
- **Reduced Motion**: Respetado via `@media (prefers-reduced-motion: reduce)`

## Agregar un nuevo proyecto

1. Los archivos base (`tokens.css`, `base.css`, `animations.css`) se reutilizan directamente
2. Crear un archivo `styles/[proyecto].css` con los componentes específicos
3. Si necesitas override de layout tokens (ej: `--header-height`), hacerlo al inicio del archivo específico
4. Los dark theme overrides del proyecto van al final del archivo específico

> Para la documentación completa, ver [STYLE_GUIDE.md](./STYLE_GUIDE.md).
