<script>
  import data from './lib/palettes.json';
  import { applyPalette } from './lib/applyPalette.js';
  import Switcher from './components/Switcher.svelte';
  import EditorPreview from './components/EditorPreview.svelte';

  const { order, variants } = data;
  let selected = $state(order[0]);

  // Apply on mount and whenever `selected` changes.
  $effect(() => {
    applyPalette(variants[selected]);
  });
</script>

<div class="terminal">
  <header class="titlebar">
    <span class="dot red"></span>
    <span class="dot amber"></span>
    <span class="dot green"></span>
    <span class="title">~/lazypunk — nvim</span>
  </header>

  <div class="switcher-wrap">
    <Switcher {order} {variants} {selected} onselect={(n) => (selected = n)} />
  </div>

  <main class="body">
    <section class="hero">
      <p class="boot">&gt; loading lazypunk-{selected}…</p>
      <h1>lazypunk</h1>
      <p class="pitch">A palette-driven, Edgerunners-inspired theme for Neovim &amp; tmux.</p>
      <p class="blurb">{variants[selected].blurb}</p>
    </section>
    <EditorPreview />
    <!-- TmuxBar, Swatches, Install mount here in later tasks -->
  </main>
</div>

<style>
  .terminal {
    max-width: 900px;
    margin: 32px auto;
    border: 1px solid var(--border);
    border-radius: 12px;
    overflow: hidden;
    background: var(--bg);
  }
  .titlebar {
    display: flex; align-items: center; gap: 7px;
    padding: 9px 14px;
    background: var(--bg_float);
    border-bottom: 1px solid var(--border);
  }
  .dot { width: 11px; height: 11px; border-radius: 99px; }
  .dot.red { background: var(--error); }
  .dot.amber { background: var(--warn); }
  .dot.green { background: var(--string); }
  .title { font-size: 12px; color: var(--comment); margin-left: 6px; }
  .switcher-wrap { padding: 12px 16px 0; position: sticky; top: 0; background: var(--bg); z-index: 5; }
  .body { padding: 20px 22px 40px; }
  .hero .boot { color: var(--string); font-size: 13px; }
  .hero h1 { font-size: 40px; letter-spacing: -0.01em; color: var(--accent); margin: 6px 0; }
  .hero .pitch { color: var(--fg); }
  .hero .blurb { color: var(--fg_dim); font-size: 14px; margin-top: 4px; }
</style>
