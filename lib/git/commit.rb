module Git
  class Commit
    attr_accessor :tree, :author, :committer, :parents

    def initialize(tree, author, committer, *parents)
      self.tree = tree
      self.author = author
      self.committer = committer
      self.parents = parents
    end
  end
end
