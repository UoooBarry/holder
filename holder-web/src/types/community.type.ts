/* eslint-disable camelcase */
export interface Community {
  id: number;
  name: string;
  description: string;
  created_at: string;
  updated_at: string;
  creator_id: number;
  subscribe_at: string | undefined;
}
