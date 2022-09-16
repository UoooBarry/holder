import request from '@/api/request';

export const getCommunities = (params: any = {}) => request.get('/communities', params);

export const getCommunity = (id: number) => request.get(`/communities/${id}`);
