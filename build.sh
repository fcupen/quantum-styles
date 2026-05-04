#!/bin/bash
# ================================================================
# Quantum AI Signals — CSS Bundle Builder
# Concatena los archivos base + específicos para cada proyecto
# Uso: bash styles/build.sh [blog|support|all]
# ================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

build_bundle() {
  local name=$1
  shift
  local output=$1
  shift
  local files=("$@")

  echo "Building ${name} bundle..."
  echo "/* ================================================================" > "$output"
  echo "   QUANTUM AI SIGNALS — ${name^^} BUNDLE" >> "$output"
  echo "   Auto-generated: ${DATE}" >> "$output"
  echo "" >> "$output"
  echo "   DO NOT EDIT DIRECTLY — Edit source files in /styles/ and rebuild:" >> "$output"
  echo "   Order: tokens.css → base.css → animations.css → ${name}.css" >> "$output"
  echo "   ================================================================ */" >> "$output"
  echo "" >> "$output"

  for file in "${files[@]}"; do
    if [ -f "$file" ]; then
      echo "" >> "$output"
      cat "$file" >> "$output"
      echo "" >> "$output"
      echo "/* --- END: $(basename "$file") --- */" >> "$output"
    else
      echo "WARNING: $file not found, skipping"
    fi
  done

  echo "  ✓ ${output} ($(wc -l < "$output") lines)"
}

case "${1:-all}" in
  blog)
    build_bundle "blog" \
      "$SCRIPT_DIR/blog.css" \
      "$SCRIPT_DIR/tokens.css" \
      "$SCRIPT_DIR/base.css" \
      "$SCRIPT_DIR/animations.css" \
      "$SCRIPT_DIR/components.css"
    cp "$SCRIPT_DIR/blog.css" "$PROJECT_ROOT/blog/public/assets/css/blog.css"
    echo "  ✓ Copied to blog/public/assets/css/blog.css"
    ;;
  support)
    build_bundle "support" \
      "$SCRIPT_DIR/support.css.bak" \
      "$SCRIPT_DIR/tokens.css" \
      "$SCRIPT_DIR/base.css" \
      "$SCRIPT_DIR/animations.css" \
      "$SCRIPT_DIR/support-components.css"
    # Support uses a different path for the bundle vs source
    build_bundle "support" \
      "$PROJECT_ROOT/support/public/assets/css/support.css" \
      "$SCRIPT_DIR/tokens.css" \
      "$SCRIPT_DIR/base.css" \
      "$SCRIPT_DIR/animations.css" \
      "$SCRIPT_DIR/support.css"
    ;;
  all)
    echo "=== Building ALL bundles ==="
    echo ""
    $0 blog
    echo ""
    $0 support
    echo ""
    echo "=== Done ==="
    ;;
  *)
    echo "Usage: $0 [blog|support|all]"
    exit 1
    ;;
esac
