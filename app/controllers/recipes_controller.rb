class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :remove]
  before_action :authorize_user, only: [:update, :edit, :remove]

  def index
    @recipes = Recipe.where(active: 1)
  end

  def show
    @rating = Rating.new
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash[:notice] = "#{recipe_params[:name]} was updated!"
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = "#{recipe_params[:name]} not updated! #{@recipe.errors.full_message.join(". ")}"
      render :edit
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:notice] = "Recipe added!"
      redirect_to root_path
    else
      flash[:alert] = "Recipe not added. #{@recipe.errors.full_messages.join(". ")}"
      render :new
    end
  end

  def remove
    if @recipe.update(active:0)
      flash[:notice] = "#{@recipe.name} was deleted."
      redirect_to root_path
    else
      flash[:alert] = "#{@recipe.name} could not be deleted. #{@recipe.errors.full_message.join(". ")}"
      render :show
    end
  end

  private
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :user_id,
      :name,
      :notes,
      :batch_size,
      :boil_size,
      :boil_time,
      :original_gravity,
      :final_gravity,
      :alcohol_by_volume,
      :bitterness,
      :color,
      :keg_temp,
      :storage_temp,
      :age_for
    )
  end

  def authorize_user
    if !current_user || current_user.id != @recipe.user_id
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
  end

end