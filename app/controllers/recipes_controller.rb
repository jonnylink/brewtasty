class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :remove]
  before_action -> {check_user(@recipe)}, only: [:update, :edit, :remove]

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
      flash[:alert] = "Recipe not updated! #{@recipe.errors.full_messages.join(". ")}"
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
      flash[:alert] = "#{@recipe.name} could not be deleted. #{@recipe.errors.full_messages.join(". ")}"
      render :show
    end
  end

  def search
    query = "%#{params[:search_recipes]}%"
    @recipes = Recipe.joins(:user).where('name ILIKE ? OR username ILIKE ?', query, query)
    if @recipes.count > 0
      flash[:notice] = "Recipes found. Searched for: #{params[:search_recipes]}."
    else
      flash[:alert] = "Sorry, no recipes found. Searched for: #{params[:search_recipes]}."
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
      :boil_gravity,
      :original_gravity,
      :final_gravity,
      :ferment_temp
    )
  end

end
