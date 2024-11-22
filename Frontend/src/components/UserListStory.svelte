<script>
    import {UrlApi} from "@/const.js";
    import { onMount } from 'svelte';
    import CardStory from './CardStory.svelte';
    import Loader from '@/components/icon/Loader.svelte';

    let data = $state([]);

    let loading = $state(1);

    onMount(async () => {
        loading = 1;

        let token = localStorage.getItem("token");

        let project = localStorage.getItem("project");
        project = project ? JSON.parse(project) : null;

        if (!project){
            loading = 3;
            return;
        }

        const response = await fetch(`${UrlApi}/user_stories/${project}`,{
            headers: {
                token: token
            }
        });
        data = await response.json();

        if (data.length === 0){
            loading = 2;
            return;
        }

        loading = 0;
    });

</script>

{#if loading === 0 || loading === 2}
<div class="create" >
    <a href="/home/stories/new">Crear</a>
</div>
{/if}

<div class="main" >
    {#if loading === 1}
        <Loader />
    {:else if loading === 2}
        <h2>No hay historias de usuario</h2>
    {:else if loading === 3}
    <div class="select" >
        <h2>Seleccione un proyecto</h2>
        <a href="/home/projects">Proyectos</a>
    </div>
   {/if}
    {#each data as story}
        <CardStory {...story} />
    {/each}
</div>

<style>
    .main{
        display: flex;
        width: 100%;
        padding: 10px;
        align-items: center;
        justify-content: center;
        flex-wrap: wrap;
    }
    h2{
        color: var(--Color_Text);
        font-weight: bold;
    }
    .create{
        padding: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .select{
        display: flex;
        gap: 10px;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }
    a{
        padding: 5px 8px;
        text-decoration: none;
        color: var(--Color_Text_Second);
        background-color: var(--Color_Background_Second);
        border-radius: 5px;
    }
</style>