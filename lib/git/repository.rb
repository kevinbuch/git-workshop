class Repository
  attr_reader :name, :commits, :staged, :branches

  def initialize(name)
    @name = name
    @commits = []
    @files = []
    @staged = []
    @branches = {:master => nil}
  end

  def HEAD
    :master
  end

  def branch(name, option = nil)
    @branches[name] = @commits.last
    case option
    when :D
      @branches.delete(name)
    end
  end

  def previous_commit_contents
    @commits.last.tree.reduce({}) do |memo, file|
      memo[file.path] = file.content
      memo
    end
  end

  def unstaged
    if @commits.empty?
      []
    else
      modified_files
    end
  end

  def untracked
    @files.select do |file|
      if commit = @commits.last
        !commit.tree.find do |f|
          f.path == file.path
        end
      else
        !@staged.include?(file)
      end
    end
  end

  def new_file(path, content)
    file = Git::File.new(path, content)
    @files << file
    file
  end

  def add(file)
    @staged << file
  end

  def commit(message)
    @commits << Git::Commit.new(
      @staged.map(&:dup),
      message,
      @commits.last
    )
    @staged = []
    @commits.last
  end

  def modified_files
    @files.select do |file|
      match = @commits.last.tree.find { |f| f.path == file.path }
      if match
        match.content != file.content &&
          !@staged.include?(file)
      end
    end
  end
end
