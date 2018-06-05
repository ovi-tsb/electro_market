class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
  def index
    @filterrific = initialize_filterrific(
      Product,
      params[:filterrific],
      select_options: {
        sorted_by: Product.options_for_sorted_by,
        with_category_id: Category.options_for_select,
        with_brand_id: Brand.options_for_select
      }
    ) or return
    @products = @filterrific.find.page(params[:page])
    # @products = Product.all
    #@uploads = Picture.order('created_at ASC')  

        respond_to do |format|
          format.html
          format.js
        end
  end
  def list
  end

  def grid
  end
  def show
    @category = Category.find_by_id(params[:category_id])
    @brand = Brand.find_by_id(params[:brand_id])
    # @products = Product.all.order("name DESC")
    @product = Product.find(params[:id])
    @picture = Picture.where(product_id: @product.id).order("created_at ASC") 
    # @image = Picture.first
    #@pictures = @product.pictures.all
  end

  def new
    @product = Product.new
    #@pictures = @product.pictures.build
  end

  def create
    
    @product = Product.new(product_params)

    respond_to do |format| 
       if @product.save 
          # params[:pictures]['image'].each do |a|
          #   @pictures = @product.pictures.create!(:image => a)
          # end
          format.html { redirect_to @product, notice: "Product was successfully created." } 
          format.json { render :show, status: :created, location: @product } 
       else 
          format.html { render :new, notice: "You have a error" } 
          format.json { render json: @product.errors, status: :unprocessable_entity } 
       end 
     end
  end

  def edit
    
  end

  def update
    
    if @product.update(product_params)
      redirect_to @product, notice: "Your product was updated !"
    else
      render "edit"
    end
  end

  def destroy
    
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private

  def product_params
   params.require(:product).permit( :id, :name, :description, :price, :category_id, :brand_id, :image,
     :product_id)
   
  end

  def set_product
    @product = Product.find(params[:id])
  end



end
