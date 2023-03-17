import { getCommunities } from '@/api/communities.api';
import type { Community } from '@/types/community.type';
import type { Commit } from 'vuex';

export interface State {
  communities: Array<Community>;
  isLoading: boolean;
}

const defaultState = {
  communities: [],
  isLoading: false,
};

const getters = {
  communities: (state: State) => state.communities,
};

const actions = {
  async fetchCommunities({ commit }: { commit: Commit }): Promise<void> {
    commit('setLoading', true);
    const { communities } = await getCommunities();

    commit('setCommunities', communities);
    commit('setLoading', false);
  },
};

const mutations = {
  setCommunities(state: State, communities: Array<Community>) {
    state.communities = communities;
  },
  setLoading(state: State, isLoading: boolean) {
    state.isLoading = isLoading;
  },
};

export default {
  state: defaultState,
  namespaced: true,
  getters,
  actions,
  mutations,
};
