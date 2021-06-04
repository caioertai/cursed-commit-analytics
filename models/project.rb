require_relative "commit"

class Project
  attr_reader :commits, :name

  def initialize(name: "", data: [])
    @name = name
    @commits = data.map { |node| Commit.new(node["commit"]) }
  end

  def cursed_commits
    commits.select(&:cursed?)
  end

  def authors
    commits.map(&:author).uniq
  end

  def cursed_words_count
    cursed_words.each_with_object(Hash.new(0)) do |word, object|
      object[word.downcase] += 1
    end.sort_by { |_, count| -count }.to_h
  end

  private

  def cursed_words
    commits.map(&:curses).flatten
  end
end
