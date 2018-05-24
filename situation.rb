
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
  attr_accessor :place_name, :description, :is_fight, :actions

  def initialize(place_name)
    @place_name=place_name
    @description="You are at #{place_name}"
    @is_fight
    @actions=[]
  end

  def to_s
    "#{@description}"
  end

  def enemies
  end

end
