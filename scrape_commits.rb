require "httparty"
require "yaml"

BASE_URL = "https://api.github.com"
github_username = ARGV[0]
github_repo     = ARGV[1]

def commits_path(username, repo_name)
  "#{BASE_URL}/repos/#{username}/#{repo_name}/commits"
end

def request_commits(username, repo_name)
  page = 1
  last_commits_count = nil
  all_commits = []

  until last_commits_count&.zero?
    req = HTTParty.get(
      commits_path(username, repo_name),
      query: {per_page: 100, page: page}
    )
    page += 1
    last_commits_count = req.count
    all_commits += req.to_a
  end

  all_commits
end

cultivate_commits = request_commits(github_username, github_repo)
File.open("data/commits/#{github_repo}_commits.yml", "wb") do |file|
  file << cultivate_commits.to_yaml
end
