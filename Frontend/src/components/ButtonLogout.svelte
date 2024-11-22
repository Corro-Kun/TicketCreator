<script>
    import {navigate} from 'astro:transitions/client';
    import Logout from '@/components/icon/Logout.svelte';
    import {deleteCookie} from '@/lib/Cookies';

    function HandleButton(){
        if (typeof window === 'undefined') return;
        localStorage.removeItem('token');
        localStorage.removeItem("project");
        deleteCookie('token');
        navigate('/login');
    }
</script>

<button
onclick={HandleButton}
title="cerrar sesión"
>
    <Logout />
</button>

<style>
    button{
        position: relative;
        display: flex;
        height: 35px;
        width: 35px;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        color: var(--Color_Text);
        transition: .3s;
        border: none;
        cursor: pointer;
    }
    button:hover{
        color: var(--Color_Background_Second);
    }
</style>