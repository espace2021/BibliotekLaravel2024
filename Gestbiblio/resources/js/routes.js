import Accueil from './components/accueil.vue';
import ViewLivres from './components/livres/viewlivres.vue';
import AddLivre from "./components/livres/addLivre.vue";

export const routes = [
    {
        name: 'accueil',
        path: '/',
        component: Accueil
    },
    {
        name: 'viewLivres',
        path: '/livres',
        component: ViewLivres
    },
    {
        path: '/addLivre',
        name: 'addLivre',
        component: AddLivre
    },

];
