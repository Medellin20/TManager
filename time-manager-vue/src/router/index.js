
import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginView from '../views/LoginView.vue'
import SignupView from '../views/SignupView.vue'
import DashboardView from '../views/DashboardView.vue'
import { useAuthUserStore } from '@/stores/authUser'
import { drawerStore } from '@/stores/drawerState.js'


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: LoginView,
      beforeEnter: (to, from) => {
        const user = useAuthUserStore()
        if(user.user){
          return {name : "dashboard"}
        }
        return {name: "login"}
      },
    },
    {
      path: '/login',
      name: 'login',
      component: LoginView,
      beforeEnter: (to, from) => {
        const user = useAuthUserStore()
        if(user.user){
          return {name : "dashboard"}
        }
        return true
      },
    },
    {
      path: '/signup',
      name: 'signup',
      component: SignupView,
      beforeEnter: (to, from) => {
        const user = useAuthUserStore()
        if(user.user){
          return {name : "dashboard"}
        }
        return true
      },
    },
    {
      path: '/dashboard',
      name: 'dashboard',
      component: DashboardView,
      beforeEnter: () => {
        const user = useAuthUserStore()
        if(!user.user){
          console.log(user.user)
          return { name: 'login' }
        }
      },
      children:[
        {
          path: '',
          component: () => import("../views/user/WorkReport.vue")
        },
        {
          path: "profile",
          name: "profile",
          component: () => import("../views/user/ProfileView.vue"),
          beforeEnter: (from, to) => {
            const drawer = drawerStore()
            drawer.currentPage = "profile"
          }
        },
        {
          path: "report",
          name: "report",
          component: () => import("../views/user/WorkReport.vue")
        },
        {
          path: "teams",
          name: "teams",
          component: () => import("../views/manager/ResponsiveTable.vue")
        },{
          path: "admin",
          name: "admin",
          beforeEnter: () => {
            const user = useAuthUserStore()
            if(user.user.role !== "admin" ){
              console.log(user.user)
              return { name: 'login' }
            }
          },
          children:[
            {
              path: "employees",
              name: "employees",
              component: () => import("../views/admin/EmployeesView.vue")
            },
            {
              path: "new_user",
              name: "new_user",
              component: () => import("../views/admin/NewUser.vue")
            },
            {
              path: "user/:id/report",
              name: "user_report",
              component: () => import("../views/admin/UserReport.vue")
            }
          ]
        }
      ]
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/AboutView.vue')
    }
  ],
  // beforeEach: (to, from) => {
  //   if(!user.user && to.name !== "login"){
  //     return { name: 'login' }
  //   }
  // }
})
router.beforeEach(async (to, from) => {
  const user = useAuthUserStore()
  const drawer = drawerStore()
  drawer.updateMenus()
  if(!user.user && to.name == "dashboard"){
    console.log(user.user)
    return { name: 'login' }
  }
})

export default router
