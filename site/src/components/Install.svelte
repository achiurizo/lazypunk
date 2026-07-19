<script>
  import { snippets } from '../lib/snippets.js';
  import { copyText } from '../lib/clipboard.js';

  let { selected, oncopy } = $props();

  let tabs = $derived(snippets(selected));
  let active = $state('lazy');
  let current = $derived(tabs.find((t) => t.id === active) ?? tabs[0]);

  async function copy() {
    if (await copyText(current.code)) oncopy?.('Copied snippet');
  }
</script>

<section class="install">
  <h2>Install</h2>
  <div class="tabs">
    {#each tabs as t}
      <button class="tab" class:active={t.id === active} onclick={() => (active = t.id)}>{t.label}</button>
    {/each}
  </div>
  <div class="snippet">
    <button class="copy" onclick={copy}>copy</button>
    <pre><code>{current.code}</code></pre>
  </div>
</section>

<style>
  .install {
    margin-top: 28px; padding-top: 20px;
    border-top: 1px solid var(--border);
  }
  .install h2 { font-size: 16px; color: var(--fg); margin-bottom: 10px; }
  .tabs { display: flex; gap: 4px; flex-wrap: wrap; }
  .tab {
    font: inherit; font-size: 12px; padding: 5px 11px;
    border: 1px solid var(--border); border-bottom: none;
    border-radius: 7px 7px 0 0; background: var(--bg_float);
    color: var(--fg_dim); cursor: pointer;
    transition: color 0.12s ease, border-color 0.12s ease;
  }
  .tab:hover { color: var(--fg); border-color: var(--accent2); }
  .tab:focus-visible {
    outline: 2px solid var(--accent2);
    outline-offset: 2px;
  }
  .tab.active { background: var(--bg); color: var(--accent2); }
  .snippet { position: relative; border: 1px solid var(--border); border-radius: 0 8px 8px 8px; background: var(--bg); }
  .snippet pre { padding: 14px; overflow-x: auto; font-size: 12.5px; color: var(--fg); }
  .copy {
    position: absolute; top: 8px; right: 8px;
    font: inherit; font-size: 11px; padding: 3px 9px;
    background: var(--accent); color: var(--bg_dark);
    border: none; border-radius: 6px; cursor: pointer;
    transition: filter 0.12s ease, transform 0.12s ease;
  }
  .copy:hover { filter: brightness(1.12); }
  .copy:focus-visible {
    outline: 2px solid var(--accent2);
    outline-offset: 2px;
  }
</style>
