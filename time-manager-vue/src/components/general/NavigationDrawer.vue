<script setup>
import { useCounterStore } from '@/stores/counter'
import { useAuthUserStore } from '@/stores/authUser'
import { drawerStore } from '@/stores/drawerState.js'
import { ref } from "vue"
import { RouterLink } from 'vue-router'
const user = useAuthUserStore()
const drawer = drawerStore()
const active = ref(true)
function logOut(){
    user.logOut();
}
</script>
<template>
    <div :class="(drawer.active ? 'is-active ' : '')+' host'">
        <div class="drawer-overlay" @click="drawer.active = false"></div>
        <div class="content">
            <div class="account-info">
                <span class="full-name">{{ user.user.fullname }}</span>
                <span class="email">{{ user.user.email }}</span>
            </div>
            <div class="drawer-section" v-for="section in drawer.menus">
                <h2>{{section.name}}</h2>
                <RouterLink :to="menu.route" v-for="menu in section.children" :class="(menu.active? 'is-active' : '')+' drawer-menu'" @click="drawer.activate(menu)">
                    <i :class="menu.icon"></i>
                    <span>{{ menu.name }}</span>
                </RouterLink>
            </div>

        </div>
        <div class="left-content">
            <div @click="logOut" class="logout-btn">
                <i class="fa-solid fa-right-from-bracket"></i>
            </div>
            <div :class="(drawer.active ? 'is-active ' : '')+' drawer-toggler'" @click="drawer.active = !drawer.active">
                <i class="fa-solid fa-chevron-right"></i>
            </div>
            <div class="bottom-left-part">
                <RouterLink to="/dashboard/profile" class="left-btn-el">
                    <i class="fa-solid fa-user-gear"></i>
                    <span>PROFILE</span>
                </RouterLink>
                <RouterLink to="." class="left-btn-el">
                    <i class="fa-solid fa-bell"></i>
                </RouterLink>
                <RouterLink to="." class="left-btn-el">
                    <i class="fa-solid fa-circle-info"></i>
                </RouterLink>
            </div>
        </div>
    </div>
</template>
<style scoped>
    *{
        transition: all 0.5s ease;
    }
    .drawer-overlay{
        display: none;
    }
    .drawer-menu{
        cursor: pointer;
        transition: none;
    }
    .host{
        width: 50px;
        height: 100vh;
        background-color: #220a2e;
        display: inline-block;
        position: relative;
        overflow: hidden;
    }
    .host.is-active{
        width: 250px;
    }
    .content{
        width: calc(200px);
        height: 100%;
        background-color: #2c1338;
        position: absolute;
        top: 0px;
        left: 50px;
        z-index: 1;
    }
    .left-content{
        position: absolute;
        height: 100%;
        width: 50px;
        z-index: 2;
    }
    .left-content{
        color: #ffffff90;
    }
    .logout-btn, .drawer-toggler{
        cursor: pointer;
    }
    .logout-btn{
        width: 100%;
        height: 40px;
        background-color: #ffffff2d;
        color: #e57cd8;
        display: flex;
        justify-content: center;
        align-items: center;
        position: absolute;
        top: 10px;
        left: 0px;
    }
    .drawer-toggler{
        width: 100%;
        height: 40px;
        position: absolute;
        left: 0px;
        top: 50%;
        
        display: flex;
        justify-content: center;
        align-items: center;
        position: absolute;
    }
    .drawer-toggler.is-active{
        transform: rotate(180deg);
    }
    .bottom-left-part{
        position: absolute;
        bottom: 15px;
        left: 0px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: flex-end;
        width: 100%;
    }
    .bottom-left-part > *{
        margin-top: 40px;
    }
    .left-btn-el{
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }
    .left-btn-el span{
        font-weight: 200;
        font-size: 11px;
        margin-top: 3px;
        color: #ffffff90;
    }
    .left-btn-el i{
        color: #ffffff90;
    }
    .account-info{
        width: 100%;
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        font: 13px;
        color: #ffffff90;
        padding: 10px 0px;

        box-shadow: 0px 2px 4px 0px #00000088;
    }
    .account-info .email{
        font-size: 14px;
    }
    .account-info .full-name{
        color: #ffffff;
        font-size: 16px;
    }
    .account-info > *{
        margin-left: 10px;
    }
    .drawer-section{
        padding-left: 0px;
        padding-top: 30px;
    }
    .drawer-menu{
        display: flex;
        align-items: center;
        justify-content: flex-start;
        height: 40px;
    }
    .drawer-section h2{
        color: #ffffff88;
        font-size: 14px;
        margin: 5px 0px;
        margin-left: 20px;
        font-weight: 200;
    }
    .drawer-section .drawer-menu{
        font-size: 14px;
        color: #ffffff;
        padding-left: 20px;
    }
    .drawer-section .drawer-menu i{
        font-size: 20px;
        width: 40px;
    }
    .drawer-menu:hover{
        background-color: #e57cd8;
    }
    .drawer-menu.is-active{
        background-color: #ff4ae9a3;
    }
    .drawer-menu span{
        text-transform: capitalize;
    }
    @media screen and (max-width: 769px) {
        .host, .drawer-overlay{
            position: fixed;
            top: 0px;
            left: 0px;
        }
        .host{
            z-index: 5;
            width: 0px;
        }
        .drawer-overlay{
            top: 0px;
            left: 52px;
            width: 100vw;
            height: 100vh;
            display: block;
            background-color: #00000088;
            z-index: -1;
            opacity: 0;
            display: none;
        }
        .is-active .drawer-overlay{
            opacity: 1;
            display: block;
        }
        .drawer-toggler{
            display: none;
        }
    }
</style>