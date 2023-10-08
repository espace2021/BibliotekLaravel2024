<template>
    <div>
      <form @submit.prevent="ajouterproduit">
       
       <div class="form-group">
       <input type="text" class="form-control" placeholder="isbn" v-model="livre.isbn" require >
     </div>
     <div class="form-group">
       <input type="text" class="form-control" placeholder="titre" v-model="livre.titre" require>
     </div>
     <div class="form-group">
       <input type="number" class="form-control" placeholder="annedition" v-model="livre.annedition">
     </div>
    <div class="form-group">
       <input type="number" class="form-control" placeholder="prix" v-model="livre.prix">
     </div>
    <div class="form-group">
       <input type="number" class="form-control" placeholder="qtestock" v-model="livre.qtestock">
     </div>
    <div class="form-group">
       Spécialité<select class="form-control" v-model="livre.specialite_id">
          <option v-for="sc in Specialites" :key="sc.id" :value=sc.id>{{sc.nomspecialite}}</option>
       </select>  
       </div>
       <div class="form-group">
       Edition <select class="form-control" v-model="livre.editeur_id">
          <option v-for="ed in Editeurs" :key="ed.id" :value=ed.id>{{ed.maisonedit}}</option>
       </select>  
       </div>
       <div class="form-group">
       Auteurs <select class="form-control" v-model="livre.auteur_ids" multiple>
          <option v-for="aut in Auteurs" :key="aut.id" :value=aut.id>{{aut.nomauteur}}</option>
       </select>  
       </div>
        <!-- FilePond pour le téléchargement d'images -->
        <div class="form-group">
          <div>
            
            <file-pond
              name="test"
              ref="pond"
              class-name="my-pond"
              label-idle="Drop files here..."
              allow-multiple="false"
              accepted-file-types="image/jpeg, image/png"
              v-bind:files="myFiles"
              v-on:init="handleFilePondInit"
              :server="serverOptions()"
            />
  
          </div>
        </div>
  
        <button type="submit" class="btn btn-block btn-primary">Ajouter Produit</button>
      </form>
    </div>
  </template>
  
  <script setup>
  /*
  En utilisant le préfixe : (liaison dynamique), vous indiquez à Vue.js 
  d'évaluer la valeur de la propriété serverOptions comme une expression JavaScript plutôt que de considérer 
  "serverOptions" comme une URL. Cela devrait résoudre l'erreur "405 (Method Not Allowed)" 
  Avec () après serverOptions on appelle réellement la fonction serverOptions pour obtenir les options du serveur 
  au lieu de simplement passer la référence de la fonction. 
  */
  import { ref, onMounted } from 'vue';
  
  import vueFilePond from 'vue-filepond';
  import 'filepond/dist/filepond.min.css';
  import FilePondPluginImagePreview from 'filepond-plugin-image-preview';
  import 'filepond-plugin-image-preview/dist/filepond-plugin-image-preview.min.css';
  
  // Create FilePond component
  const FilePond = vueFilePond(FilePondPluginImagePreview);
  
  const myFiles = ref([]);
  
  import axios from "../config/axios.js";
  import { useRouter } from 'vue-router';
  
  const router = useRouter();
  
  const Specialites = ref([]);
  
  const getSpecialites = () => {
    axios.get('/api/specialites')
      .then(res => {
        Specialites.value = res.data;
      })
      .catch(error => {
        console.log(error);
      });
  }
  
  const Editeurs = ref([]);
  
  const getEditeurs = () => {
    axios.get('/api/editeurs')
      .then(res => {
        Editeurs.value = res.data;
      })
      .catch(error => {
        console.log(error);
      });
  }

  const Auteurs = ref([]);
  
  const getAuteurs = () => {
    axios.get('/api/auteurs')
      .then(res => {
        Auteurs.value = res.data;
      })
      .catch(error => {
        console.log(error);
      });
  }
  onMounted(() => {
    getSpecialites();
    getEditeurs();
    getAuteurs();
  });
  
  const livre = {
    isbn: "",
    titre: "",
    annedition: "",
    prix: "",
    qtestock: "",
    couverture: "",
    specialite_id: "",
    editeur_id : "",
    auteur_ids:[]
  };
  
  const  ajouterproduit=()=>{
     console.log(livre)
     axios.post("/api/livres",livre)
          .then(() => {
                router.push('/livres')})
          .catch(error => {
             console.error("There was an error!", error); alert("There was an error!")})
             }
  
  
  const handleFilePondInit = () => {
    console.log('FilePond has initialized');
  }
  
  const serverOptions = () => { console.log('server pond');
    return {
      process: (fieldName, file, metadata, load, error, progress, abort) => {
        const data = new FormData();
        
        data.append('file', file);
        data.append('upload_preset', 'Ecommerce_cloudinary');
        data.append('cloud_name', 'iset-sfax');
        data.append('public_id', file.name);
  
        axios.post('https://api.cloudinary.com/v1_1/iset-sfax/image/upload', data)
          .then((response) => response.data)
          .then((data) => {
            console.log(data);
            livre.couverture = data.url;
            load(data);
          })
          .catch((error) => {
            console.error('Error uploading file:', error);
            error('Upload failed');
            abort();
          });
      },
    };
  };
  
  </script>
  