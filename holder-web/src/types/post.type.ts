/* eslint-disable camelcase */
export interface Post {
  id: number;
  community_id: number;
  title: string;
  content: string;
  status: string;
  pin: boolean;
  comments: Array<Post>;
  created_at: string;
  updated_at: string;
  creator_id: number;
  subscribe_at: string | undefined;
  user: Object;
}
