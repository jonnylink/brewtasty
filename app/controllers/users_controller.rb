class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :remove]

  def index
    @users = Users.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def new
  end

  def create
  end

  def remove
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
