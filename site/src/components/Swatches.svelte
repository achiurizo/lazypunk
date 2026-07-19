<script>
  import { copyText } from '../lib/clipboard.js';

  let { variant, oncopy } = $props();

  // Ordered role groups for a readable layout.
  const roleGroups = [
    ['bg', 'bg_dark', 'bg_float', 'cursorline', 'bg_sel', 'border', 'gutter'],
    ['fg', 'fg_dim', 'comment'],
    ['keyword', 'func', 'string', 'number', 'constant', 'type', 'property',
     'operator', 'variable', 'parameter', 'preproc'],
    ['error', 'warn', 'info', 'hint', 'ok'],
    ['git_add', 'git_change', 'git_delete', 'accent', 'accent2'],
  ];

  async function copy(hex) {
    if (await copyText(hex)) oncopy?.(`Copied ${hex}`);
  }
</script>

<section class="swatches">
  <h2>Palette</h2>
  {#each roleGroups as group}
    <div class="group">
      {#each group as role}
        <button class="chip" title="Copy {variant.roles[role]}" onclick={() => copy(variant.roles[role])}>
          <span class="sw" style="background: var(--{role})"></span>
          <span class="meta"><span class="rn">{role}</span><span class="hx">{variant.roles[role]}</span></span>
        </button>
      {/each}
    </div>
  {/each}

  <h3>Terminal ANSI</h3>
  <div class="ansi">
    {#each variant.ansi as hex, i}
      <button class="ansi-sw" title="Copy {hex}" style="background: var(--ansi-{i})" onclick={() => copy(hex)} aria-label={`ansi ${i} ${hex}`}></button>
    {/each}
  </div>
</section>

<style>
  .swatches {
    margin-top: 28px; padding-top: 20px;
    border-top: 1px solid var(--border);
  }
  .swatches h2 { font-size: 16px; color: var(--fg); margin-bottom: 10px; }
  .swatches h3 { font-size: 13px; color: var(--fg_dim); margin: 16px 0 8px; }
  .group { display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 8px; }
  .chip {
    display: flex; align-items: center; gap: 8px;
    background: var(--bg_float); border: 1px solid var(--border);
    border-radius: 8px; padding: 5px 9px; cursor: pointer; font: inherit;
    transition: border-color 0.12s ease, transform 0.12s ease;
  }
  .chip:hover { border-color: var(--accent2); }
  .chip:focus-visible {
    outline: 2px solid var(--accent2);
    outline-offset: 2px;
  }
  .sw { width: 18px; height: 18px; border-radius: 5px; border: 1px solid rgba(255,255,255,.08); }
  .meta { display: flex; flex-direction: column; line-height: 1.2; text-align: left; }
  .rn { font-size: 11px; color: var(--fg); }
  .hx { font-size: 10px; color: var(--comment); }
  .ansi { display: flex; flex-wrap: wrap; gap: 5px; }
  .ansi-sw {
    width: 26px; height: 26px; border-radius: 5px;
    border: 1px solid rgba(255,255,255,.08); cursor: pointer;
    transition: border-color 0.12s ease, transform 0.12s ease;
  }
  .ansi-sw:hover { border-color: var(--accent2); transform: translateY(-1px); }
  .ansi-sw:focus-visible {
    outline: 2px solid var(--accent2);
    outline-offset: 2px;
  }
</style>
