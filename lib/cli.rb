require 'git/repository'

module Git
  class << self
    attr_accessor :repositories, :current_repo

    def init(name, owner)
      repo = Repository.new name, owner
      @repositories << repo
      self.current_repo = repo
      repo
    end

    def cd(repo_name)
      self.current_repo = repositories.find { |repo| repo.name == repo_name }
    end

    def clear_staged_files
      current_repo.working_directory[:staged] = []
    end

  end
end
