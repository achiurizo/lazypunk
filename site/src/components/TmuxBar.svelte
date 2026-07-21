<section class="tmux" aria-label="tmux status bar preview">
  <span class="seg session">  main </span>
  <span class="seg host"> host </span>
  <span class="seg branch">  develop </span>
  <span class="spacer"></span>
  <span class="seg load"> 0.42 </span>
  <span class="seg battery"> 87% </span>
  <span class="seg datetime"> 2026-07-19 </span>
  <span class="seg datetime"> 14:22 </span>
</section>

<style>
  .tmux {
    display: flex; align-items: stretch;
    margin-top: 28px;
    border-radius: 6px;
    overflow-x: auto; overflow-y: hidden;
    font-size: 12px; font-weight: 600;
    border: 1px solid var(--border);
  }
  .seg { padding: 5px 12px; white-space: nowrap; }
  .spacer { flex: 1; background: var(--bg_dark); }
  .session  { background: var(--string);  color: var(--bg_dark); }
  .host     { background: var(--func);    color: var(--bg_dark); }
  .branch   { background: var(--keyword); color: var(--bg_dark); }
  .load     { background: var(--bg_float); color: var(--number); }
  .battery  { background: var(--warn);    color: var(--bg_dark); }
  .datetime { background: var(--border);  color: var(--fg); }
</style>
