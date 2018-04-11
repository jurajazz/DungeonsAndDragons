
require_relative 'engine'
require 'readline'

engine = Engine.new
engine.start_game

while true
  cmd=''
  puts
  list = ['exit']
  engine.situation.actions.each do |a|
    list << a.to_s
  end
  #list.sort!
  comp = proc { |s| list.grep(/^#{Regexp.escape(s)}/) }
  Readline.completion_append_character = " "
  Readline.completion_proc = comp
  line = Readline.readline('> ', true)
  break if line == 'exit'
  engine.do_action(line)
end
