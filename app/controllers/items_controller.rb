class ItemsController < ApplicationController
  def index
    @items = Item.all
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


  def item_params
    params.require(:item).permit( :image,
                                  :title, 
                                  :description, 
                                  :category_id, 
                                  :condition_id,
                                  :postage_id,
                                  :prefecture_id,
                                  :shipping_day_id,
                                  :price)
  end
end