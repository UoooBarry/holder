require 'swagger_helper'

RSpec.describe 'api/communities', type: :request do
  let!(:community) { create(:community) }
  let!(:user) { create(:user) }

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
end
