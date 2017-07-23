# frozen_string_literal: true

module Api
  module V1
    class AuthorsController < ApplicationController
      before_action :set_author, only: %i[show update destroy]

      # GET /authors
      def index
        authorize! :read
        @authors = Author.all
        render json: @authors
      end

      # GET /authors/1
      def show
        authorize! :read
        render json: @author
      end

      # POST /authors
      def create
        authorize! :create
        @author = Author.new(author_params)

        if @author.save
          render json: @author, status: :created, location: api_v1_author_url(@author)
        else
          render json: @author.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /authors/1
      def update
        authorize! :update
        if @author.update(author_params)
          render json: @author
        else
          render json: @author.errors, status: :unprocessable_entity
        end
      end

      # DELETE /authors/1
      def destroy
        authorize! :destroy
        @author.destroy
      end

      private

      def set_author
        @author = Author.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def author_params
        params.require(:author).permit(:name)
      end
    end
  end
end
