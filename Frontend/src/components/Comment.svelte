<script>
    import {onMount} from 'svelte';
    import {UrlApi} from "@/const.js";

    let {id} = $props();

    let comments = $state([]);

    let comment = $state('');

    onMount(async ()=>{
        let token = localStorage.getItem("token");

        const response = await fetch(`${UrlApi}/comments/${id}`,{
            headers: {
                token: token
            }
        });

        comments = await response.json();
    });

    async function HandleClick(){
        let token = localStorage.getItem("token");

        await fetch(`${UrlApi}/comment`,{
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                token: token
            },
            body: JSON.stringify({description: comment, ticket_id: id})
        });

        comment = '';

        let response = await fetch(`${UrlApi}/comments/${id}`,{
            headers: {
                token: token
            }
        });

        comments = await response.json();
    }
</script>

<div class="list" >
    {#each comments as comment}
        <div>
            <h4>{comment.name}</h4>
            <p>{comment.description}</p>
        </div>
    {/each}
</div>
<div class="create-comment" >
    <textarea placeholder="Comentario" bind:value={comment} ></textarea>
    <button onclick={HandleClick} >Enviar</button>
</div>


<style>
    .list{
        display: flex;
        flex-direction: column;
        gap: 10px;
        color: var(--Color_Text);
    }
    .create-comment{
        margin-top: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        color: var(--Color_Text);
    }
    textarea{
        width: 100%;
        height: 50px;
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
        width: 100px;
        height: 45px;
        background: var(--Color_Background_Second);
        border: none;
        outline: none;
        color: var(--Color_Text_Second);
        border-radius: 6px;
        cursor: pointer;
    }
</style>