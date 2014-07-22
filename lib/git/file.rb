module Git
  class File
    attr_accessor :path, :content, :history

    def initialize(path, content, repo_name)
      self.path = path
      self.content = content
      self.history = [content]

      add_to_repo(repo_name)
    end

    def update(new_content)
      self.history << new_content
      self.content = new_content
    end

    private

    def add_to_repo(repo_name)
      repo = Git::repositories.find { |r| r.name == repo_name }
      repo.working_directory[:untracked].push self
    end
  end
end
