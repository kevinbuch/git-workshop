require 'git/repository'

module Git
  class << self
    attr_accessor :repositories

    def init(name, owner)
      repo = Repository.new name, owner
      @repositories << repo
      repo
    end

    def add(file, repo)
      repo.working_directory[:untracked].delete file
      repo.working_directory[:tracked][:staged].push file
    end

    def commit(repo)
      commit_files = repo.working_directory[:tracked][:staged]
      repo.working_directory[:tracked][:staged] = []
      repo.commits << commit_files
    end
  end
end
