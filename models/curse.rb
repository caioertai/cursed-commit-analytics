require "set"

class Curse
  WORDS = Set.new(File.open("support/curses.txt").map { |line| line.chomp })
end
