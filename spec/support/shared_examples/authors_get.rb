shared_examples 'authors listing' do
  describe 'GET /api/v1/authors' do
    before { get '/api/v1/authors' }

    it 'returns authors' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/authors/:id' do
    before { get "/api/v1/authors/#{author_id}" }

    context 'when the record exists' do
      it 'returns the author' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(author_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:author_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Not found/)
      end
    end
  end
end
