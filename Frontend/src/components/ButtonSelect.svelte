<script>
    import {onMount} from 'svelte';

    let {id} = $props();

    let status = $state(0);

    onMount(async () => {
        let project = localStorage.getItem("project");
        project = project ? JSON.parse(project) : null;

        if (project === id) {
            status = 1;
        }
    });

    function select() {
        let project = localStorage.getItem("project");
        project = project ? JSON.parse(project) : null;

        if (project !== id && project !== null) {
            alert("Ya tienes un proyecto seleccionado, deselecciona el actual para seleccionar otro");
            return;
        }

        if(status) {
            localStorage.removeItem("project");

        }else{
            localStorage.setItem("project", JSON.stringify(id));
        }

        status = !status;
    }
</script>

<button class={status? 'active': ''} onclick={select} >
    {status? 'Seleccionado': 'Seleccionar'}
</button>

<style>
  button {
    padding: 8px 15px;
    background: var(--Color_Background_Second);
    border: none;
    outline: none;
    border-radius: 6px;
    cursor: pointer;
    color: var(--Color_Text_Second);
    font-weight: 500;
    transition: 0.3s ease;
  }
  button:hover {
    filter: contrast(120%);
  }
  .active {
    background: var(--Color_Background);
    color: var(--Color_Text);
  }
</style>