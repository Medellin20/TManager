<script setup>
    import { computed } from "@vue/reactivity";
    import {onMounted, ref, watch} from "vue"
    const propos = defineProps({
        initialHours:{
            type: Number, 
            default: 0
        },
        initialMinutes:{
            type: Number, 
            default: 0
        },
        initialSecondes:{
            type: Number, 
            default: 0
        },
        active:{
            default:false
        }
    })
    const timer = ref(null)
    const emit = defineEmits(['time-updated'])
    const hours = ref(propos.initialHours)
    const minutes = ref(propos.initialMinutes)
    const secondes = ref(propos.initialSecondes)

    const displayedHours = computed(() => {
        return hours.value > 9 ? hours.value : '0'+hours.value
    })
    const displayedMinutes = computed(() => {
        return minutes.value > 9 ? minutes.value : '0'+minutes.value
    })
    const displayedSecondes = computed(() => {
        return secondes.value > 9 ? secondes.value : '0'+secondes.value
    })
    const startTimer = () => {
        timer.value = setInterval(() => {
            if(propos.active){
                if(secondes.value == 59){
                    if(minutes.value == 59){
                        minutes.value = 0
                        hours.value++
                    }else{
                        secondes.value = 0
                        minutes.value++
                    }
                }else{
                    secondes.value++
                }
                emit("time-updated", [hours.value,minutes.value,secondes.value])
            }
        }, 1000)
    }
    function stopTimer(){
        timer.value = null
    }
    onMounted(() => {
        startTimer()
    });
</script>
<template>
    <div :class="(active ? 'is-active ' : '')+' host'">
        <span>{{displayedHours}}</span>:<span>{{displayedMinutes}}</span>:<span>{{displayedSecondes}}</span>
    </div>
</template>
<style scoped>
    .host{
        display: inline-block;
        font-size: 20px;
        color: #00000088;
    }
    .is-active{
        color: #000000;
    }
</style>