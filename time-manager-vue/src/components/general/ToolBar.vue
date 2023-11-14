<script setup>
    import {ref, onMounted, onBeforeMount} from "vue"
    import ClockBtn from './ClockBtn.vue'
    import Timer from './Timer.vue';
    import { drawerStore } from '@/stores/drawerState.js'
    import axios from "axios";
    import { useAuthUserStore } from '@/stores/authUser'
    import { useApiRouteStore } from '@/stores/apiRoute'

    const user = useAuthUserStore()
    const apiroute = useApiRouteStore()
    
    const hoursPassed = ref(0);
    const minutesPassed = ref(0)
    const secondesPassed = ref(0)
    const timeStateUpdated = ref(false)

    function getNewTime($event){}
    const drawer = drawerStore()
    const timerInstance = ref(null)
    const isTimerRuning = ref(false)
    function updateTimeState(state){
        isTimerRuning.value = state
        //console.log(timerInstance.value)
    }
    async function getClockState(){
        await axios.post(apiroute.baseUrl+"/account_details", {jwt:localStorage.jwt}, {headers: { 'Content-Type': 'application/json' } })
        .then(response2 => {
            user.setUser(response2.data.data)
            if(response2.data.data.clock != "0" && response2.data.data.clock != null){
                var timeObject = getTimePassed(response2.data.data.clock)
                hoursPassed.value = timeObject.hours
                minutesPassed.value = timeObject.minutes
                secondesPassed.value = timeObject.seconds
                isTimerRuning.value = true
                console.log(minutesPassed.value,secondesPassed.value)
            }
            timeStateUpdated.value = true
        })
    }
    function getTimePassed(datetimeString) {
        // Parse the input datetime string
        const startTime = new Date(datetimeString);

        // Get the current time
        const currentTime = new Date();

        // Calculate the time difference in milliseconds
        const timeDifference = currentTime - startTime;

        // Calculate hours, minutes, and seconds
        const hours = Math.floor(timeDifference / (1000 * 60 * 60));
        const minutes = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((timeDifference % (1000 * 60)) / 1000);

        // Return the result as an object
        return {
            hours: hours - 1,
            minutes: minutes,
            seconds: seconds
        };
    }
    function clock(){
        var currentClock = JSON.parse(localStorage.user).clock
        let date = new Date();
        var newClock = date.toISOString().slice(0, 19)
        var clockOut = newClock
        if(currentClock != "0" && currentClock != null){
            newClock = "0"
        }
        axios.post(apiroute.baseUrl+"/clock_in", {user:{clock:newClock}, jwt:localStorage.jwt}, {headers: { 'Content-Type': 'application/json' } })
        .then(response2 => {
            user.setUser(response2.data.data)
            if(newClock == "0"){
                axios.post(apiroute.baseUrl+"/workingtimes",{workingtime: {user_id: response2.data.data.id, start: currentClock, end: clockOut}})
                .then(() => {
                    user.updateWorkingTimes()
                })
            }
        })
    }
    
    onMounted(() => {
        getClockState()

    })
</script>
<template>
    <div class="toolbar">
        <div class="container">
            <div class="burger-menu" @click="drawer.active = !drawer.active">
                <i class="fa fa-bars"></i>
            </div>
            <div class="dashbord-state">{{drawer.currentPage}}</div>
            <div class="clock">
                <Timer v-if="timeStateUpdated" class="timer" @time-updated="getNewTime" v-model:active="isTimerRuning" v-model:initial-hours="hoursPassed" v-model:initial-minutes="minutesPassed" v-model:initial-secondes="secondesPassed" ref="timerInstance"></Timer>
                <ClockBtn v-if="timeStateUpdated" v-on:statechanged="updateTimeState" :state="isTimerRuning" @click="clock"></ClockBtn>
            </div>
        </div>
    </div>
</template>
<style scoped>
    .toolbar{
        height: 80px;
        width: 100%;
        box-shadow: 0px 0px 5px #0000007b;
        background-color: #ffffff;
        display: inline-block;
        position: relative;
        z-index: 4;
    }
    .burger-menu{
        display: none;
    }
    .container{
        padding: 0px 20px;
        height: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .clock{
        display: inline-flex;
        justify-content: flex-end;
        align-items: center;
        height: 100%;
    }
    .timer{
        margin-right: 20px;
    }
    .dashbord-state{
        font-size: 20px;
        font-weight: bold;
    }
    .dashbord-state{
        text-transform: capitalize;
    }
    @media screen and (max-width: 769px) {
        .burger-menu{
            display: inline-flex;
            width: 50px;
            height: 40px;
            justify-content: flex-start;
            align-items: center;
        }
        .toolbar{
            height: 56px;
        }
    }
</style>