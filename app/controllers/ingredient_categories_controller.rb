class IngredientCategoriesController < ApplicationController
  before_action :find_ingredient, only: [:update]

  def edit
    @ingredient_category = IngredientCategory.without_cat(current_user).first
  end

  def update
    @ingredient.update(ingredient_params)

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to ingredient_category_url, notice: "Ingredient was successfully updated." }
        format.json { render :show, status: :created, location: @ingredient }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  private

  def find_ingredient
    @ingredient = IngredientCategory.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient_category).permit(:user_category_id)
  end
end
