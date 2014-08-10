class Repository
  attr_accessor :owner, :branches, :commits, :working_directory, :name

  def initialize(name, owner)
    self.name = name
    self.owner = owner
    self.branches = {:master => nil}
    self.commits = []

    self.working_directory = {
      :tracked => {
        :staged => [],
        :unstaged => []
      },
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
      working_directory[:tracked][:staged] << file
    end
  end

  def add_commit(commit)
    commits << commit
    branches[:master] = commit
  end

  def new_branch(name)
    branches[name.to_sym] = []
  end

  def current_branch
    :master
  end
end
