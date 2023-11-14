<script setup>
    import { ref } from 'vue';
    import { useAuthUserStore } from '@/stores/authUser'
    import { useApiRouteStore } from '@/stores/apiRoute'
    import router from '../../router/index'

    const apiroute = useApiRouteStore()
    function generateRandomPassword() {
        const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+";

        let password = "";
        for (let i = 0; i < 8; i++) {
            const randomIndex = Math.floor(Math.random() * charset.length);
            password += charset[randomIndex];
        }

        return password;
    }
    const user = useAuthUserStore()

    const fullname = ref("")
    const username = ref("")
    const email = ref("")
    const password = ref(generateRandomPassword())
   
    async function submit(){
        //loading.value = true;
        axios.post(apiroute.baseUrl+'/sign_up',
        {user:{
        email: email.value,
        password: password.value,
        fullname: fullname.value,
        username: username.value
        }})
        .then(response => { 
            router.push("/dashboard/admin/employees");
        });
        //loading.value = false;
    }
    
</script>
<template>
    <div class="container">
        <form @submit.prevent="submit">
            <h2>New Employee</h2>
            <div class="input-sec">
                <span>Full Name:</span>
                <input type="text" v-model="fullname" placeholder="Full name" required>
            </div>
            <div class="input-sec">
                <span>Username:</span>
                <input type="text" v-model="username" placeholder="Full name" required>
            </div>
            <div class="input-sec">
                <span>E-mail:</span>
                <input type="text" v-model="email" placeholder="email" required>
            </div>
            <div class="input-sec">
                <span>New password:</span>
                <input type="text" v-model="password" placeholder="Password" required>
            </div>
            <div class="input-sec">
                <button type="submit">Add Employee</button>
            </div>
        </form>
    </div>
    
</template>
<style scoped>
.container{
    display: flex;
    flex-direction: column;
    align-items: center;
    padding-bottom: 100px;
}
form, .input-sec {
    display: flex;
    flex-direction: column;
    justify-content: center;
}
form{
    margin-top: 50px;
    width: 100%;
    align-items: center;
}
.input-sec{
    margin-top: 30px;
    width: 400px;
}
.input-sec span{
    margin-bottom: 5px;
}
input{
    width: calc(100% - 40px);
    height: 50px;
    border-radius: 50px;
    border: 1px solid #0000003e;
    padding: 0px 20px;
}
button{
    width: 400px;
    height: 50px;
    border-radius: 50px;
    border: 1px solid #0000003e;
    border: none;
    background-color: #2c1338;
    color: #ffffff;
}
button:disabled{
    opacity: 0.3;
}
@media screen and (max-width: 769px){
    .input-sec, button{
        width: calc(100vw - 40px);
    }
}
</style>