<template>
    <div>
        <router-link :to="{name: 'addLivre'}" class="btn btn-primary">Ajout Livre</router-link>
        <h2 class="text-center"> Liste des livres </h2>
 
        <table class="table" id="example">
            <thead>
            <tr>
          <th>isbn</th>  
          <th>Titre</th>  
          <th>Année</th>  
          <th>Prix</th>
          <th>Quantité</th> 
          <th>Couverture</th> 
          <th>Spécialité</th>
          <th>Editeur</th>
          <th>Auteurs</th>
          <th>Actions</th>
        </tr>
            </thead>
            <tbody>
            <tr v-for="l in Livres" :key="l.id">
                <td>{{l.isbn}}</td>  
                <td>{{l.titre}}</td>  
                <td>{{l.annedition}}</td> 
                <td>{{l.prix}}</td>
                <td>{{l.qtestock}}</td>
                <td><img :src="l.couverture" :alt=l.titre width="120" /></td>
                <td>{{l.specialite.nomspecialite}}</td>
                <td>{{l.editeur.maisonedit}}</td>
                <td>
                    <div v-for="a in l.auteurs" :key="a.id">
                    {{a.nomauteur}}
                  </div>
                </td>
                <td>
                    <button @click.prevent="deleteLivre(l.id)" class="btn btn-danger">Supprimer</button></td>
            </tr>
            </tbody>
        </table>
    </div>
</template>
 
<script setup>
import axios from "../config/axios.js";



//Bootstrap and jQuery libraries
import 'bootstrap/dist/css/bootstrap.min.css';
import 'jquery/dist/jquery.min.js';
//Datatable Modules
import "datatables.net-dt/js/dataTables.dataTables"
import "datatables.net-dt/css/jquery.dataTables.min.css"

import $ from 'jquery'

import { ref, onMounted } from 'vue';

const Livres = ref([]);

 onMounted(() => {
            getLivres();
            }
);

const getLivres=()=>{
                  axios
                .get('/api/livres/')
                .then(response => { 
                                 Livres.value = response.data;
                                 $(function() {$('#example').DataTable();});
                });   
            }

const deleteLivre=(id)=> { 
                 if (window.confirm("Etes-vous sûr de vouloir supprimer ?")) {
                   axios
                    .delete(`/api/livres/${id}`)
                    .then(() => {
                        let i = Livres.value.map(data => data.id).indexOf(id);
                        Livres.value.splice(i, 1)
                    })
                    .catch(error => {
                                console.log(error)
                            });
                 }         
            }
            
</script>
