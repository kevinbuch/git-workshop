module Git
  class Commit
    attr_accessor :tree, :author, :parents

    def initialize(tree, author, *parents)
      self.tree = tree
      self.author = author
      self.parents = parents
    end
  end
end
