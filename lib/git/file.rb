module Git
  class File
    attr_accessor :path, :content, :history

    def initialize(path, content)
      self.path = path
      self.content = content
      self.history = [content]
    end

    def update(new_content)
      self.history << new_content
      self.content = new_content
    end
  end
end
