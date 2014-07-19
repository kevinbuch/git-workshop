require 'git/repository'

module Git

  def self.repositories
    @repositories ||= []
  end

  def self.init
    repo = Repository.new 'owner'
    @repositories << repo
  end

end
