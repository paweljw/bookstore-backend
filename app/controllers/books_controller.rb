# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_author, only: [:show, :update, :destroy]
  before_action :set_book, only: [:show, :update, :destroy]

  def index
    @books = @author.books.all
    render json: @books
  end

  def show
    render json: @book
  end

  def create
    @book = @author.books.new(book_params)

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
  end

  private

  def set_book
    @book = @author.books.find(params[:id])
  end

  def set_author
    @author = Author.find(params[:author_id])
  end

  def book_params
    params.require(:book).permit(:author_id, :title, :price)
  end
end
