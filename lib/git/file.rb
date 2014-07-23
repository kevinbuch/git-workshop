module Git
  class File
    attr_accessor :path, :content, :history

    def initialize(path, content)
      raise StandardError if path[0] != '/'
      self.path = parse_filepath path
      self.content = content
      self.history = [content]

      add_to_repo(path)
    end

    def update(new_content)
      self.history << new_content
      self.content = new_content
    end

    private

    def add_to_repo(filepath)
      repo_name = parse_repo_name(filepath)

      repo = Git::repositories.find { |r| r.name == repo_name }
      repo.working_directory[:untracked].push self
    end

    def parse_repo_name(filepath)
      filepath.split('/')[1]
    end

    def parse_filepath(full_path)
      second_file_sep = full_path[1..-1].index('/') + 1

      full_path[second_file_sep..-1]
    end
  end
end
