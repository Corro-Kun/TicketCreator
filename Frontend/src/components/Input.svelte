<script>
    let {id, type, required, value = $bindable(), label, children} = $props();
</script>

<div class="input">
    <input {id} {type} {required} bind:value={value} />
    <label for={id} >{label}</label>
    {@render children?.()}
</div>

<style>
  .input {
    position: relative;
    width: 100%;
    height: 50px;
    border-bottom: 2px solid var(--Color_Border);
    margin: 30px 0;
  }
  .input label {
    position: absolute;
    top: 50%;
    left: 5px;
    transform: translateY(-50%);
    font-size: 1em;
    color: var(--Color_Text);
    font-weight: 500;
    pointer-events: none;
    transition: 0.5s;
  }
  .input input {
    width: 100%;
    height: 100%;
    background: transparent;
    border: none;
    outline: none;
    font-size: 1em;
    color: var(--Color_Text);
    font-weight: 600;
    padding: 0 35px 0 5px;
    transition: 0.3s;
  }
  .input input:focus ~ label,
  .input input:valid ~ label {
    top: -5px;
    font-size: 0.8em;
  }
</style>