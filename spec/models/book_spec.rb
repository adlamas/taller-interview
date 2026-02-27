require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "associations" do
    it { should belong_to(:author) }
  end

  describe "validations" do
    it "is valid with valid attributes" do
      book = build(:book) # Usando tu factoría
      expect(book).to be_valid
    end

    it "is invalid without a title" do
      book = build(:book, title: nil)
      expect(book).not_to be_valid
    end
  end
end