class Repository
  attr_accessor :owner, :commits, :working_directory, :name

  def initialize(name, owner)
    self.name = name
    self.owner = owner
    self.commits = []
    self.working_directory = {
      :tracked => {
        :staged => [],
        :unstaged => []
      },
      :untracked => []
    }
  end
end
