<script>
    import Input from './Input.svelte';
    import {onMount} from 'svelte';
    import {navigate} from 'astro:transitions/client';
    import Loader from '@/components/icon/Loader.svelte';
    import {UrlApi} from "@/const.js";

    let {data} = $props();

    let story = $state([]);

    let loading = $state(0);

    onMount(async () => {
        let token = localStorage.getItem("token");

        let project = localStorage.getItem("project");
        project = project ? JSON.parse(project) : null;

        const response = await fetch(`${UrlApi}/user_stories/${project}`,{
            headers: {
                token: token
            }
        });

        story = await response.json();
    });

    async function HandleSubmit(e){
        loading = 1;

        e.preventDefault();

        let token = localStorage.getItem("token");

        await fetch(`${UrlApi}/ticket/${data.id}`, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                token: token
            },
            body: JSON.stringify(data)
        });

        loading = 0;

        navigate('/home/tickets/'+data.id);
    }

    async function HandleDelete(){
        loading = 1;

        let token = localStorage.getItem("token");

        await fetch(`${UrlApi}/ticket/state/${data.id}`, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                token: token
            },
            body: JSON.stringify({state_id: 4})
        });

        loading = 0;

        navigate('/home/tickets/'+data.id);
    }

</script>

<form onsubmit={HandleSubmit} >
    <h2>Ticket</h2>
    <Input id="title" type="text" required label="Nombre" bind:value={data.name} />
    <textarea placeholder="Descripción" bind:value={data.description} ></textarea>
    <select bind:value={data.user_story_id}>
        <option>-Elige una historia de usuario-</option>
        {#each story as item}
            <option value={item.id}>{item.name}</option>
        {/each}
    </select>
    {#if loading === 1}
        <Loader />
    {:else}
        {#if data.state_id !== 4}
            <button style="background-color: brown;" type="button" onclick={HandleDelete} >Cancelar</button>
            <button type="submit" >Actualizar</button>
        {/if}
    {/if}
</form>

<style>
    form{
        margin-block: 15px;
        display: flex;
        padding: 40px;
        width: 400px;
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