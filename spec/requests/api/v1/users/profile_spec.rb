describe 'GET api/v1/users/profile', type: :request do
  subject do
    get profile_api_v1_users_path, headers: headers, as: :json
    response
  end

  let(:user) { create(:user) }
  let(:headers) {}

  include_examples 'not signed in examples'

  context 'when the user is signed in' do
    let(:headers) { auth_headers(user) }

    it { is_expected.to have_http_status(:success) }

    it "returns the logged in user's data" do
      expect(json(subject)).to eq(
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        created_at: user.created_at.as_json,
        updated_at: user.updated_at.as_json
      )
    end
  end
end
