<script setup>
  import { ref, reactive, computed } from 'vue'
  import PulseLoader from 'vue-spinner/src/PulseLoader.vue'
  import router from '../router/index'
  import { useAuthUserStore } from '@/stores/authUser'
  import { RouterLink } from 'vue-router'
  import { useApiRouteStore } from '@/stores/apiRoute'

  const user = useAuthUserStore()
  const apiroute = useApiRouteStore()
  const loaderColor = ref("#000000")
  const loaderSize = ref("13px")
  const email = ref("")
  const password = ref("")
  const rememberMe = ref(false)
  var loading = ref(false)

  async function submit(){
    loading.value = true;
    axios.post(apiroute.baseUrl+'/sign_in',
    {
      email: email.value,
      password: password.value
    })
    .then(response => { 
      localStorage.setItem("jwt", response.data.jwt)
      axios.post(apiroute.baseUrl+"/account_details", {jwt:localStorage.jwt}, {headers: { 'Content-Type': 'application/json' } })
      .then(response2 => {
        user.setUser(response2.data.data)
        router.push("/dashboard");
      })
    });
    loading.value = false;
  }
</script>
<template>
    <div class="login">
         <img src="@/assets/img/login-bg.png" alt="image" class="login__bg">

         <form @submit.prevent="submit" class="login__form">
            <h1 class="login__title" >Login</h1>

            <div class="login__inputs">
               <div class="login__box">
                  <input type="email" v-model="email" placeholder="Email ID" required class="login__input">
                  <i class="ri-mail-fill"></i>
               </div>

               <div class="login__box">
                  <input type="password" v-model="password" placeholder="Password" required class="login__input">
                  <i class="ri-lock-2-fill"></i>
               </div>
            </div>

            <div class="login__check">
               <div class="login__check-box">
                  <input type="checkbox" v-model="rememberMe" class="login__check-input" id="user-check">
                  <label for="user-check" class="login__check-label">Remember me</label>
               </div>

               <a href="#" class="login__forgot">Forgot Password?</a>
            </div>

            <button type="submit" class="login__button" :disabled="loading">
              <pulse-loader v-if="loading" :loading="loading" :color="loaderColor" size="10px"></pulse-loader>
              <span v-if="!loading">Login</span> 
            </button>

            <div class="login__register">
               Don't have an account? <RouterLink to="/signup"  >Register</RouterLink>
            </div>
         </form>
    </div>
</template>
<style scoped>
:root {
  /*========== Colors ==========*/
  /*Color mode HSL(hue, saturation, lightness)*/
  --white-color: hsl(0, 0%, 100%);
  --black-color: hsl(0, 0%, 0%);

  /*========== Font and typography ==========*/
  /*.5rem = 8px | 1rem = 16px ...*/
  --body-font: "Poppins", sans-serif;
  --h1-font-size: 2rem;
  --normal-font-size: 1rem;
  --small-font-size: .813rem;
}

/*=============== BASE ===============*/
* {
  box-sizing: border-box;
  padding: 0;
  margin: 0;
  font-family: "Poppins", sans-serif;
}

body,
input,
button {
  font-family: "Poppins", sans-serif;
  font-size: 1rem;
}

a {
  text-decoration: none;
}

img {
  display: block;
  max-width: 100%;
  height: auto;
}

/*=============== LOGIN ===============*/
.login {
  position: relative;
  height: 100vh;
  display: grid;
  align-items: center;
}

.login__bg {
  position: absolute;
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center;
}

.login__form {
  position: relative;
  margin-inline: 1.5rem;
  background-color: hsla(0, 0%, 100%, .01);
  border: 4px solid hsla(0, 0%, 100%, .7);
  padding: 2.5rem 1rem;
  color: hsl(0, 0%, 100%);
  border-radius: 40px;
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
}

.login__title {
  text-align: center;
  font-size: 2rem;
  margin-bottom: 1.25rem;
}

.login__inputs, 
.login__box {
  display: grid;
}

.login__inputs {
  row-gap: 1.25rem;
  margin-bottom: 1rem;
}

.login__box {
  grid-template-columns: 1fr max-content;
  column-gap: .75rem;
  align-items: center;
  border: 2px solid hsla(0, 0%, 100%, .7);
  padding-inline: 1.25rem;
  border-radius: 4rem;
}

.login__input, 
.login__button {
  border: none;
  outline: none;
}

.login__input {
  width: 100%;
  background: none;
  color: hsl(0, 0%, 100%);
  padding-block: 1rem;
}

.login__input::placeholder {
  color: hsl(0, 0%, 100%);
}

.login__box i {
  font-size: 1.25rem;
}

.login__check, 
.login__check-box {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.login__check {
  margin-bottom: 1rem;
  font-size: .813rem;
}

.login__check-box {
  column-gap: .5rem;
}

.login__check-input {
  width: 1rem;
  height: 1rem;
  accent-color: hsl(0, 0%, 100%);
}

.login__forgot {
  color: hsl(0, 0%, 100%);
}

.login__forgot:hover {
  text-decoration: underline;
}

.login__button {
  width: 100%;
  padding: 1rem;
  margin-bottom: 1rem;
  background-color: hsl(0, 0%, 100%);
  border-radius: 4rem;
  color: hsl(0, 0%, 0%);
  font-weight: 500;
  cursor: pointer;
}

.login__register {
  font-size: .813rem;
  text-align: center;
}

.login__register a {
  color: hsl(0, 0%, 100%);
  font-weight: 500;
}

.login__register a:hover {
  text-decoration: underline;
}

/*=============== BREAKPOINTS ===============*/
/* For medium devices */
@media screen and (min-width: 576px) {
  .login {
    justify-content: center;
  }
  .login__form {
    width: 420px;
    padding-inline: 2.5rem;
  }
  .login__title {
    margin-bottom: 2rem;
  }
}
</style>