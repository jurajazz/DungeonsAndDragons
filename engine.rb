# game engine

require 'yaml'
require_relative 'person'
require_relative 'map'
require_relative 'situation'

class Engine
  attr_accessor :map,:npcs,:hero,:races,:situation
  def initialize
    @map = Map.new
    @npcs = [] # non player characters
    @hero = Person.new
    @hero.is_hero = true
    @hero.name = 'Hero'
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
    situation_prepare
  end

  def situation_prepare
    @situation = Situation.new(@hero.place)
    puts "------------------------------------------------"
    puts "Current situation: #{@situation}"
    puts "#{@hero}"
    @map.ways.each do |way|
      if way.from == situation.place.name
        situation.actions << Action.new('move',way.to)
      end
    end
    situation.actions << Action.new('fight','Wizard')
    situation.actions << Action.new('fight','Anyone')
    print "Possible actions: "
    @situation.actions.each do |a|
      print "#{a},"
    end
    puts
  end

  def do_action(action)
    action.strip!
    puts "DoAction #{action}"
    (type,name) = action.split(/\./)
    case type
    when 'move'
      found=false
      @map.places.each do |p|
        if p.name == name
          @hero.move(p)
          found=true
          break
        end
      end
      puts "Place -#{name}- not found" if !found
    when 'fight'
      fight
    else
      puts "Not implemented: #{type}"
    end
    situation_prepare
  end

  def fight
  end

end
