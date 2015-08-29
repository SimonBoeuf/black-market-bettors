class StaticDataController < ApplicationController
  def champion_sprite
    @sprite = StaticData::Champion.find(params[:id]).get_sprite_style if StaticData::Champion.find_by_id(params[:id])

    respond_to do |format|
      format.html { render json: @sprite}
      format.json { render json: @game_state }
    end
  end

end
