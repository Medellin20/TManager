import { ref, computed } from 'vue'
import { defineStore } from 'pinia'

export const drawerStore = defineStore('drawerState', () => {
    var adminData = [
        {
            name: "ANALYSE",
            children: [
                {
                    name: "report",
                    route: "/dashboard/report",
                    icon: "fa-solid fa-chart-pie",
                    active: false
                }
            ]
        },
        {
            name: "MANAGER TOOLS",
            children: [
                {
                    name: "report",
                    route: "/dashboard/report",
                    icon: "fa-solid fa-chart-pie",
                    active: false
                },
                {
                    name: "teams",
                    route: "/dashboard/teams",
                    icon: "fa-solid fa-users",
                    active: false
                }
            ]
        },
        {
            name: "ADMIN TOOLS",
            children: [
                {
                    name: "report",
                    route: "/dashboard/report",
                    icon: "fa-solid fa-chart-pie",
                    active: false
                },
                {
                    name: "employees",
                    route: "/dashboard/admin/employees",
                    icon: "fa-solid fa-person",
                    active: false
                },
                {
                    name: "teams",
                    route: "/dashboard/admin/teams",
                    icon: "fa-solid fa-user-group",
                    active: false
                }
            ]
        }
    ]
    var managerData = [
        {
            name: "ANALYSE",
            children: [
                {
                    name: "report",
                    route: "/dashboard/report",
                    icon: "fa-solid fa-chart-pie",
                    active: false
                }
            ]
        },
        {
            name: "MANAGER TOOLS",
            children: [
                {
                    name: "report",
                    route: "/dashboard/report",
                    icon: "fa-solid fa-chart-pie",
                    active: false
                },
                {
                    name: "teams",
                    route: "/dashboard/teams",
                    icon: "fa-solid fa-users",
                    active: false
                }
            ]
        }
    ]
    var userData = [
        {
            name: "ANALYSE",
            children: [
                {
                    name: "report",
                    route: "/dashboard/report",
                    icon: "fa-solid fa-chart-pie",
                    active: false
                }
            ]
        }
    ]
    const active = ref(false)
    
    const menus = ref([])
    updateMenus()
    function updateMenus(){   
        if(localStorage.getItem("user") || false){
            const userRole = JSON.parse(localStorage.getItem("user") || false).role
            if(userRole == "admin"){
                menus.value = (adminData)
            }else if(userRole == "manager"){
                menus.value = (managerData)
            }else{
                menus.value = (userData)
            }
        }
    }
    const currentPage = ref("dashboard")
    function activate(menu){
        menus.value.forEach(menugroup => {
            menugroup.children.forEach(element => {
                element.active = false
            });
        });
        menu.active = true
        currentPage.value = menu.name
        console.log(menu.name)
    }
    return { updateMenus, active, menus, currentPage, activate }
})
