<template>
  <v-navigation-drawer permanent>
    <v-list-item>
      <v-list-item-content>
        <v-list-item-title class="text-h6"> Holder </v-list-item-title>
        <v-list-item-subtitle> Keep And Share Your Record </v-list-item-subtitle>
      </v-list-item-content>
    </v-list-item>

    <v-divider></v-divider>

    <v-list nav>
      <v-list-item v-for="item in items" :key="item.title" link>
        <v-list-item-content>
          <v-list-item-title>{{ item.title }}</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script lang="ts">
import { Vue } from 'vue-class-component';

export default class NavigationDrawer extends Vue {
  items = [
    { icon: 'mdi-home', title: 'Home' },
    { icon: 'mdi-account', title: 'Profile' },
    { icon: 'mdi-email', title: 'Messages' },
    { icon: 'mdi-heart', title: 'Favorites' },
    { icon: 'mdi-settings', title: 'Settings' },
  ];
}
</script>
