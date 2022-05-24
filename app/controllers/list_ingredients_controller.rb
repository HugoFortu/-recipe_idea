class ListIngredientsController < ApplicationController
  def update
    @list_ingredient = ListIngredient.find(params[:id])
    @list_ingredient.update(list_ingredient_params)
    @list_ingredient.save
    # respond_to do |format|
    #   format.turbo_stream
    # end
    render :json => {}
  end

  private

  def list_ingredient_params
    params.require(:list_ingredient).permit(:quantity, :checked)
  end
end
