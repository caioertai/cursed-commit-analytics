require "yaml"
require_relative "models/project"

github_repo = ARGV[0]
file = File.open("data/commits/#{ARGV[0]}_commits.yml")

project = Project.new(
  name: file.path.gsub(/(.*)_.*/, '\1'),
  data: YAML.load(file)
)

File.open("data/stats/#{github_repo}.txt", "wb") do |file|
  file << "".center(80, "=")
  file << "\n"
  file << " Cursed Commits ".center(80, "=")
  file << "\n"
  file << " #{project.name} ".center(80, "=")
  file << "\n"
  file << "".center(80, "=")
  file << "\n"
  project.cursed_commits.each do |cursed_commit|
    file << cursed_commit.to_s
  end

  file << "\n"

  file << " Stats ".center(60, "=")
  file << "\n"
  file << " #{project.name} ".center(60, "=")
  file << "\n"
  file << "\n"

  file << "Total cursed commits count: #{project.cursed_commits.count}\n"
  file << "\n"

  file << "Cursed commit champions:\n"
  project.authors.map do |author|
    author_count = project.cursed_commits.count { |commit| commit.author == author }
    {
      count: author_count,
      line: "#{" " * 13} #{author} #{"-" * (24 - author.length)}> #{author_count.to_s.rjust(2, "0")}\n"
    }
  end.sort_by { |data| -data[:count] }.each { |data| file << data[:line] }
  file << "\n"

  file << "Most used cursed words:\n"
  project.cursed_words_count.each do |cursed_word, count|
    file << "#{" " * 13} #{cursed_word} #{"-" * (24 - cursed_word.length)}> #{count.to_s.rjust(2, "0")}\n"
  end
end
