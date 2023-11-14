<script setup>
import {ref, computed, onMounted} from "vue"
import { Bar } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'
import { useAuthUserStore } from '@/stores/authUser'
import { useApiRouteStore } from '@/stores/apiRoute'
import router from '../../router/index'
import { useRoute } from 'vue-router'

    const route = useRoute()
    const user = useAuthUserStore()
    const apiroute = useApiRouteStore()
    const startFeching = ref(true)
    var allTimes = JSON.parse(localStorage.getItem("allWorkingTimes") || "[]");
    var userTimes = [];
    allTimes.forEach(element => {
        if(element.user_id == route.params.id){
            userTimes.push(element)
        }
    });
    const inputData = ref(userTimes);

    user.updateWorkingTimes().then((response) => {
        allTimes = JSON.parse(localStorage.getItem("allWorkingTimes") || "[]");
        userTimes = [];
        allTimes.forEach(element => {
            if(element.user_id == route.params.id){
                userTimes.push(element)
            }
        });
        inputData.value = userTimes;
    }).catch(() => {
    })

    ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

    function filterDataByUserId(data, userId) {
        return data.filter(entry => entry.user_id === userId);
    }

    const switched = ref(false)
    const chartData = computed(() => {
            const [days, workingHours] = computeWorkingTimes(inputData.value, (switched.value ? 30 : 7));
            return {labels: days.reverse(), datasets: [{ data: workingHours.reverse(), label: 'hours', borderColor: '#36A2EB',
        backgroundColor: '#9BD0F5', }]}
    })  
    const chartOptions = ref({
        responsive: true
    })

    function computeWorkingTimes(data, daysLen = 7) {
    const currentDate = new Date();
    const lastSevenDays = Array.from({ length: daysLen }, (_, index) => {
        const day = new Date(currentDate);
        day.setDate(currentDate.getDate() - index);
        return day.toISOString().split('T')[0]; // Get the date in the format "YYYY-MM-DD"
    });

    const workingTimesPerDay = {};

    lastSevenDays.forEach(day => {
        const dayEntries = data.filter(entry => entry.start.includes(day));
        const totalWorkingTime = dayEntries.reduce((total, entry) => {
        const start = new Date(entry.start);
        const end = new Date(entry.end);
        return total + (end - start) / (1000 * 60 * 60); // Convert milliseconds to hours
        }, 0);

        workingTimesPerDay[day] = totalWorkingTime.toFixed(2); // Round to 2 decimal places
    });

    return convertDataToArrays(workingTimesPerDay, daysLen);
    }
    function convertDataToArrays(data, daysLen = 7) {
    const daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

    const result = Object.entries(data).reduce((acc, [date, hours]) => {
        const dayOfWeek = new Date(date).getDay();
        const dayName = daysOfWeek[dayOfWeek];

        if(daysLen < 8){
            acc[0].push(dayName);
        }else{
            acc[0].push(dayName+" "+date);
        }
        
        acc[1].push(parseFloat(hours));

        return acc;
    }, [[], []]);

    return result;
    }

</script>
<template >
    <div :class="(switched ? 'is-active ' : '')+' switch'" @click="switched = !switched">
        <div class="state">
            {{ switched ? "Mounth" : "Week" }}
        </div>
    </div>
    <div class="container">
        <Bar
            id="my-chart-id"
            :options="chartOptions"
            :data="chartData"
        />
    </div>
</template>
<style scoped>
    *{
        transition: all ease 0.3s;
    }
    .container{
        width: calc(100% - 250px);
        cursor: pointer;
        margin-top: 20px;
    }
    .switch{
        display: inline-flex;
        background-color: #2c13383d;
        width: 130px;
        border-radius: 40px;
        height: 50px;
        justify-content: flex-start;
        align-items: center;
        padding: 5px;
    }
    .switch.is-active{
        justify-content: flex-end;
    }
    .switch .state{
        display: inline-flex;
        justify-content: center;
        align-items: center;
        background-color: #2c1338;
        height: 100%;
        width: 100px;
        border-radius: 40px;
        color: white;
    }
    @media screen and (max-width: 769px) {
        .container{
            width: 100%;
        }
    }
</style>