require 'spec_helper'

describe Git do
  let(:owner)     { 'owner' }
  let(:repo_name) { 'repo_name' }
  let(:file)      { Git::File.new "/#{repo_name}/file/path", owner }

  before :each do
    Git::repositories = []
  end

  it 'starts with an empty list of repositories' do
    expect(Git::repositories).to be_empty
  end

  it 'knows what the current repo is' do
    first_repo = Git::init('first', owner)
    expect(Git::current_repo).to eq first_repo

    second_repo = Git::init('second', owner)
    expect(Git::current_repo).to eq second_repo
  end

  it 'can switch the current repo' do
    first_repo = Git::init('first', owner)
    Git::init('second', owner)
    Git::cd('first')

    expect(Git::current_repo).to eq first_repo
  end

  describe '#init' do
    it 'creates a new repository' do
      repo = Git::init(repo_name, owner)

      expect(repo.class).to be Repository
      expect(repo.name).to eq repo_name
      expect(repo.owner).to eq owner
      expect(Git::repositories.length).to be 1
    end
  end

  describe '#add' do
    it 'starts tracking files' do
      repo = Git::init(repo_name, owner)
      file = Git::File.new '/repo_name/path', 'content'

      expect(repo.working_directory[:untracked].length).to be 1
      expect(repo.working_directory[:tracked][:staged].length).to be 0
      expect(repo.working_directory[:tracked][:unstaged].length).to be 0

      Git::add(file)

      expect(repo.working_directory[:untracked].length).to be 0
      expect(repo.working_directory[:tracked][:staged].length).to be 1
      expect(repo.working_directory[:tracked][:unstaged].length).to be 0
    end
  end

  describe '#commit' do
    it 'adds a snapshot of files to the repo' do
      repo = Git::init(repo_name, owner)

      Git::add(file)
      Git::commit

      expect(repo.commits.length).to be 1
    end

    it 'clears the staging area' do
      repo = Git::init(repo_name, owner)

      Git::add(file)
      Git::commit

      expect(repo.working_directory[:tracked][:staged]).to be_empty
    end
  end

  describe '#checkout' do
    it 'clears the unstaged changes' do
      repo = Git::init(repo_name, owner)

      Git::add(file)
      Git::checkout(repo)

      expect(repo.working_directory[:tracked][:staged]).to be_empty
    end
  end
end
