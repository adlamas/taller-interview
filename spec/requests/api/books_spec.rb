require 'rails_helper'

RSpec.describe "Api::Books", type: :request do
  let!(:author) { create(:author) }
  let!(:books) { create_list(:book, 3, author: author) }

  describe "GET /api/books" do
    it "returns a successful response and all books" do
      get "/api/books"
      
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "POST /api/books" do
    let(:valid_attributes) do
      {
        book: {
          title: "Crónica de una muerte anunciada",
          summary: "Un relato sobre el destino.",
          author_id: author.id
        }
      }
    end

    context "with valid parameters" do
      it "creates a new Book" do
        expect {
          post "/api/books", params: valid_attributes, as: :json
        }.to change(Book, :count).by(1)
        
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "returns a 422 unprocessable entity" do
        post "/api/books", params: { book: { title: "" } }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end