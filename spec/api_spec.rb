require 'git/repository'
require 'git/file'
require 'api'
require 'pry'

describe Git do
  before :each do
    Git::repositories = []
  end

  it 'starts with an empty list of repositories' do
    expect(Git::repositories).to be_empty
  end

  describe '#init' do
    it 'creates a new repository' do
      repo = Git::init('project_name', 'owner')

      expect(Git::repositories.length).to be 1
      expect(repo.class).to be Repository
      expect(repo.name).to eq 'project_name'
      expect(repo.owner).to eq 'owner'
    end
  end

  describe '#add' do
    it 'starts tracking files' do
      repo = Git::init('repo_name', 'owner')
      file = Git::File.new 'path', 'content', 'repo_name'

      expect(repo.working_directory[:untracked].length).to be 1
      expect(repo.working_directory[:tracked][:staged].length).to be 0
      expect(repo.working_directory[:tracked][:unstaged].length).to be 0

      Git::add(file, repo)
      repo = Git::repositories.first

      expect(repo.working_directory[:untracked].length).to be 0
      expect(repo.working_directory[:tracked][:staged].length).to be 1
      expect(repo.working_directory[:tracked][:unstaged].length).to be 0
    end
  end
end
