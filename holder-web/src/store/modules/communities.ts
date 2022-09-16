import { getCommunities } from '@/api/communities.api';
import type { Community } from '@/types/community.type';

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
  async fetchCommunities({ commit }: any): Promise<void> {
    commit('setLoading', true);
    const { communities }: any = await getCommunities();

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
