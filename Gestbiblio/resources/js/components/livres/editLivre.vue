<template>
    <div>
      <form @submit.prevent="modifierlivre">
       
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
          <option v-for="aut in Auteurs" :key="aut.id" :value=aut.id :class="{ optionExist: selectOne(aut.id) }">{{aut.nomauteur}}</option>
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
              :server="serverOptions()"

            />
  
          </div>
        </div>
  
        <button type="submit" class="btn btn-block btn-primary">Modifier Produit</button>
      </form>
    </div>
  </template>
  
  <script setup>

  import { ref, onMounted } from 'vue';
  
  import vueFilePond from 'vue-filepond';
  import 'filepond/dist/filepond.min.css';
  import FilePondPluginImagePreview from 'filepond-plugin-image-preview';
  import 'filepond-plugin-image-preview/dist/filepond-plugin-image-preview.min.css';
  
  const FilePond = vueFilePond(FilePondPluginImagePreview);
  
  import axios from "../config/axios.js";

  import { useRouter,useRoute } from 'vue-router';
    const router = useRouter() ;
    const route = useRoute();
  
    const Specialites = ref([]);
  
  const getSpecialites = async() => {
    await axios.get('/api/specialites')
      .then(res => {
        Specialites.value = res.data;
         })
      .catch(error => {
        console.log(error);
      });
  }
  
  const Editeurs = ref([]);
  
  const getEditeurs = async () => {
    await axios.get('/api/editeurs')
      .then(res => {
        Editeurs.value = res.data;
      })
      .catch(error => {
        console.log(error);
      });
  }

  const Auteurs = ref([]);
  
  const getAuteurs = async () => {
    await axios.get('/api/auteurs')
      .then(res => {
        Auteurs.value = res.data;
      })
      .catch(error => {
        console.log(error);
      });
  }
  
const livre = ref({
    isbn: "",
    titre: "",
    annedition: "",
    prix: "",
    qtestock: "",
    couverture: "",
    specialite_id: "",
    editeur_id : "",
    auteur_ids:[]
});

const fetchLivre= async()=> {
  
        await axios
                .get(`/api/livres/${route.params.id}`)
                .then((res) => {
                    livre.value = res.data;
                     // Remplir livre.auteur_ids avec les ID des auteurs associés au livre
                     livre.value.auteur_ids = res.data.auteurs.map((auteur) => auteur.id); 
                })
                .catch((err) => {console.error(err)})  
     
    }

let  myFiles = ref([]);

  
  onMounted(async() => {
   await getSpecialites();
   await  getEditeurs();
   await  getAuteurs();
   await fetchLivre();
   await handleFilePondInit();
  });
  
   
   
  const handleFilePondInit = async() => {
     
  if (livre.value.couverture) {
  
    myFiles.value = [
  {
    source: livre.value.couverture,
    options: { type: 'local' }
  }
  ]
 }
  }
  
  const serverOptions = () => { 
    return {
        load: (source, load, error, progress, abort, headers) => {
                    var myRequest = new Request(source);
                    fetch(myRequest).then(function(response) {
                      response.blob().then(function(myBlob) {
                        load(myBlob);
                      });
                    });
                  },
      process: (fieldName, file, metadata, load, error, progress, abort) => {
        const data = new FormData();
        
        data.append('file', file);
        data.append('upload_preset', 'Ecommerce_cloudinary');
        data.append('cloud_name', 'iset-sfax');
        data.append('public_id', file.name);
  
        axios.post('https://api.cloudinary.com/v1_1/iset-sfax/image/upload', data)
          .then((response) => response.data)
          .then((data) => {
             livre.value.couverture = data.url;
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
  
  const  modifierlivre=()=>{
     console.log(livre.value)
     axios.put(`/api/livres/${route.params.id}`,livre.value)
          .then(() => {
                router.push('/livres')})
          .catch(error => {
             console.error("There was an error!", error);
             alert("There was an error!")
            })
}

const selectOne = (autId) => {
  if (livre.value.auteurs) {
    /* some renvoie vrai si, dans le tableau, 
    il trouve un élément pour lequel la fonction fournie renvoie vrai ; 
    sinon, il renvoie faux.
    */
    return livre.value.auteurs.some((auteur) => auteur.id === autId);
  } else {
    return false; 
  }
};


  </script>
<style scoped>
.optionExist {
  background-color: yellow; 
}
</style>