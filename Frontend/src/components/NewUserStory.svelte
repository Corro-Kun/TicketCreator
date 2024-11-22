<script>
    import Input from './Input.svelte';
    import {navigate} from 'astro:transitions/client';
    import Loader from '@/components/icon/Loader.svelte';
    import {UrlApi} from "@/const.js";

    let data = $state({name: '', description: '', priority_id: '', project_id: '', name_ticket: '', description_ticket: ''});

    let loading = $state(0);

    async function HandleSubmit(e) {
        loading = 1;

        e.preventDefault();

        let token = localStorage.getItem("token");

        let project = localStorage.getItem("project");

        if (!project){
            alert("Seleccione un proyecto");
            return;
        }

        await fetch(`${UrlApi}/user_story`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                token: token
            },
            body: JSON.stringify({...data, project_id: project})
        });

        loading = 0;

        navigate('/home/stories');
    }

</script>

<form onsubmit={HandleSubmit} >
    <h2>Historia de Usuario</h2>
    <Input id="title" type="text" required label="Titulo" bind:value={data.name} />
    <textarea placeholder="Descripción" bind:value={data.description} ></textarea>
    <select bind:value={data.priority_id}>
        <option>-Seleccione una prioridad-</option>
        <option value="1">Baja</option>
        <option value="2">Media</option>
        <option value="3">Alta</option>
    </select>
    <h3>Ticket</h3>
    <Input id="ticket" type="text" required label="Nombre" bind:value={data.name_ticket} />
    <textarea placeholder="Descripción" bind:value={data.description_ticket} ></textarea>
    {#if loading === 1}
        <Loader />
    {:else}
        <button type="submit" >Crear</button>
    {/if}
</form>

<style>
    form{
        margin-block: 15px;
        display: flex;
        padding: 40px;
        width: 500px;
        border: 1px solid var(--Color_Border);
        border-radius: 10px;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        background: transparent;
        backdrop-filter: blur(30px);
        overflow: hidden;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); 
    }
    select{
        width: 100%;
        margin-block: 20px;
        padding: 5px;
        background: transparent;
        border: 1px solid var(--Color_Border);
        outline: none;
        font-size: 1em;
        color: var(--Color_Text);
        transition: 0.3s;
        border-radius: 5px;
    }
    textarea{
        width: 100%;
        height: 100px;
        padding: 5px;
        background: transparent;
        border: 1px solid var(--Color_Border);
        outline: none;
        font-size: 1em;
        color: var(--Color_Text);
        transition: 0.3s;
        border-radius: 5px;
        resize: none;
    }
    h3{
        margin: 10px;
    }
    button {
        margin-top: 20px;
        width: 100%;
        height: 45px;
        background: var(--Color_Background_Second);
        border: none;
        outline: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 1em;
        color: var(--Color_Text_Second);
        font-weight: 500;
        transition: 0.3s ease;
      }
    button:hover {
        filter: contrast(120%);
    }
</style>