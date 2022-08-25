require 'swagger_helper'

RSpec.describe 'api/posts', type: :request do
  let!(:article) { create(:post) }

  path '/api/posts' do
    get 'index' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user_id, in: :query, type: :string, required: false
      parameter name: :community_id, in: :query, type: :string, required: false
      parameter name: :page, in: :query, type: :integer, default: 1, required: false
      parameter name: :per_page, in: :query, type: :integer, default: 10, required: false
      parameter name: :q, in: :query, type: :integer, default: 10, required: false
      parameter name: 'Authorization', in: :header, type: :string, required: false, description: 'Bearer token'

      response '200', 'List posts' do
        let(:community_id) { article.community.id }
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

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          community_id: { type: :string },
          title: { type: :string },
          content: { type: :string }
        },
        required: %w[community_id title content]
      }

      parameter name: 'Authorization', in: :header, type: :string, required: false, description: 'Bearer token'

      response '200', 'Publish post' do
        let(:Authorization) { "Bearer #{article.user.to_token[0]}" }

        let(:params) do
          article.user.subscribe!(article.community)
          {
            community_id: article.community.id,
            title: 'Hello world',
            content: 'Hello world'
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

      response '400', 'Bad request' do
        let(:Authorization) { "Bearer #{article.user.to_token[0]}" }

        let(:params) do
          {
            community_id: article.community.id,
            title: 'Hello world',
            content: 'Hello world'
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

  path '/api/posts/{id}' do
    get 'show' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :id, in: :path, type: :string
      parameter name: 'Authorization', in: :header, type: :string, required: false, description: 'Bearer token'

      response '200', 'Show post' do
        let(:id) { article.id }
        let(:Authorization) { "Bearer #{article.user.to_token[0]}" }

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

    patch 'update' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :id, in: :path, type: :string
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          content: { type: :string }
        },
        required: %w[title content]
      }

      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer token'

      response '200', 'Edit post' do
        let(:id) { article.id }
        let(:Authorization) { "Bearer #{article.user.to_token[0]}" }

        let(:params) do
          {
            title: 'Hello world',
            content: 'Hello world 2'
          }
        end

        run_test!
      end
    end

    delete 'destroy' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :id, in: :path, type: :string
      parameter name: 'Authorization', in: :header, type: :string, required: false, description: 'Bearer token'
      response '200', 'Destroy a post or a comment' do
        let(:id) { article.id }
        let(:Authorization) { "Bearer #{article.user.to_token[0]}" }

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

  path '/api/posts/{id}/like' do
    post 'like' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :id, in: :path, type: :string
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer token'

      response '200', 'Like a post' do
        let(:id) { article.id }
        let(:Authorization) { "Bearer #{article.user.to_token[0]}" }

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

  path '/api/posts/{id}/pin' do
    post 'pin a post' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :id, in: :path, type: :string
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer token'

      response '200', 'Admin pin a post' do
        let(:id) { article.id }
        let(:Authorization) { "Bearer #{article.user.to_token[0]}" }

        before do
          article.community.admin!(article.user)
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
        let(:id) { article.id }
        let(:Authorization) { "Bearer #{article.user.to_token[0]}" }

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

  path '/api/posts/{id}/reply' do
    post 'reply' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :id, in: :path, type: :string
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer token'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          content: { type: :string }
        },
        required: %w[content]
      }

      response '200', 'Reply a post' do
        let(:id) { article.id }
        let(:Authorization) { "Bearer #{article.user.to_token[0]}" }

        let(:params) do
          {
            content: 'How is there?'
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
end
