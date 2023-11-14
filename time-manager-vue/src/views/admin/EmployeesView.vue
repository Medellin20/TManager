<script setup>
    import { ref } from 'vue';
    import { useAuthUserStore } from '@/stores/authUser'
    import { useApiRouteStore } from '@/stores/apiRoute'
    import { useAdminStore } from '@/stores/adminStore'
    import { RouterLink } from 'vue-router';

    const user = useAuthUserStore()
    const apiroute = useApiRouteStore()
    const adminstore = useAdminStore()

    const users = ref(adminstore.users)
    adminstore.getUsers().then(() => {
        users.value = adminstore.users
    })
</script>
<template>
    <table>
        <caption>Employees</caption>
        <thead>
            <tr>
                <th scope="col">Full Name</th>
                <th scope="col">Username</th>
                <th scope="col">Email</th>
                <th scope="col">Role</th>
                <th scope="col">#</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="user in users.reverse()">
                <td data-label="Full Name">{{ user.fullname }}</td>
                <td data-label="Username">{{ user.username }}</td>
                <td data-label="Email">{{ user.email }}</td>
                <td data-label="Role">{{ user.role }}</td>
                <td data-label="actions">
                    <div class="option-menu-btn">
                        <i class="fa-solid fa-caret-down"></i>
                        <div class="option-menu">
                            <ul>
                                <li>
                                    <RouterLink :to="'/dashboard/admin/user/'+user.id+'/report'">Report</RouterLink>
                                </li>
                                <li @click="adminstore.deleteUser(user.id)">Delete</li>
                                <li @click="adminstore.toggleUserRole(user.id)">Set as manager</li>
                            </ul>
                        </div>
                    </div>
                </td>
            </tr>
        </tbody>
        </table>
        <RouterLink to="/dashboard/admin/new_user" >
            <button style="margin-top: 30px;" class="std-btn">Add Employee</button>
        </RouterLink>
        
</template>
<style scoped>
    .option-menu-btn{
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        height: 40px;
        width: 40px;
        background-color: #2c133880;
        border-radius: 50%;
        position: relative;
    }
    .option-menu-btn:hover .option-menu{
        display: block;
        z-index: 2;
    }
    ul{
        list-style: none;
    }
    .option-menu{
        box-shadow: 0px 0px 5px #898989;
        position: absolute;
        top: 0px;
        left: 0px;
        display: none;
    }
    .option-menu li{
        height: 50px;
        width: 200px;
        background-color: #ffffff;
        display: flex;
        justify-content: flex-start;
        padding-left: 10px;
        align-items: center;
    }
    table {
    border-collapse: collapse;
    margin: 0;
    padding: 0;
    width: 100%;
    table-layout: fixed;
    }

    table caption {
    font-size: 1.5em;
    margin: .5em 0 .75em;
    }

    table tr {
    background-color: #f8f8f8;
    padding: .35em;
    }

    th{
        background-color: #2c1338;
        color: #ffffff;
    }
    tr{
        font-weight: 200;
    }
    tr:nth-of-type(odd){
        background-color: #00000000;
    }
    tr:nth-of-type(even){
        background-color: #2c13382a;
    }
    table th,
    table td {
    padding: .625em;
    text-align: center;
    }

    table th {
    font-size: .85em;
    letter-spacing: .1em;
    text-transform: uppercase;
    }

    @media screen and (max-width: 600px) {
    table {
        border: 0;
    }

    table caption {
        font-size: 1.3em;
    }
    
    table thead {
        border: none;
        clip: rect(0 0 0 0);
        height: 1px;
        margin: -1px;
        overflow: hidden;
        padding: 0;
        position: absolute;
        width: 1px;
    }
    
    table tr {
        border-bottom: 3px solid #ddd;
        display: block;
        margin-bottom: .625em;
    }
    
    table td {
        border-bottom: 1px solid #ddd;
        display: block;
        font-size: .8em;
        text-align: right;
    }
    
    table td::before {
        /*
        * aria-label has no advantage, it won't be read inside a table
        content: attr(aria-label);
        */
        content: attr(data-label);
        float: left;
        font-weight: bold;
        text-transform: uppercase;
    }
    
    table td:last-child {
        border-bottom: 0;
    }
    }
</style>