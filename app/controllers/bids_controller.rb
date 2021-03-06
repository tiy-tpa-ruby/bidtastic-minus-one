class BidsController < ApplicationController
  def create

    @auction = Auction.find(params[:auction_id])

    @item = @auction.items.find(params[:item_id])

    @item = Item.find(params[:item_id])

    unless logged_in?
      redirect_to auction_item_path(@auction, @item), notice: "Please log in to make bid"
      return
    end

    @bid = @item.bids.create(bid_params)
    @bid.created_by = current_user

    @bid.save
    if @bid.save
      redirect_to auction_item_path(@auction, @item), notice: "Thank You"
    else
      redirect_to auction_item_path(@auction, @item), notice: "Please revise your bid #{@bid.errors.full_messages}"
    end
  end

  def bid_params
    params.require(:bid).permit(:bid_amount)
  end
end
