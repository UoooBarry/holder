<template>
  <v-app>
    <v-main>
      <NavigationDrawer />
      <ContentBoard />
    </v-main>
  </v-app>
</template>

<script lang="ts">
import NavigationDrawer from '@/components/NavigationDrawer.vue';
import ContentBoard from '@/components/ContentBoard.vue';

export default {
  name: 'App',
  components: {
    NavigationDrawer,
    ContentBoard,
  },
};
</script>
