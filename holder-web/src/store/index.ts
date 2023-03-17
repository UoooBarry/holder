import { createStore } from 'vuex';
import CommunityStore from '@/store/modules/communities';
import MenuStore from '@/store/modules/menus';
import PostStore from '@/store/modules/posts';
import createPersistedState from 'vuex-persistedstate';

export default createStore({
  plugins: [createPersistedState()],
  state: {
  },
  getters: {
  },
  mutations: {
  },
  actions: {
  },
  modules: {
    community: CommunityStore,
    menu: MenuStore,
    post: PostStore,
  },
});
