import request from '@/api/request';

export const getCommunities = (params: Object = {}) => request.get('/communities', params);

export const getCommunity = (id: number) => request.get(`/communities/${id}`);
