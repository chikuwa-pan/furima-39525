class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_seller_access, only: [:index]
  before_action :set_key, only: [:index, :create]
  before_action :set_purchase, only: [:index, :create]

  def index
    @purchase_address = PurchaseAddress.new(item_id: @item.id)

    if Purchase.exists?(item_id: @item.id)
      redirect_root
    end
  end


  def create
      @purchase_address = PurchaseAddress.new(purchase_params.merge(item_id: @item.id, user_id: current_user.id))
      if @purchase_address.valid?
        payjp_charge
        @purchase_address.save
        redirect_root
      else
        render :index
      end
  end

  private
    def set_key
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    end

    def set_purchase
      @item = Item.find(params[:item_id])
    end

    def redirect_root
      redirect_to root_path
    end

    def check_seller_access
      set_purchase
      if current_user == @item.user
        redirect_root
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
