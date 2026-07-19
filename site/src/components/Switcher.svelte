<script>
  let { order, variants, selected, onselect } = $props();
</script>

<nav class="switcher" aria-label="Theme variant">
  {#each order as name}
    <button
      class="tab"
      class:active={name === selected}
      aria-pressed={name === selected}
      onclick={() => onselect(name)}
    >
      lazypunk-{name}
    </button>
  {/each}
</nav>

<style>
  .switcher { display: flex; gap: 4px; flex-wrap: wrap; }
  .tab {
    font: inherit;
    font-size: 13px;
    padding: 5px 12px;
    border-radius: 7px 7px 0 0;
    border: 1px solid var(--border);
    border-bottom: none;
    background: var(--bg_float);
    color: var(--fg_dim);
    cursor: pointer;
    transition: color 0.12s ease, border-color 0.12s ease, background 0.12s ease;
  }
  .tab:hover {
    color: var(--fg);
    border-color: var(--accent2);
  }
  .tab:focus-visible {
    outline: 2px solid var(--accent2);
    outline-offset: 2px;
  }
  .tab.active {
    background: var(--accent);
    color: var(--bg_dark);
    border-color: var(--accent);
  }
</style>
