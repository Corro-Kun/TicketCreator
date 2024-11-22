<script>
    import { onMount } from "svelte";
    import {UrlApi} from "@/const.js";
    import Loader from '@/components/icon/Loader.svelte';

    let loading = $state(0);

    let canceled = $state([]);

    onMount(async () => {
        loading = 1;

        let token = localStorage.getItem("token");

        let project = localStorage.getItem("project");

        const res = await fetch(`${UrlApi}/tickets/${project}`, {
            headers: {
                token: token,
            }
        });
        const data = await res.json();

        data.forEach(ticket => {
            if(ticket.state_id == 4){
                canceled = [...canceled, ticket];
            }
        });

        loading = 0;
    });
</script>

{#if loading}
    <Loader/>
{:else}
    {#each canceled as item}
        <a href={`/home/tickets/${item.id}`}>
            <p>{item.name}</p>
        </a>    
    {/each}
{/if}

<style>
    a{
        text-decoration: none;
        color: #000;
    }
    p{
        padding: 10px;
        border: 1px solid #000;
        border-radius: 10px;
    }
</style>