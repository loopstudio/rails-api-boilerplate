describe Rack::Attack, type: :request do
  describe 'throttle excessive requests by email address' do
    subject(:post_request) do
      post user_session_path, params: params, as: :json
    end

    let(:limit) { 5 }
    let(:params) do
      {
        user: {
          email: 'wrong@email.com',
          password: 'wrong_password'
        }
      }
    end

    context 'number of requests is lower than the limit' do
      it do
        limit.times do
          post_request

          expect(response).not_to have_http_status(:too_many_requests)
        end
      end
    end

    context 'number of requests is higher than the limit' do
      it do
        (limit + 1).times do |req_amount|
          post_request

          if req_amount > limit
            expect(response).to have_http_status(:too_many_requests)
            expect(json[:errors]).to include('Throttle limit reached')
          end
        end
      end
    end
  end
end
