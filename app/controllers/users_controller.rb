# class Users Controller
class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end
  def my_friends
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.turbo_stream do
             render turbo_stream: turbo_stream.update(
            'results',
             partial: 'users/friend_result'
            )
           end
        end
      else
      find_friend
      end
    else
      valid_friend
    end
  end
  def find_friend
    flash[:alert] = "couldn't find user"
  end

  def valid_friend
    flash[:alert] = "Please enter a friend name or email to search"
  end
end
