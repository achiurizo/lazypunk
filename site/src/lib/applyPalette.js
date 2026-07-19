// Pure mapping from a palette variant object (from palettes.json) to CSS custom
// properties, plus a tiny DOM applier. Kept framework-agnostic so it is the one
// unit-tested seam.

export function paletteToVars(variant) {
  const vars = {};
  for (const [key, hex] of Object.entries(variant.roles)) {
    vars[`--${key}`] = hex;
  }
  variant.ansi.forEach((hex, i) => {
    vars[`--ansi-${i}`] = hex;
  });
  return vars;
}

export function applyPalette(variant, el = document.documentElement) {
  const vars = paletteToVars(variant);
  for (const [name, value] of Object.entries(vars)) {
    if (el.style.setProperty) {
      el.style.setProperty(name, value);
    } else {
      el.style[name] = value;
    }
  }
}
