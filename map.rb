
# -------------------------------------------

class Way
  attr :from,:to
  def initialize(place1,place2)
     @from=place1
     @to=place2
  end
  def to_s
    "#{@from}-#{@to}"
  end
end

# -------------------------------------------

class Place
  attr_accessor :name,:description
  def initialize(name)
    @name = name
    @desciption
  end
  def available_ways
  end
  def to_s
    @name
  end
end

# -------------------------------------------

class Map
  attr :places,:ways
  def initialize
    @places = []
    @ways = []
  end
  def places
    @places
  end
  def add_place(place)
    @places << place
  end
  def add_way(place1,place2,one_way_only)
    @ways << Way.new(place1,place2)
    if !one_way_only
      @ways << Way.new(place2,place1)
    end
  end

  def load(desc)
    desc['places'].each do |p|
      place = Place.new(p['name'])
      place.description = p['description'] if !p['description'].nil?
      puts "Loading place #{place.name}"
      add_place(place)
    end
    desc['ways'].each do |w|
      add_way(w['from'],w['to'],false)
    end
  end

end
