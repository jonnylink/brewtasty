class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update]

  def index
    @ingredient_category = params[:category]
  end

  def show
  end

  # def edit
  # end
  #
  # def update
  # end
  #
  # def new
  # end
  #
  # def create
  # end

  private
  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end
end
