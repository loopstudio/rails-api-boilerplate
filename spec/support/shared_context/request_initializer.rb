shared_context 'request initializer' do
  subject { response }

  before { |example| request! unless example.metadata[:skip_request] }
end
