class RecipeIngredientsController < ApplicationController
  before_action :set_recipe_ingredient, only: [:show, :edit, :destroy]
  before_action -> {check_user(Recipe.find(recipe_ingredient_params[:recipe_id]))}, only: [:create, :update, :destroy]

  def show
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_ingredient = RecipeIngredient.new
  end

  def create
    @recipe_ingredient = RecipeIngredient.new(recipe_ingredient_params)
    if @recipe_ingredient.save
      flash[:notice] = "Ingredient added!"
      redirect_to recipe_path(@recipe_ingredient.recipe_id)
    else
      @recipe = Recipe.find(recipe_ingredient_params[:recipe_id])
      flash.now[:alert] = "Ingredient not added. #{@recipe_ingredient.errors.full_messages.join(". ")}"
      render :new
    end
  end

  def edit
  end

  def update
    #code to update
  end

  def destroy
    #code to destroy
  end

  private
  def set_recipe_ingredient
    @recipe_ingredient = RecipeIngredient.find(params[:id])
  end

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(
      :recipe_id,
      :ingredient_id,
      :use_id,
      :amount,
      :unit_id,
      :time
    )
  end
end
