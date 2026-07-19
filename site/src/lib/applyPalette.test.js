import { describe, it, expect } from 'vitest';
import { paletteToVars, applyPalette } from './applyPalette.js';

const variant = {
  name: 'x',
  roles: { bg: '#0f0d1e', keyword: '#9d7cff', accent2: '#5b8cff' },
  ansi: ['#000', '#111', '#222', '#333', '#444', '#555', '#666', '#777',
         '#888', '#999', '#aaa', '#bbb', '#ccc', '#ddd', '#eee', '#fff'],
};

describe('paletteToVars', () => {
  it('maps every role to a --role custom property', () => {
    const vars = paletteToVars(variant);
    expect(vars['--bg']).toBe('#0f0d1e');
    expect(vars['--keyword']).toBe('#9d7cff');
    expect(vars['--accent2']).toBe('#5b8cff');
  });

  it('maps the 16 ansi entries to --ansi-0..15', () => {
    const vars = paletteToVars(variant);
    expect(vars['--ansi-0']).toBe('#000');
    expect(vars['--ansi-15']).toBe('#fff');
    expect(Object.keys(vars).filter((k) => k.startsWith('--ansi-'))).toHaveLength(16);
  });
});

describe('applyPalette', () => {
  it('sets the custom properties on the target element style', () => {
    const el = { style: {} };
    applyPalette(variant, el);
    expect(el.style['--bg']).toBe('#0f0d1e');
    expect(el.style['--ansi-15']).toBe('#fff');
  });

  it('uses setProperty when available (real-DOM path)', () => {
    const set = {};
    const el = { style: { setProperty: (k, v) => { set[k] = v; } } };
    applyPalette(variant, el);
    expect(set['--bg']).toBe('#0f0d1e');
    expect(set['--ansi-15']).toBe('#fff');
  });
});
