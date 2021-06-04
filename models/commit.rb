require_relative "curse"

class Commit
  attr_reader :message, :url

  DUPLICATE_AUTHORS = {
    "hollyhilts" => "HollyHilts",
    "tsamyin" => "Thomas Sam-Yin-Yang",
    "Pascal" => "Pascal Racine-Venne",
    "Bauffeuvre" => "baptiste auffeuvre",
  }
  def initialize(params)
    initial_author = params.dig("author", "name")
    @author = DUPLICATE_AUTHORS[initial_author] || initial_author
    @message = params.dig("message")
    @url = params.dig("url")
  end

  def words
    @words ||= message.scan(/\w+/)
  end

  def cursed?
    curses.any?
  end

  def curses
    @curses ||= words.select { |word| Curse::WORDS.include?(word.downcase) }
  end

  def author
    @author
  end

  def to_s
    <<-TXT
      -------

      Author:       #{author}
      Message:      #{message}
      Cursed Words: #{curses}
      #{url}

    TXT
  end
end
