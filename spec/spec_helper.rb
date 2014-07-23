require 'pry'
require 'git'
require 'cli'

def create_repository(repo_name)
  repo = Repository.new repo_name, 'owner'
  Git::repositories << repo
end
