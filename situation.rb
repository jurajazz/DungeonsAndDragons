
class Situation
  attr_accessor :place, :description, :is_fight

  def initialize(place)
    @place=place
    @description=place.description
    @is_fight
  end

  def to_s
    "#{@description}"
  end

  def get_enemies
  end

end
