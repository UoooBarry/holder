import type { Community } from '@/types/community.type';
import type { Commit } from 'vuex';

export interface State {
  menus: Array<Community> | Array<any>;
  isLoading: boolean;
  currentList: 'community' | 'post' | 'posts';
}

const defaultState = {
  menus: [],
  isLoading: false,
  currentList: 'community',
};

const getters = {
  menus: (state: State) => state.menus,
  isLoading: (state: State) => state.isLoading,
  currentList: (state: State) => state.currentList,
};

const actions = {
  setMenus({ commit }: { commit: Commit }, menus: Array<Community>): void {
    commit('setLoading', true);
    commit('setMenus', menus);
    commit('setLoading', false);
  },
  setCurrentList({ commit }: { commit: Commit }, currentList: 'community' | 'post' | 'posts'): void {
    commit('setCurrentList', currentList);
  },
};

const mutations = {
  setMenus(state: State, menus: Array<Community> | Array<any>) {
    state.menus = menus;
  },
  setLoading(state: State, isLoading: boolean) {
    state.isLoading = isLoading;
  },
  setCurrentList(state: State, currentList: 'community' | 'post' | 'posts') {
    state.currentList = currentList;
  },
};

export default {
  state: defaultState,
  namespaced: true,
  getters,
  actions,
  mutations,
};
