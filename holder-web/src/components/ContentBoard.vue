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
import { Vue } from 'vue-class-component';

export default class ContentBoard extends Vue {
  today: Date = new Date();
}
</script>
