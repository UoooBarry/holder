import axios from 'axios';
import type { AxiosInstance } from 'axios';

const service: AxiosInstance = axios.create({
  baseURL: process.env.VUE_APP_BASE_API, // url = base url + request url
  withCredentials: true, // send cookies when cross-domain requests
  timeout: 90 * 1000, // request timeout
});

service.defaults.headers.common['Content-Type'] = 'application/json;charset=utf-8';

const errorStatusHandler = (error: any) => {
  switch (error.response.data.meta.status) {
    case 403:
      // router.push('/login');
      break;
    default:
    // Vue.prototype.$store.dispatch('showErrorToast', error.response.data.meta.msg);
  }
};

// response interceptor
service.interceptors.response.use(
  (response: any) => response.data.payload,

  (error: any) => {
    errorStatusHandler(error);

    return Promise.reject(error);
  },
);

export default service;
