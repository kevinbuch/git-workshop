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
