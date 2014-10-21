class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def add_to_database
    @product = Product.new(product_params)
    add_to_db(product_categories)
    if @product.save
      redirect_to "/products/index"
    else
      render :new
    end
  end

  def index
    @products = Product.all
    render :index
  end

  def about
    @product = Product.find(params[:id])
    render :about
  end

  def edit
    find_product
  end

  def update
    find_product
    @product.update(product_params)
    add_to_db(product_categories)
    if @product.save
      redirect_to "/products/#{@product.id}/about"
    else
      render :edit
    end
  end

  def cart
    #render :"/cart"
  end

  def add_to_cart
    redirect_to "/cart"
  end

  # def show
  #   find_product
  # end

  #
  # def create
  #   @product = Product.new(product_params)
  #   @product.vendor_id = session[:v_id]
  #   if @product.save
  #     redirect_to "/product/#{@product.vendor_id}/product_list"
  #   else
  #     redirect_to "/product/new_product"
  #   end
  # end

  # def product_list
  #   @products = Product.all
  # end

  private
    def find_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :quantity, :merchant_id)
    end

    def product_categories
      params.require(:product).permit(:categories)[:categories]
    end

    def add_to_db(category_names)
      if category_names.include?(",")
        category_names = category_names.split(",")
      else
        category_names = category_names.split
      end

      category_names.each do |category_name|
        category_name = category_name.strip.downcase
        cat = Category.find_by(name: category_name)
        if cat
          @product.categories << cat
        else
          @product.categories << Category.create(name: category_name)
        end
      end
    end


end
