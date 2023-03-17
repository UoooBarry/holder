import type { Post } from '@/types/post.type';
import { getPosts, getPost } from '@/api/posts.api';
import type { Commit } from 'vuex';

export interface State {
  posts: Array<Post>;
  currentPost: Post;
  isLoading: boolean;
}

const defaultState = {
  posts: [],
  isLoading: false,
  currentPost: {},
};

const getters = {
  posts: (state: State) => state.posts,
  currentPost: (state: State) => state.currentPost,
};

const actions = {
  async fetchPosts({ commit }: { commit: Commit }): Promise<void> {
    commit('setLoading', true);
    const { posts } = await getPosts();

    commit('setPosts', posts);
    commit('setLoading', false);
  },
  async fetchPostsByCommunityId(
    { commit }: { commit: Commit },
    communityId: number,
  ): Promise<void> {
    commit('setLoading', true);
    const { posts } = await getPosts({ community_id: communityId });

    commit('setPosts', posts);
    commit('setLoading', false);
  },
  async fetchPostById({ commit }: { commit: Commit }, postId: number): Promise<void> {
    commit('setLoading', true);
    const { post } = await getPost(postId);

    commit('setCurrentPost', post);
    commit('setLoading', false);
  },
};

const mutations = {
  setPosts(state: State, posts: Array<Post>) {
    state.posts = posts;
  },
  setLoading(state: State, isLoading: boolean) {
    state.isLoading = isLoading;
  },
  setCurrentPost(state: State, post: Post) {
    state.currentPost = post;
  },
};

export default {
  state: defaultState,
  namespaced: true,
  getters,
  actions,
  mutations,
};
