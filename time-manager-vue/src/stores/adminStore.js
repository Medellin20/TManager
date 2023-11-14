import { ref, computed } from 'vue'
import { defineStore } from 'pinia'
import router from '../router/index'
import axios from "axios"
import { useApiRouteStore } from '@/stores/apiRoute'

export const useAdminStore = defineStore('adminstore', () => {

    const apiroute = useApiRouteStore()

    const users = ref(JSON.parse(localStorage.getItem('users') || "[]"))
    function getUsers(){
        return axios.get(apiroute.baseUrl+"/admin/users").then((response) => {
            users.value = response.data.data
            console.log(users.value)
            localStorage.setItem("users", JSON.stringify(users))
        })
    }
    return {users, getUsers}
})
