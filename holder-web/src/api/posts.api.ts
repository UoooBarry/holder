import request from '@/api/request';

export const getPosts = (params: Object = {}) => request.get('/posts', params);

export const getPost = (id: number) => request.get(`/posts/${id}`);
