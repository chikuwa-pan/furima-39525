class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
    @categories = Category.new
    @maincategories = Category.all.order("id ASC").limit(13)
  end

  def search
    item = Category.find(params[:id])
      children_item = item.children
      render json:{ item: children_item }
      #binding.pry
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_root
    else
      render :new
    end
  end

  def show
  end

  def edit
    if Purchase.exists?(item_id: @item.id)
      redirect_root
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_root
  end

  private
  def item_params
    params.require(:item).permit( :image,
                                  :title, 
                                  :description, 
                                  :category_id, 
                                  :condition_id,
                                  :postage_id,
                                  :prefecture_id,
                                  :shipping_day_id,
                                  :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_root
    redirect_to root_path
  end

  def move_to_index
    if current_user != @item.user
      redirect_root
    end
  end
end