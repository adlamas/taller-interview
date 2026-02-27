require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "POST /books/:id/reserve" do
    let!(:author) { create(:author, name: 'Name') }
    let!(:book) { create(:book, author_id: author.id, title: 'Book1') }
    let(:valid_attributes) do
      {
        email: 'email@email.com'
      }
    end

    context 'when book is not reserved' do
      before do
        post "/books/#{book.id}/reserve", params: valid_attributes
      end

      it 'creates correctly the reservation' do
        expect(Reservation.last.book_id).to eq book.id
        expect(Reservation.last.status).to eq 'reserved'
        expect(Reservation.last.email).to eq 'email@email.com'
      end
    end

    context 'when book is already reserved' do
      before do
        Reservation.create!(book_id: book.id, status: 'reserved', email: 'adifferent@email.com')
        post "/books/#{book.id}/reserve", params: valid_attributes
      end

      it 'fails because the book is already reserve' do
        res = JSON.parse(response.body)
        expect(res['msg']).to eq('book is already reserved')
      end
    end
  end
end