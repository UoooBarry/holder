import { createApp } from 'vue';
import filters from '@/filters';
import App from './App.vue';
import router from './router';
import vuetify from './plugins/vuetify';
import { loadFonts } from './plugins/webfontloader';
import store from './store';

loadFonts();

const app = createApp(App).use(store);

app.use(router);
app.use(vuetify);
app.config.globalProperties.$filters = filters;
app.mount('#app');

export default app;
