# class Stocks Controller
class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.turbo_stream do
             render turbo_stream: turbo_stream.update(
            'results',
             partial: 'users/result'
            )
           end
        end
      else
        flash_message_symbol
      end
    else
      flash_message_symbol
    end
  end

  def flash_message_symbol
    flash[:alert] = 'Please enter a valid symbol to search'
    redirect_to my_portfolio_path
  end
end
