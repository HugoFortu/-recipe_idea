class IngredientsController < ApplicationController
  before_action :find_ingredient, only: [:update]

  def edit
    @ingredient = Ingredient.without_cat.first
  end

  def update
    @ingredient.update(ingredient_params)

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to ingredient_url, notice: "Ingredient was successfully updated." }
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
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:ingredient_category_id)
  end
end
