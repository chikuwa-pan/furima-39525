class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_purchase, only: [:index, :create]
  before_action :move_to_index, only: :index

  def index
    @purchase_address = PurchaseAddress.new(item_id: @item.id)
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params.merge(item_id: @item.id, user_id: current_user.id))
    if @purchase_address.valid?
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
    def set_purchase
      @item = Item.find(params[:item_id])
    end

    def move_to_index
      if current_user == @item.user
        redirect_to root_path
      end
    end

    def purchase_params
      params.require(:purchase_address).permit( :post_number, 
                                                :prefecture_id, 
                                                :municipalities, 
                                                :address, 
                                                :building, 
                                                :phone)
    end
end
