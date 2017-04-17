class InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show, :edit, :update, :destroy]
  before_action -> {check_user(@inventory)}, only: [:update, :destroy]
  before_action :signed_in, only: [:index, :show, :edit, :new, :create]

  def index
    @inventories = Inventory.where(user: current_user)
  end

  def show
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)
    if @inventory.save
      flash[:notice] = "Inventory added!"
      redirect_to inventories_path
    else
      flash[:alert] = "Inventory not added. #{@inventory.errors.full_messages.join(". ")}"
      render :new
    end
  end

  def edit
  end

  def update
    if @inventory.update(inventory_params)
      flash[:notice] = "Your inventory was updated!"
      redirect_to inventory_path(@inventory)
    else
      flash[:alert] = "Inventory not updated! #{@inventory.errors.full_messages.join(". ")}"
      render :show
    end
  end

  def destroy
    @inventory.destroy
    redirect_to inventories_path, notice: "Inventory deleted."
  end

  private
  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  def inventory_params
    params.require(:inventory).permit(:user_id, :ingredient_id, :amount, :unit_id)
  end
end
