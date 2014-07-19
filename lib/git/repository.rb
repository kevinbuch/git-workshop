class Repository
  attr_accessor :owner, :commits, :working_directory

  def initialize(owner)
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
