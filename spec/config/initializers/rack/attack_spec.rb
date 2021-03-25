require 'securerandom'

describe Rack::Attack, type: :request do
  subject(:request!) do
    post user_session_path, params: params, headers: headers, as: :json
  end

  let(:limit) { 5 }

  describe 'throttle excessive requests by email address' do
    let(:params) do
      {
        user: {
          email: 'wrong@email.com',
          password: 'wrong_password'
        }
      }
    end

    let(:headers) { {} }

    context 'when the number of requests is lower than the limit' do
      specify do
        within_limit_request do
          expect(response).not_to have_http_status(:too_many_requests)
        end
      end
    end

    context 'when the number of requests is higher than the limit' do
      specify do
        exceed_limit_request do
          expect(response).to have_http_status(:too_many_requests)
        end
      end

      specify do
        exceed_limit_request do
          expect(json[:errors]).to include('Throttle limit reached')
        end
      end
    end

    describe 'throttle excessive requests by IP address' do
      let(:params) do
        {
          user: {
            email: "wrong+#{SecureRandom.hex(5)}@email.com",
            password: 'wrong_password'
          }
        }
      end

      let(:headers) { { REMOTE_ADDR: '1.2.3.4' } }

      context 'when the number of requests is lower than the limit' do
        specify do
          within_limit_request do
            expect(response).not_to have_http_status(:too_many_requests)
          end
        end
      end

      context 'when the number of requests is higher than the limit' do
        specify do
          exceed_limit_request do
            expect(response).to have_http_status(:too_many_requests)
          end
        end

        specify do
          exceed_limit_request do
            expect(json[:errors]).to include('Throttle limit reached')
          end
        end
      end
    end

    def exceed_limit_request
      (limit + 1).times do |req_amount|
        request!

        yield if req_amount > limit
      end
    end

    def within_limit_request
      limit.times do
        request!

        yield
      end
    end
  end
end
