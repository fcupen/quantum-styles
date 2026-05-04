#!/bin/bash
# ================================================================
# Quantum AI Signals — CSS Bundle Builder
# Concatena los archivos base + específicos para cada proyecto
# Uso: bash build.sh [blog|support|all]
# ================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")/quantum-ai-signals"
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
  echo "   Order: tokens.css → base.css → animations.css → ${name}-components.css" >> "$output"
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

minify() {
  local input=$1
  local output="${input%.css}.min.css"

  if [ ! -f "$input" ]; then
    echo "WARNING: $input not found, skipping minification"
    return 1
  fi

  # Remove comments, newlines, and extra whitespace
  sed -E '/\/\*/d; s/\/\*.*?\*\///g; s/[[:space:]]+/ /g; s/ ?([{}:;,>~+]) ?/\1/g; s/\{ /\{/g; s/ \}/\}/g; s/;//g; s/^ //; s/ $//' "$input" > "$output"

  local original_size=$(wc -c < "$input")
  local min_size=$(wc -c < "$output")
  echo "  ✓ ${output} (${original_size}B → ${min_size}B)"
}

case "${1:-all}" in
  blog)
    build_bundle "blog" \
      "$SCRIPT_DIR/blog.css" \
      "$SCRIPT_DIR/tokens.css" \
      "$SCRIPT_DIR/base.css" \
      "$SCRIPT_DIR/animations.css" \
      "$SCRIPT_DIR/components.css"
    minify "$SCRIPT_DIR/blog.css"
    cp "$SCRIPT_DIR/blog.css" "$PROJECT_ROOT/blog/public/assets/css/blog.css"
    cp "$SCRIPT_DIR/blog.min.css" "$PROJECT_ROOT/blog/public/assets/css/blog.min.css"
    echo "  ✓ Copied to blog/public/assets/css/{blog.css,blog.min.css}"
    ;;
  support)
    build_bundle "support" \
      "$SCRIPT_DIR/support.css" \
      "$SCRIPT_DIR/tokens.css" \
      "$SCRIPT_DIR/base.css" \
      "$SCRIPT_DIR/animations.css" \
      "$SCRIPT_DIR/support-components.css"
    minify "$SCRIPT_DIR/support.css"
    cp "$SCRIPT_DIR/support.css" "$PROJECT_ROOT/support/public/assets/css/support.css"
    cp "$SCRIPT_DIR/support.min.css" "$PROJECT_ROOT/support/public/assets/css/support.min.css"
    echo "  ✓ Copied to support/public/assets/css/{support.css,support.min.css}"
    ;;
  all)
    echo "=== Building ALL bundles ==="
    echo ""
    bash "$SCRIPT_DIR/build.sh" blog
    echo ""
    bash "$SCRIPT_DIR/build.sh" support
    echo ""
    echo "=== Done ==="
    ;;
  *)
    echo "Usage: $0 [blog|support|all]"
    exit 1
    ;;
esac
