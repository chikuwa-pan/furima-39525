class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_purchase, only: [:index, :create]
  before_action :move_to_index, only: :index

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_address = PurchaseAddress.new(item_id: @item.id)
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params.merge(item_id: @item.id, user_id: current_user.id))
    if @purchase_address.valid?
      payjp_charge
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

    def payjp_charge
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price, # 商品の値段
        card: purchase_params[:token],    # カードトークン
        currency: 'jpy' # 通貨の種類（日本円）
      )
    end

    def purchase_params
      params.require(:purchase_address).permit( :post_number, 
                                                :prefecture_id, 
                                                :municipalities, 
                                                :address, 
                                                :building, 
                                                :phone).merge(token: params[:token])
    end
end
