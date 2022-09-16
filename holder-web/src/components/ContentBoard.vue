<template>
  <div>
    <div class="d-flex justify-center mb-6 text-caption">
      Today is {{ $filters.formatDate(today) }}
    </div>
    <v-container>
      <router-view />
    </v-container>
  </div>
</template>

<script lang="ts">
import { useStore } from 'vuex';
import type { Ref } from 'vue';
import { useRoute } from 'vue-router';
import {
  watch,
  ref,
} from 'vue';

export default {
  setup() {
    const today: Ref<Date> = ref(new Date());

    const store = useStore();
    const route = useRoute();

    const fetchPostById = (id: number) => store.dispatch('post/fetchPostsByCommunityId', id);
    watch(route, async () => {
      if (route.name === 'post-detail') {
        await fetchPostById(Number(route.params.id));
      }
    });

    return {
      today,
    };
  },
};
</script>
