/* eslint-disable */
declare module '*.vue' {
  import type { DefineComponent } from 'vue'
  const component: DefineComponent<{}, {}, any>
  export default component
}

// declare module '@vue/runtime-core' {
//   interface ComponentCustomProperties {
//     $filters: Object;
//     $lang: Record<string, 'cs' | 'en'>;
//     $toggleLang: () => void;
//     $t: (cs: string, en: string) => string;
//   }
// }
