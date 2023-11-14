import { ref, computed } from 'vue'
import { defineStore } from 'pinia'
import router from '../router/index'
import axios from "axios"
import { useApiRouteStore } from '@/stores/apiRoute'

export const useAuthUserStore = defineStore('authUser', () => {
  const apiroute = useApiRouteStore()
  const user = ref(JSON.parse(localStorage.getItem('user') || false))
  const myWorkingTimes = ref(JSON.parse(localStorage.getItem('myWorkingTimes') || false))
  const allWorkingTimes = ref(JSON.parse(localStorage.getItem('allWorkingTimes') || false))
  const jwt = ref((localStorage.getItem('jwt') || false))

  if(jwt.value){
    getUserInfos();
  }
  
  const fullName = computed(() => {
    if(user.value){
      return user.value.fullname
    }else{
      return ""
    }
  })
  const email = computed(() => {
    if(user.value !== null){
      return user.value.email
    }else{
      return ""
    }
  })
  function setUser(newUser){
    localStorage.setItem("user", JSON.stringify(newUser))
    user.value = newUser
  }
  function logOut(){
    setUser(false)
    localStorage.clear()
    router.push("/login");
  }
  async function register(fullname, email, password){
    var success = false;
    await axios
    .post(apiroute.baseUrl+'/sign_up',
    {
      user:{
        email: email,
        password: password,
        fullname: fullname
      }
    })
    .then(response => { 
      localStorage.setItem("jwt", response.data.jwt)
      //console.log(response.data.jwt)
      if(getUserInfos() !== null){
        success = true;
        return success
      }
      
    });
    return success
  }
  async function login(email, password){
    var success = false;
    await axios
    .post(apiroute.baseUrl+'/sign_in',
    {
      email: email,
      password: password
    })
    .then(response => { 
      localStorage.setItem("jwt", response.data.jwt)
      //console.log(response.data.jwt)
      if(getUserInfos() !== null){
        success = true;
      }
      
    });
    return success
  }
  async function getUserInfos(){
    var user_r = null
    await axios.post(apiroute.baseUrl+"/account_details", {jwt:localStorage.jwt}, {headers: { 'Content-Type': 'application/json' } })
    .then(response => {
      //console.log(response.data.data)
      setUser(response.data.data)
      user_r = response.data.data
    })
    return user_r
  }
  function updateWorkingTimes(){
    return axios.get(apiroute.baseUrl+"/workingtimes").then((response) => {
      var userWorkTimes = [];
      var totalWorkTimes = [];
      response.data.data.forEach(element => {
        totalWorkTimes.push(element)
        if(element.user_id == user.value.id){
          userWorkTimes.push(element)
        }
      });
      localStorage.setItem("myWorkingTimes", JSON.stringify(userWorkTimes))
      localStorage.setItem("allWorkingTimes", JSON.stringify(totalWorkTimes))
    })
  }
  return {register, login, getUserInfos, setUser, logOut, user, updateWorkingTimes}
})
