class ItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:merchant_id])
    @merchant_items = merchant.items
  end

  def show
    merchant = Merchant.find(params[:merchant_id])
    @item = merchant.items.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if params[:update_status] == 'Disabled'
      @item.update!(status: 1)
      flash[:success] = "Item #{@item.name} Disabled"
      redirect_to merchant_items_path(@item.merchant.id)
    elsif params[:update_status] == 'Enabled'
      @item.update!(status: 0)
      flash[:success] = "Item #{@item.name} Enabled"
      redirect_to merchant_items_path(@item.merchant.id)
    else
      @item.update!(item_params)
      flash[:success] = 'Item successfully updated'
      render :show
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end

end
