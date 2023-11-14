<script setup></script>
<template>
    <table>
        <caption>Team</caption>
        <thead>
            <tr>
                <th scope="col">Full Name</th>
                <th scope="col">Username</th>
                <th scope="col">Email</th>
                <th scope="col">Role</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td data-label="Full Name">ISAC NEWTON</td>
                <td data-label="Username">nisac</td>
                <td data-label="Email">nisac@gmail.com</td>
                <td data-label="Role">Manager</td>
            </tr>
            <tr>
                <td data-label="Full Name">ISAC NEWTON</td>
                <td data-label="Username">nisac</td>
                <td data-label="Email">nisac@gmail.com</td>
                <td data-label="Role">Manager</td>
            </tr>
        </tbody>
        </table>
</template>
<style scoped>
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
    tr:nth-of-type(n+1){
        background-color: #00000000;
    }
    tr:nth-of-type(n+2){
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