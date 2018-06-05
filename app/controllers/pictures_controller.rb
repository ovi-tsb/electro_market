class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :set_product
  # GET /paintings
  # GET /paintings.json
  def index
    @pictures = Picture.all.order("created_at ASC")
    # @gallery = Gallery.find(params[:id])
  end

  # GET /paintings/1
  # GET /paintings/1.json
  def show
    @picture = Picture.find(params[:id])
  end

  # GET /paintings/new
  def new
    @picture = Picture.new
  end

  # GET /paintings/1/edit
  def edit
    @picture = Picture.find(params[:id])
  end

  # POST /paintings
  # POST /paintings.json
  def create
    
    @picture = Picture.new(picture_params)
    @picture.product_id = @product.id
    
    respond_to do |format|
      if @picture.save
        format.html { redirect_to @product, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paintings/1
  # PATCH/PUT /paintings/1.json
  def update
    @picture.product_id = @product.id
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paintings/1
  # DELETE /paintings/1.json
  def destroy
    @picture.destroy
    
    respond_to do |format|
      format.html { redirect_to @product, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:id, :image)
    end
end
