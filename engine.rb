# game engine

require 'yaml'
require_relative 'person'
require_relative 'map'
require_relative 'situation'

class Engine
  attr_accessor :map,:npcs,:hero,:races,:situations,:situation
  def initialize
    @map = Map.new
    @npcs = [] # non player characters
    @hero = Person.new
    @hero.is_hero = true
    @races = []
    @situation = nil
  end

  def load_description(filename)
    desc = YAML.load_file(filename);
    #puts desc
    @map.load(desc)
    desc['npcs'].each do |p|
      puts "Loading npc #{p['name']}"
      @npcs << Person.new.load(p)
    end
    desc['races'].each do |r|
      puts "Loading race #{r['name']}"
      @races << Person.new.load(r)
    end
  end

  def start_game
    load_description('description.yaml')
    @hero.move(@map.places.first)
    @situation = Situation.new(@hero.place)
    puts "Current situation: #{@situation}"
    puts "#{@hero}"
  end

  def situation_prepare
  end

end
