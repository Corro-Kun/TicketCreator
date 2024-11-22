<script>
  import {UrlApi} from "@/const.js";
  import { onMount } from "svelte";
  import {navigate} from 'astro:transitions/client';
  import Loader from '@/components/icon/Loader.svelte';
  import { setCookie } from "@/lib/Cookies.js";
  import Input from './Input.svelte';


  let data = $state({
    email: "",
    password: "",
  });

  let loading = $state(0);

  onMount(async () => {
    if(localStorage.getItem("token")) navigate("/home/projects");
  });

  const login = async (e) => {
    e.preventDefault();
    loading = 1;
    const response = await fetch(`${UrlApi}/login`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    });
    if (response.status === 200) {
      loading = 0;
      const res = await response.json();
      localStorage.setItem("token", res.token);
      setCookie("token", res.token, 30);
      navigate("/home/projects"); 
    } else {
      const res = await response.json();
      loading = 0;
      alert(res.message);
    }
  };
</script>

<div class="login">
  <div class="main">
    <h2>Iniciar sesión</h2>
    <form onsubmit={login} >
      <Input id="email" type="text" required bind:value={data.email} label="Correo">
        <svg version="1.0" xmlns="http://www.w3.org/2000/svg" width="15.000000pt" height="15.000000pt" viewBox="0 0 64.000000 64.000000" preserveAspectRatio="xMidYMid meet" >
          <g transform="translate(0.000000,64.000000) scale(0.100000,-0.100000)" stroke="none" >
            <path d="M43 550 c-38 -16 -43 -41 -43 -233 0 -167 2 -187 19 -208 l19 -24 282 0 282 0 19 24 c17 21 19 41 19 211 0 170 -2 190 -19 211 l-19 24 -269 2 c-147 1 -278 -2 -290 -7z m407 -155 c-63 -63 -122 -115 -130 -115 -8 0 -67 52 -130 115 l-115 115 245 0 245 0 -115 -115z m-130 -158 c27 0 50 18 156 124 l124 124 0 -165 0 -164 -63 62 c-59 58 -97 78 -97 50 0 -7 28 -41 62 -75 l62 -63 -244 0 -245 0 58 51 c32 29 57 59 57 70 0 27 -22 24 -51 -7 -13 -14 -41 -39 -62 -56 l-37 -30 0 164 0 163 124 -124 c106 -106 129 -124 156 -124z" /> 
          </g> 
        </svg>
      </Input>
      <Input id="password" type="password" required bind:value={data.password} label="Contraseña" >
      <svg
          version="1.0"
          xmlns="http://www.w3.org/2000/svg"
          width="16.000000pt"
          height="16.000000pt"
          viewBox="0 0 64.000000 64.000000"
          preserveAspectRatio="xMidYMid meet"
        >
          <g
            transform="translate(0.000000,64.000000) scale(0.100000,-0.100000)"
            stroke="none"
          >
            <path
              d="M265 571 c-50 -23 -75 -65 -75 -125 0 -35 -4 -46 -15 -46 -9 0 -27
                    -11 -40 -25 -24 -23 -25 -30 -25 -144 0 -66 3 -127 6 -136 14 -35 58 -45 204
                    -45 146 0 190 10 204 45 3 9 6 70 6 136 0 114 -1 121 -25 144 -13 14 -31 25
                    -40 25 -11 0 -15 11 -15 46 0 62 -29 107 -80 128 -50 20 -56 20 -105 -3z m110
                    -66 c18 -18 25 -35 25 -65 l0 -40 -80 0 -80 0 0 40 c0 51 34 90 80 90 19 0 40
                    -9 55 -25z m94 -169 c8 -9 11 -50 9 -117 l-3 -104 -155 0 -155 0 -3 104 c-2
                    67 1 108 9 117 9 11 43 14 149 14 106 0 140 -3 149 -14z"
            />
            <path
              d="M296 274 c-11 -30 -6 -91 9 -104 23 -19 45 5 45 50 0 51 -8 70 -30
                    70 -10 0 -21 -7 -24 -16z"
            />
          </g>
        </svg> 
      </Input>
     {#if loading}
      <div class="loader" >
        <Loader />
      </div>
      {:else}
      <button type="submit">Iniciar</button>
      {/if}
      <div class="account" >
        <p>¿no tienes una <a href="./register">cuenta</a>?</p>
      </div>
    </form>
  </div>
</div>

<style>
  .login {
    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    position: relative;
    margin: 10px;
    width: 400px;
    height: 440px;
    background: transparent;
    backdrop-filter: blur(30px);
    border: 1px solid var(--Color_Border);
    border-radius: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); 
    transition:
      transform 0.5s ease,
      height 0.2s ease,
      border 0.5s ease,
      box-shadow 0.5s ease;
  }
  .main {
    width: 100%;
    padding: 40px;
    transform: translateX(0);
    transition: 0.18s ease;
  }
  .main h2 {
    color: var(--Color_Text);
    text-align: center;
    font-size: 2.2em;
    transition: 0.3s;
  }
  svg {
    position: absolute;
    top: 50%;
    right: 5px;
    transform: translateY(-50%);
    fill: var(--Color_Text);
    transition: 0.3s;
  }
  button {
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
  .account{
    text-align: center;
    margin-top: 20px;
  }
  .account a{
    font-weight: 600;
    text-decoration: none;
    color: var(--Color_Background_Second);
  }
  .loader{
    display: flex;
    justify-content: center;
    align-items: center;
  }
</style>