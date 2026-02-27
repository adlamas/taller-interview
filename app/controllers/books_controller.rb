class BooksController < ApplicationController
  before_action :set_book, only: %i[ show update destroy ]

  def reserve
    @book = Book.find(params[:id])
    @book.reserve!(params[:email])
    render json: @book
  rescue StandardError => e
    render json: { msg: 'book is already reserved' }
  end

  # GET /books
  def index
    @books = pagy(Book.find_each(batch_size: 1000))

    render json: @books
  end

  # GET /books/1
  def show
    render json: @book
  end

  # POST /books
  def create
    debugger
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :summary, :author_id)
    end
end
