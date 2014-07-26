require 'spec_helper'

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
      file = Git::File.new '/repo_name/path', 'content'

      expect(repo.working_directory[:untracked].length).to be 1
      expect(repo.working_directory[:tracked][:staged].length).to be 0
      expect(repo.working_directory[:tracked][:unstaged].length).to be 0

      Git::add(file, repo)

      expect(repo.working_directory[:untracked].length).to be 0
      expect(repo.working_directory[:tracked][:staged].length).to be 1
      expect(repo.working_directory[:tracked][:unstaged].length).to be 0
    end
  end

  describe '#commit' do
    it 'adds a snapshot of files to the repo' do
      repo = Git::init('repo_name', 'owner')
      file1 = Git::File.new '/repo_name/path1', 'content1'
      file2 = Git::File.new '/repo_name/path2', 'content2'

      Git::add(file1, repo)
      Git::add(file2, repo)
      Git::commit(repo)

      expect(repo.commits.length).to be 1
    end

    it 'clears the staging area' do
      repo = Git::init('repo_name', 'owner')
      file1 = Git::File.new '/repo_name/path1', 'content1'
      file2 = Git::File.new '/repo_name/path2', 'content2'

      Git::add(file1, repo)
      Git::add(file2, repo)
      Git::commit(repo)

      expect(repo.working_directory[:tracked][:staged]).to be_empty
    end
  end
end
