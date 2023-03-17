<template>
  <v-navigation-drawer permanent>
    <v-list-item>
      <v-list-item-content>
        <v-list-item-title class="text-h5"> Holder </v-list-item-title>
        <v-list-item-subtitle> Keep And Share Your Record </v-list-item-subtitle>
      </v-list-item-content>
    </v-list-item>

    <v-divider></v-divider>
    <v-list nav>
      <v-list-item v-for="menu in menus" :key="menu.id" @click="router.push(menu.to)" link>
        <v-list-item-content>
          <v-list-item-title class="text-body-2">
            {{ menu.name }}
          </v-list-item-title>
          <v-list-item-title class="text-caption">
            {{ menu.description }}
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script lang="ts">
import { useStore } from 'vuex';
import {
  computed, watch,
} from 'vue';
import type { ComputedRef } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import type { Post } from '@/types/post.type';
import type { Community } from '../types/community.type';
import type { Menu } from '../types/menu.type';

export default {
  setup() {
    const name = 'NavigationDrawer';

    const store = useStore();
    const route = useRoute();
    const router = useRouter();

    const communities: ComputedRef<Array<Community>> = computed(
      () => store.getters['community/communities'],
    );
    const menus = computed(() => store.getters['menu/menus']);
    const posts = computed(() => store.getters['post/posts']);

    const setMenus = (ms: Array<Menu>) => store.dispatch('menu/setMenus', ms);

    const fetchCommunities = () => store.dispatch('community/fetchCommunities');
    const fetchPostsByCommunityId = (communityId: number) => store.dispatch('post/fetchPostsByCommunityId', communityId);

    watch(route, async () => {
      if (route.name === 'home') {
        await fetchCommunities();

        const communityMenus: Array<Menu> = communities.value.map((community: Community) => ({
          id: community.id,
          name: community.name,
          to: `/communities/${community.id}`,
          description: undefined,
        }));

        setMenus(communityMenus);
      } else if (route.name === 'community-detail') {
        await fetchPostsByCommunityId(Number(route.params.id));
        setMenus(posts.value.map((post: Post) => ({
          id: post.id,
          name: post.title,
          to: `/posts/${post.id}`,
          description: post.content,
        })));
      }
    });

    return {
      name,
      communities,
      router,
      menus,
    };
  },
};
</script>
