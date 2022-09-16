<template>
  <v-progress-linear indeterminate="true" v-if="isLoading"></v-progress-linear>
  <div v-else>
    <div class="text-h3">{{ post.title }}</div>
    <div class="text-subtitle-2 mb-6" v-if="post.user">
      {{ post.user.username }}
      {{ $filters.formatDate(post.created_at) }}
    </div>
    <div class="text-body-1">
      {{ post.content }}
    </div>
  </div>
</template>

<script lang="ts">
import { useStore } from 'vuex';
import {
  computed, watch, onMounted,
} from 'vue';
import { useRoute } from 'vue-router';

export default {
  setup() {
    const store = useStore();
    const route = useRoute();

    const post = computed(() => store.getters['post/currentPost']);
    const isLoading = computed(() => store.getters['post/isLoading']);

    const updatePost = async () => {
      const fetchPostById = (id: number) => store.dispatch('post/fetchPostById', id);

      await fetchPostById(Number(route.params.id));
    };

    watch(route, updatePost);
    onMounted(updatePost);

    return {
      post,
      isLoading,
    };
  },
};
</script>
