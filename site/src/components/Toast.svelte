<script>
  let { message } = $props();
</script>

{#if message}
  <div class="toast" role="status">{message}</div>
{/if}

<style>
  .toast {
    position: fixed; bottom: 20px; left: 50%; transform: translateX(-50%);
    background: var(--bg_float); color: var(--fg);
    border: 1px solid var(--accent);
    padding: 8px 16px; border-radius: 8px; font-size: 13px; z-index: 50;
  }
</style>
