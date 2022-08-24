require 'swagger_helper'

RSpec.describe 'api/auth', type: :request do
  before(:example) do
    @user ||= User.find_or_initialize_by(username: 'test')
    @user.update!(email: 'test@gmail.com', password: '1234567a')
  end

  path '/api/auth/login' do
    post 'login' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string }
        },
        required: %w[username password]
      }

      response '200', 'Login success' do
        let(:params) do
          {
            username: @user.username,
            password: @user.password
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

      response '401', 'Information provided is not correct' do
        let(:params) do
          {
            username: 'unexsits',
            password: 'incorrect'
          }
        end

        run_test!
      end
    end
  end

  path '/api/auth/refresh' do
    post 'refresh' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          refresh_token: { type: :string }
        },
        required: %w[refresh_token]
      }

      response '200', 'Refresh success' do
        let(:params) do
          {
            refresh_token: @user.refresh_tokens.create!.token
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

  path '/api/auth/logout' do
    post 'logout' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer token'

      response '200', 'logout success' do
        let(:Authorization) { "Bearer #{@user.to_token[0]}" }

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
