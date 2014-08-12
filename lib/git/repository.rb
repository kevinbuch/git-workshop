class Repository
  attr_accessor :owner, :branches, :commits, :working_directory, :name, :previous_commit_contents, :current_branch

  def initialize(name, owner)
    self.name = name
    self.owner = owner
    self.branches = {:master => nil}
    self.current_branch = :master
    self.commits = []

    self.working_directory = {
      :staged => [],
      :unstaged => [],
      :untracked => []
    }
  end

  def new_file(path, content)
    file = Git::File.new(path, content)
    working_directory[:untracked] << file
    file
  end

  def add(file)
    if working_directory[:untracked].include? file
      working_directory[:untracked].delete file
      working_directory[:staged] << file
    end
  end

  def commit(author)
    tracked_files = working_directory[:staged] + working_directory[:unstaged]
    contents = {}
    tracked_files.map do |file|
      contents[file.path] = file.content
    end

    self.previous_commit_contents = contents
    commit = Git::Commit.new(working_directory[:staged], author)
    commits << commit
    working_directory[:unstaged] = working_directory[:staged]
    working_directory[:staged] = []
    commit.parents << branches[current_branch]
    branches[current_branch] = commit
    commit
  end

  def new_branch(name)
    branches[name.to_sym] = []
  end

  def modified_files
    working_directory[:unstaged].select do |file|
      file.content != previous_commit_contents[file.path]
    end
  end
end
