# game engine

require 'yaml'
require_relative 'person'
require_relative 'map'
require_relative 'situation'

class Engine
  attr_accessor :map,:npcs,:hero,:races,:situation,:enemy
  def initialize
    @map = Map.new
    @npcs = [] # non player characters
    @hero = Person.new
    @hero.is_hero = true
    @hero.name = 'Hero'
    @races = []
    @situation = nil
    @enemies = []
    @game_is_over = false
  end

  def load_description(filename)
    desc = YAML.load_file(filename);
    #puts desc
    @map.load(desc)
    desc['npcs'].each do |p|
      puts "Loading npc #{p['name']}"
      npc = Person.new
      npc.load(p)
      @npcs << npc
    end
    desc['races'].each do |r|
      puts "Loading race #{r['name']}"
      @races << Person.new.load(r)
    end
  end

  def start_game
    @game_is_over = false
    load_description('description.yaml')
    @hero.move(@map.places.first.name)
    situation_prepare
  end

  def situation_prepare
    @situation = Situation.new(@hero.place_name)
    @enemies = []
    puts "------------------------------------------------"
    puts "Current situation: #{@situation}"
    puts "#{@hero}"
    # search for enemies
    @npcs.each do |npc|
      #puts "Situation prepare checking npc #{npc.name}"
      if npc.is_enemy and npc.life>0 and npc.place_name == @hero.place_name
        # live enemy is here
        puts "Enemy #{npc} is here"
        situation.actions << Action.new('fight',npc.name)
        @enemies << npc
        situation.is_fight = true
      end
    end
    @map.ways.each do |way|
      if way.from == situation.place_name
        situation.actions << Action.new('move',way.to)
      end
    end
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
      @hero.move(name)
    when 'fight'
      do_hero_fight_step
    when 'spell'
      do_spell(name)
    else
      puts "Not implemented: #{type}"
    end
    situation_prepare
  end

  # one step of fight
  def do_hero_fight_step
  end

  def handle_after_hero_fight_step
    if @hero.life<0
      hero_died
    end
  end

  def hero_died
    puts "You died"
    game_over
  end

  def game_over
    puts "Game over"
    @game_is_over=true
  end

end
