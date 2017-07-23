# frozen_string_literal: true

RSpec.describe 'authors API', type: :request do
  let!(:authors) { create_list(:author, 10) }
  let(:author_id) { authors.first.id }

  context 'with non-admin user' do
    include_context 'logged in user'

    it_behaves_like 'authors listing'

    describe 'POST /api/v1/authors' do
      let(:valid_attributes) { { author: { name: Faker::Name.name } } }

      context 'when the request is valid' do
        before { post '/api/v1/authors', params: valid_attributes }

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end
      end

      context 'when the request is invalid' do
        before { post '/api/v1/authors', params: { author: { name: '' } } }

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end
      end
    end

    describe 'PUT /api/v1/authors/:id' do
      let(:valid_attributes) { { name: Faker::Name.name } }

      context 'when the record exists' do
        before { put "/api/v1/authors/#{author_id}", params: valid_attributes }

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end
      end
    end

    describe 'DELETE /api/v1/authors/:id' do
      before { delete "/api/v1/authors/#{author_id}" }

      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
    end
  end

  context 'with admin user' do
    include_context 'logged in admin'

    it_behaves_like 'authors listing'

    describe 'POST /api/v1/authors' do
      let(:name) { Faker::Name.name }
      let(:valid_attributes) { { author: { name: name } } }

      context 'when the request is valid' do
        before { post '/api/v1/authors', params: valid_attributes }

        it 'creates a author' do
          expect(json['name']).to eq(name)
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when the request is invalid' do
        before { post '/api/v1/authors', params: { author: { name: '' } } }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a validation failure message' do
          expect(response.body)
            .to match(/can't be blank/)
        end
      end
    end

    describe 'PUT /api/v1/authors/:id' do
      context 'when the record exists' do
        context 'with valid data' do
          let(:name) { Faker::Name.name }
          let(:valid_attributes) { { author: { name: name } } }

          before { put "/api/v1/authors/#{author_id}", params: valid_attributes }

          it 'updates the record' do
            expect(response.body).to match(/#{name}/)
          end

          it 'returns status code 204' do
            expect(response).to have_http_status(200)
          end
        end

        context 'with invalid data' do
          let(:invalid_attributes) { { author: { name: '' } } }

          before { put "/api/v1/authors/#{author_id}", params: invalid_attributes }

          it 'updates the record' do
            expect(response.body).to match(/can't be blank/)
          end

          it 'returns status code 204' do
            expect(response).to have_http_status(422)
          end
        end
      end
    end

    describe 'DELETE /api/v1/authors/:id' do
      before { delete "/api/v1/authors/#{author_id}" }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
end
