<script>
    import {onMount} from 'svelte';
    import {navigate} from 'astro:transitions/client';

    onMount(async () => {
        if(localStorage.getItem("token") === null) navigate("/login");
    });
</script>