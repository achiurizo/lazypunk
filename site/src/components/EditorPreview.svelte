<script>
  // A static, representative code sample. Each token uses the semantic role
  // color via a CSS variable, so it recolors with the rest of the page.
  const lines = [
    { n: 1, html: '<span class="cm">-- one palette drives everything</span>' },
    { n: 2, html: '<span class="kw">local</span> <span class="ty">M</span> = {}' },
    { n: 3, html: '' },
    { n: 4, html: '<span class="kw">function</span> <span class="ty">M</span>.<span class="fn">load</span>(<span class="pa">name</span>)' },
    { n: 5, html: '  <span class="kw">local</span> <span class="va">p</span> = <span class="fn">require</span>(<span class="st">"lazypunk.palettes."</span> .. <span class="pa">name</span>)' },
    { n: 6, html: '  <span class="kw">return</span> <span class="fn">apply</span>(<span class="va">p</span>, <span class="nm">1000</span>)' },
    { n: 7, html: '<span class="kw">end</span>' },
  ];
</script>

<section class="editor">
  <div class="gutter-and-code">
    {#each lines as line}
      <div class="row">
        <span class="ln">{line.n}</span>
        <code class="src">{@html line.html || '&nbsp;'}</code>
      </div>
    {/each}
    <div class="row diag">
      <span class="ln"></span>
      <code class="src"><span class="err-underline">undefined_var</span> <span class="diag-msg">E: undefined global</span></code>
    </div>
  </div>
</section>

<style>
  .editor {
    margin-top: 22px;
    border: 1px solid var(--border);
    border-radius: 8px;
    overflow: hidden;
    background: var(--bg);
    font-size: 13px;
  }
  .row { display: flex; }
  .ln {
    width: 34px; text-align: right; padding-right: 12px;
    color: var(--gutter); background: var(--bg_dark); user-select: none;
  }
  .src { white-space: pre; padding-left: 12px; color: var(--fg); }
  /* These classes are only ever injected via {@html} into .src, so Svelte's
     scoped-CSS compiler can't see them in the static template and would tree-
     shake them as "unused" without :global(). */
  .src :global(.kw) { color: var(--keyword); }
  .src :global(.fn) { color: var(--func); }
  .src :global(.st) { color: var(--string); }
  .src :global(.nm) { color: var(--number); }
  .src :global(.ty) { color: var(--type); }
  .src :global(.cm) { color: var(--comment); }
  .src :global(.va) { color: var(--variable); }
  .src :global(.pa) { color: var(--parameter); }
  .diag .src { color: var(--comment); }
  .err-underline { text-decoration: wavy underline var(--error); }
  .diag-msg { color: var(--error); font-size: 12px; margin-left: 10px; }
</style>
