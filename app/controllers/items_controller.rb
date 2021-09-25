class ItemsController < ApplicationController
  before_action :move_to_login, only: :new
  def index
  end

  def new
  end

  private
  def move_to_login
    unless user_signed_in?
      redirect_to authenticate_user!
    end
  end
end
