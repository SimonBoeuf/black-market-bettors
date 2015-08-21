module ImageHelper
  def get_sprite_style i
    "width:#{i.w}px;height:#{i.h}px;background: url(#{StaticData.get_sprite_image(i, "euw")}); background-repeat:no-repeat;background-position:-#{i.x}px -#{i.y}px;"
  end
end
