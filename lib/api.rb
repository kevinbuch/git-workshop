require 'git/repository'

module Git

  def self.repositories
    @repositories ||= []
  end

  def self.repositories=(repos)
    @repositories = repos
  end

  def self.init(name, owner)
    repo = Repository.new name, owner
    @repositories << repo
    repo
  end

  def self.add(file, repo)
    repo.working_directory[:untracked].delete file
    repo.working_directory[:tracked][:staged].push file
  end
end
