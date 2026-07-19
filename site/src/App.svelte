<script>
  import data from './lib/palettes.json';
  import { applyPalette } from './lib/applyPalette.js';
  import Switcher from './components/Switcher.svelte';
  import EditorPreview from './components/EditorPreview.svelte';
  import TmuxBar from './components/TmuxBar.svelte';
  import Swatches from './components/Swatches.svelte';
  import Install from './components/Install.svelte';
  import Toast from './components/Toast.svelte';

  const { order, variants } = data;
  let selected = $state(order[0]);
  let toast = $state('');
  let toastTimer;
  function showToast(msg) {
    toast = msg;
    clearTimeout(toastTimer);
    toastTimer = setTimeout(() => (toast = ''), 1500);
  }

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
    <Switcher {order} {selected} onselect={(n) => (selected = n)} />
  </div>

  <main class="body">
    <section class="hero">
      <p class="boot">&gt; loading lazypunk-{selected}…<span class="cursor" aria-hidden="true">▋</span></p>
      <h1>lazypunk</h1>
      <p class="pitch">A palette-driven, Edgerunners-inspired theme for Neovim &amp; tmux.</p>
      <p class="blurb">{variants[selected].blurb}</p>
    </section>
    <EditorPreview />
    <TmuxBar />
    <Swatches variant={variants[selected]} oncopy={showToast} />
    <Install {selected} oncopy={showToast} />
    <footer class="foot">
      <a href="https://github.com/achiurizo/lazypunk">GitHub</a>
      · <a href="https://github.com/achiurizo/lazypunk#adding-a-variant">Add a variant</a>
      · MIT © Arthur Chiu
    </footer>
  </main>
</div>

<Toast message={toast} />

<style>
  .terminal {
    max-width: 900px;
    margin: 32px auto;
    border: 1px solid var(--border);
    border-radius: 12px;
    background: var(--bg);
  }
  .titlebar {
    display: flex; align-items: center; gap: 7px;
    padding: 9px 14px;
    background: var(--bg_float);
    border-bottom: 1px solid var(--border);
    border-radius: 12px 12px 0 0;
  }
  .dot { width: 11px; height: 11px; border-radius: 99px; }
  .dot.red { background: var(--error); }
  .dot.amber { background: var(--warn); }
  .dot.green { background: var(--string); }
  .title { font-size: 12px; color: var(--comment); margin-left: 6px; }
  .switcher-wrap { padding: 12px 16px 0; position: sticky; top: 0; background: var(--bg); z-index: 5; }
  .body { padding: 20px 22px 40px; border-radius: 0 0 12px 12px; }

  .hero { padding-bottom: 24px; border-bottom: 1px solid var(--border); }
  .hero .boot { color: var(--string); font-size: 13px; }
  .hero .boot .cursor {
    display: inline-block;
    margin-left: 1px;
    color: var(--string);
    animation: blink 1s steps(1, jump-none) infinite;
  }
  @keyframes blink {
    0%, 49% { opacity: 1; }
    50%, 100% { opacity: 0; }
  }
  @media (prefers-reduced-motion: reduce) {
    .hero .boot .cursor { animation: none; opacity: 1; }
  }
  .hero h1 { font-size: 40px; letter-spacing: -0.01em; color: var(--accent); margin: 6px 0; }
  .hero .pitch { color: var(--fg); }
  .hero .blurb { color: var(--fg_dim); font-size: 14px; margin-top: 4px; }

  .foot {
    margin-top: 28px; padding-top: 20px; border-top: 1px solid var(--border);
    color: var(--comment); font-size: 13px; line-height: 1.8;
  }
  .foot a { color: var(--accent2); border-radius: 4px; }
  .foot a:hover { color: var(--accent); text-decoration: underline; }

  @media (max-width: 480px) {
    .terminal { margin: 14px 8px; border-radius: 9px; }
    .titlebar { border-radius: 9px 9px 0 0; }
    .body { padding: 16px 14px 32px; border-radius: 0 0 9px 9px; }
    .switcher-wrap { padding: 10px 12px 0; }
    .hero h1 { font-size: 30px; }
  }
</style>
