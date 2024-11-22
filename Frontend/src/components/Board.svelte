<script>
    import { onMount } from "svelte";
    import { dndzone } from "svelte-dnd-action";
    import { flip } from "svelte/animate";
    import {UrlApi} from "@/const.js";
    import {navigate} from 'astro:transitions/client';

    let asset = $state([]);
    let inProgress = $state([]);
    let done = $state([]);
    let canceled = $state([]);

    function handleDndConsider(e){
        if(e.target.id === "asset"){
            asset = e.detail.items;
        }else if(e.target.id === "inProgress"){
            inProgress = e.detail.items;
        }else if(e.target.id === "done"){
            done = e.detail.items;
        }
    }

    function handleDndFinalize(e){
        if (e.detail.info.trigger === "droppedIntoZone") {
            if(e.target.id === "asset"){
                asset = e.detail.items;
                updateState(e.detail.info.id, 1);
            }else if(e.target.id === "inProgress"){
                inProgress = e.detail.items;
                updateState(e.detail.info.id, 2);
            }else if(e.target.id === "done"){
                done = e.detail.items;
                updateState(e.detail.info.id, 3);
            }
        }
    }

    async function updateState(id, state){
        let token = localStorage.getItem("token");

        await fetch(`${UrlApi}/ticket/state/${id}`, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                token: token,
            },
            body: JSON.stringify({
                state_id: state,
            }),
        });
    }

    onMount(async () => {
        let token = localStorage.getItem("token");

        let project = localStorage.getItem("project");

        const res = await fetch(`${UrlApi}/tickets/${project}`, {
            headers: {
                token: token,
            }
        });
        const data = await res.json();

        data.forEach(ticket => {
            if(ticket.state_id == 1){
                asset = [...asset, ticket];
            }else if(ticket.state_id == 2){
                inProgress = [...inProgress, ticket];
            }else if(ticket.state_id == 3){
                done = [...done, ticket];
            }else if(ticket.state_id == 4){
                canceled = [...canceled, ticket];
            }
        });
    });
</script>

<div class="board" >
    <div class="panel">
        <h3>Activos</h3>
        <div
            id="asset"
            class="dndzone"
            use:dndzone={{
              items: asset,
              flipDurationMs: 200,
            }}
            on:consider={handleDndConsider}
            on:finalize={handleDndFinalize}
        >
            {#each asset as ticket (ticket.id)}
                <div class="ticket"
                on:click={()=>{
                    navigate(`/home/tickets/${ticket.id}`);
                }}
                >
                    <p>{ticket.name}</p>
                </div>
            {/each}
        </div>   
    </div>

    <div class="panel">
        <h3>En Proceso</h3>
        <div
            id="inProgress"
            class="dndzone"
            use:dndzone={{
              items: inProgress,
              flipDurationMs: 200,
            }}
            on:consider={handleDndConsider}
            on:finalize={handleDndFinalize}
        >
            {#each inProgress as ticket (ticket.id)}
                <div class="ticket"
                on:click={()=>{
                    navigate(`/home/tickets/${ticket.id}`);
                }}
                >
                    <p>{ticket.name}</p>
                </div>
            {/each}
        </div>
    </div>
    <div class="panel">
        <h3>Finalizado</h3>
        <div
            id="done"
            class="dndzone"
            use:dndzone={{
              items: done,
              flipDurationMs: 200,
            }}
            on:consider={handleDndConsider}
            on:finalize={handleDndFinalize}
        >
            {#each done as ticket (ticket.id)}
                <div class="ticket"
                on:click={()=>{
                    navigate(`/home/tickets/${ticket.id}`);
                }}
                >
                    <p>{ticket.name}</p>
                </div>
            {/each}
        </div>
    </div>
</div>

<style>
    .board{
        display: flex;
        padding: 10px;
        height: 80%;
        min-width: 1300px;
        align-items: center;
        justify-content: space-between;
        gap: 10px;
    }
    .panel{
        display: flex;
        padding: 5px;
        height: 450px;
        width: 400px;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        border: 2px solid var(--Color_Border);
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); 
        border-radius: 10px;
    }
    .dndzone{
        display: flex;
        padding: 10px;
        height: 100%;
        width: 100%;
        align-items: center;
        flex-direction: column;
        overflow-y: auto;
        gap: 10px;
    }

    .ticket{
        display: flex;
        padding: 10px 5px;
        width: 80%;
        align-items: center;
        justify-content: center;
        text-align: center;
        border: 1px solid black;
        border-radius: 10px;
        margin: 5px;
   }
    
</style>