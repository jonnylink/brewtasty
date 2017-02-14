class Admin::UsersController < ApplicationController
  before_action :authorize_admin!
  before_action :set_user, only: [:show, :ban, :unban]

  def index
    @users = User.all
  end

  def ban
    @user.update(active: 2)
    redirect_to '/admin/users', notice: "#{@user.username} was banned."
  end

  def unban
    @user.update(active: 1)
    redirect_to '/admin/users', notice: "#{@user.username} was unbanned."
  end

  private
  def authorize_admin!
    if current_user.nil? or !current_user.admin?
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
