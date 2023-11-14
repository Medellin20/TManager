<script setup>
    import { ref } from 'vue';
    import { useAuthUserStore } from '@/stores/authUser'
    const user = useAuthUserStore()
    const fullname = ref(JSON.parse(localStorage.user).fullname)
    const username = ref(JSON.parse(localStorage.user).username)
    const email = ref(JSON.parse(localStorage.user).email)
    const oldPass = ref("")
    const newPass = ref("")
    const confirmPass = ref("")
    const userDataUpdated = ref(false) 
    const newPassword = ref(false)
    async function submitInfos(){
        axios.post('http://localhost:4000/api/account_update',
            {
                id: JSON.parse(localStorage.user).id,
                user:{
                    email: email.value,
                    fullname: fullname.value,
                    username: username.value
                },
                jwt: localStorage.jwt
            }
        )
        .then(response => { 
            user.setUser(response.data.data)
            userDataUpdated.value = false
        });
    }
    function submitPass(){
        axios.post('http://localhost:4000/api/pass_update',
            {
                id: JSON.parse(localStorage.user).id,
                user:{
                    password: newPass.value
                },
                jwt: localStorage.jwt
            }
        )
        .then(response => { 
            user.setUser(response.data.data)
            newPassword.value = false
            newPass.value = ""
            oldPass.value = ""
            confirmPass.value = ""
        });
    }
    function controlPass(){
        if(confirmPass.value.length > 0 && oldPass.value.length > 0 && newPass.value.length > 0){
            newPassword.value = true
        }else{
            newPassword.value = false
        }
    }
</script>
<template>
    <div class="container">
        <form @submit.prevent="submitInfos">
            <h2>Edit your profile</h2>
            <div class="input-sec">
                <span>Full Name:</span>
                <input type="text" v-model="fullname" @input="userDataUpdated=true" placeholder="Full name" required>
            </div>
            <div class="input-sec">
                <span>Username:</span>
                <input type="text" v-model="username" @input="userDataUpdated=true" placeholder="Full name" required>
            </div>
            <div class="input-sec">
                <span>E-mail:</span>
                <input type="text" v-model="email" @change="userDataUpdated=true" placeholder="email" required>
            </div>
            <div class="input-sec">
                <button type="submit" :disabled="!userDataUpdated">Save</button>
            </div>
        </form>

        <form @submit.prevent="submitPass">
            <h2>Edit your password</h2>
            <div class="input-sec">
                <span>Current password:</span>
                <input type="text" v-model="oldPass" @input="controlPass" placeholder="Current password" required>
            </div>
            <div class="input-sec">
                <span>New password:</span>
                <input type="text" v-model="newPass" @input="controlPass" placeholder="New password" required>
            </div>
            <div class="input-sec">
                <span>Confirm password:</span>
                <input type="text" v-model="confirmPass" @input="controlPass" placeholder="Confirm password" required>
            </div>
            <div class="input-sec">
                <button type="submit" :disabled="!newPassword">Update password</button>
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