module Git
  class File < Struct.new(:path, :content)
  end
end
