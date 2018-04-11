
require_relative 'map'

class Person
  attr_accessor :name,:is_enemy,:abilities,:disabilities,:weapons,:weapon_in_hand,:quests,:spells,:gold,:life_percents,:place,:armour,:is_hero
  def initialize
    @name = ''
    @is_enemy = false # in case of NPC that is enemy
    @is_hero = false
    @abilities = []
    @disabilities = []
    @weapons = []
    @weapon_in_hand
    @armour
    @quests = []
    @spells = []
    @gold = 0
    @life = 100
    @place # current Place where person is located
  end

  def load(desc)
    #puts "Loading person #{desc}"
    @name = desc['name']
    @is_enemy = desc['is_enemy']
    @place = desc['place']
    @weapons = desc['weapons']
    @weapon_in_hand
    @weapon_in_hand = @weapons.first if !@weapons.nil?
    @armour = desc['armour']
    @life = desc['life']
    if !desc['abilities'].nil?
      desc['abilities'].each do |a|
        @abilities << a['ability']
      end
    end
  end

  def has_ability(ability_name)
    @abilities.each do |a|
      return true if (a == ability_name)
    end
  end

  def move(place)
    @place = place
  end

  def to_s
    "Player #{@name} has life #{@life}, gold #{@gold}"
  end

end
