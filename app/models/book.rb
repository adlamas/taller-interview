class Book < ApplicationRecord
  #belongs_to :author
  #has_and_belongs_to_many :genres
  has_one :reservation
  
  validates :title, presence: true

  def reserve!(email)
    reservation = Reservation.find_by(book_id: id)
    raise StandardError if reservation

    Reservation.create!(book_id: id, email: email, status: 'reserved')
  end
end