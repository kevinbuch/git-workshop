module Git
  class Commit
    attr_accessor :tree, :message, :parents

    def initialize(tree, message, *parents)
      self.tree = tree
      self.message = message
      self.parents = parents
    end
  end
end
