module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_product, except: [:index]

    	def index
    		@products = Product.all
    		
        render json: {
          response: Rabl::Renderer.new("api/v1/products/index", @products, format: :hash, scope: self).render
        }
    	end

      def create
				@product = Product.new(product_params)

				if @product.save
					render json: @product, status: :created
				else
					render json: {
					  message: 'create failed',
					  errors: @product.errors
					}, status: :unprocessable_entity
				end
			end

      def update
				if @product.update(product_params)
					render json: @product, status: :ok
				else
					render json: {
					  message: 'update failed',
					  errors: @product.errors
					}, status: :unprocessable_entity
				end
			end

    	private

      def set_product
          @product = Product.find(params[:id])
      end

    	def product_params
        params.require(:product).permit(
              :code, :name, :brand, :count, :price, :category_id, :created_at, :updated_at
        )
      end
    end
  end
end