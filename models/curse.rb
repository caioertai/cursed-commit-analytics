require "set"

class Curse
  WORDS = Set.new(File.open("curses.txt").map { |line| line.chomp })
end
