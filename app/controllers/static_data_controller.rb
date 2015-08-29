class StaticDataController < ApplicationController
  def image_sprite
    @style = StaticData::Image.find(params[:id]).get_sprite_style if StaticData::Image.find_by_id(params[:id])

    respond_to do |format|
      format.html { render json: @style}
      format.json { render json: @style }
    end
  end

end
