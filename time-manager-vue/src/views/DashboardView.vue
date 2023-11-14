<script setup>
import TheWelcome from '../components/TheWelcome.vue'
import ToolBar from '../components/general/ToolBar.vue'
import NavigationDrawer from '../components/general/NavigationDrawer.vue';
import { RouterView } from 'vue-router';
</script>

<template>
    <div class="container">
        <NavigationDrawer class="drawer"></NavigationDrawer>
        <div class="toolbar-section">
            <ToolBar class="toolbar"></ToolBar>
            <div class="content">
                <RouterView></RouterView>
            </div>
        </div>
    </div>
</template>
<style scoped>
    .toolbar-section{
        flex-grow: 1;
    }
    .container{
        display: flex;
    }
    .drawer{
        flex-shrink: 0;
    }
    .content{
        background-color: #fef9f7;
        height: calc(100vh - 80px);
        overflow: scroll;
        padding: 16px;
    }
    @media screen and (max-width: 769px){
        .content{
            height: calc(100vh - 56px);
        }
    }
</style>