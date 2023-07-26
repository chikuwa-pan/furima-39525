class ItemsController < ApplicationController
  before_action :move_to_sign_in, only: [:new, :edit]
  before_action :move_to_index, except: [:index, :show]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
      if @item.user == current_user
        if @item.update(item_params)
          redirect_to item_path(@item.id)
        else
          render :edit
        end
      else
        redirect_to root_path
    end
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

  def move_to_sign_in
    unless user_signed_in?
        redirect_to new_user_session_path
    end
  end

  def move_to_index
    unless user_signed_in? && current_user_item
        redirect_to root_path
    end
  end

  def current_user_item
    item = Item.find(params[:id])
    item.user == current_user
  end
end