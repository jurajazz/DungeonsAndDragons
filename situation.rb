
class Action
  attr_accessor :type,:name
  def initialize(type,name)
    @types = ['move','fight','run','spell','select_weapon']
    @type=type
    @name=name
  end
  def to_s
    "#{@type}.#{@name}"
  end
end

class Situation
  attr_accessor :place, :description, :is_fight, :actions

  def initialize(place)
    @place=place
    @description=place.description
    @description="You are at #{place}" if @description.nil?
    @is_fight
    @actions=[]
  end

  def to_s
    "#{@description}"
  end

  def enemies
  end

end
