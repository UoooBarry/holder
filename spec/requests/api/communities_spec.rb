require 'swagger_helper'

RSpec.describe 'api/communities', type: :request do
  let!(:community) { create(:community) }
  let!(:user) { create(:user) }
  let!(:second_user) { create(:user, :second) }

  path '/api/communities' do
    get 'index' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :page, in: :query, type: :integer, default: 1
      parameter name: :per_page, in: :query, type: :integer, default: 10

      response '200', 'List communities' do
        let(:page) { 1 }
        let(:per_page) { 10 }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end

    post 'create' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', in: :header, type: :string, required: false, description: 'Bearer token'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        },
        required: %w[name]
      }

      response '200', 'Show community' do
        let(:Authorization) { "Bearer #{user.to_token[0]}" }

        let(:params) do
          {
            name: 'new community',
            description: 'welcome!'
          }
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end

  path '/api/communities/{id}' do
    get 'show' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: 'Authorization', in: :header, type: :string, required: false, description: 'Bearer token'

      response '200', 'Show community' do
        let(:id) { community.id }
        let(:Authorization) { "Bearer #{user.to_token[0]}" }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end

  path '/api/communities/{id}/set_admin' do
    post 'set an user to admin' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :id, in: :path, type: :string
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer token'

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :string }
        },
        required: %w[user_id]
      }

      response '200', 'Admin pin a post' do
        let(:id) { community.id }
        let(:Authorization) { "Bearer #{user.to_token[0]}" }
        let(:params) do
          {
            user_id: second_user.id
          }
        end

        before do
          community.admin!(user)
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end

      response '403', 'An user is not an admin' do
        let(:id) { community.id }
        let(:Authorization) { "Bearer #{user.to_token[0]}" }
        let(:params) do
          {
            user_id: second_user.id
          }
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end

  path '/api/communities/{id}/subscribe' do
    post 'subscribe' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer token'

      response '200', 'Subscribe to community' do
        let(:id) { community.id }
        let(:Authorization) { "Bearer #{user.to_token[0]}" }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end

  path '/api/communities/{id}/unsubscribe' do
    post 'unsubscribe' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer token'

      response '200', 'Subscribe to community' do
        let(:id) { community.id }
        let(:Authorization) { "Bearer #{user.to_token[0]}" }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end
end
