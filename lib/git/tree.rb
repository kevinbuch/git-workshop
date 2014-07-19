module Git
  class Tree
    attr_accessor :files

    def initialize(files)
      self.files = files
    end
  end
end
