<script setup>
    import {ref} from "vue"

    const props = defineProps({
        state:{
            type: Boolean, 
            default: false
        }
    })
    const localState = ref(props.state)
    const emit = defineEmits(['statechanged'])
    function toggleState(){
        localState.value = !localState.value 
        emit('statechanged', localState.value)
    }
</script>
<template>
    <div :class="(localState ? 'is-active ' : '')+' host'" @click="toggleState">
        <i v-if="!localState" class="fa-solid fa-play"></i>
        <i v-if="localState" class="fa-solid fa-stop"></i>
    </div>
</template>
<style scoped>
    @keyframes breath {
        0%{
            box-shadow: 0px 0px 0px 6px #ff922588;
        }
        50%{
            box-shadow: 0px 0px 0px 4px #ff922588;
        }
        100%{
            box-shadow: 0px 0px 0px 6px #ff922588;
        }
    }
    .host{
        display: inline-block;
        width: 50px;
        height: 50px;
        background-color: rgb(158, 66, 243);
        border-radius: 50%;
        font-size: 24px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #ffffff;
        cursor: pointer;
    }
    .is-active{
        animation: breath;
        animation-iteration-count: infinite;
        animation-duration: 2s;
        background-color: #ff9225;
    }
    @media screen and (max-width: 769px) {
        .host{
            width: 40px;
            height: 40px;
            font-size: 18px;
        }
    }
</style>