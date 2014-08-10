require 'spec_helper'

describe Repository do
  let(:repo) { Repository.new 'name', 'owner' }

  it 'has an owner and a name' do
    expect(repo.name).to eq 'name'
    expect(repo.owner).to eq 'owner'
  end

  it 'starts with an empty list of commits and no files' do
    expect(repo.commits).to be_empty
    expect(repo.working_directory[:tracked][:staged]).to be_empty
    expect(repo.working_directory[:tracked][:unstaged]).to be_empty
    expect(repo.working_directory[:untracked]).to be_empty
  end

  describe 'branches' do
    it 'starts with a master branch that has no commits' do
      expect(repo.branches[:master]).to be_nil
    end

    it 'has a current branch' do
      expect(repo.current_branch).to eq :master
    end

    it 'can create a new branch' do
      repo.new_branch 'feature'

      expect(repo.branches).to include :master
      expect(repo.branches).to include :feature
    end
  end

  describe 'adding commits' do
    let(:first_commit)  { double 'commit' }
    let(:second_commit) { double 'commit' }

    it 'keeps track of all commits' do
      repo.add_commit(first_commit)
      repo.add_commit(second_commit)

      expect(repo.commits).to include first_commit
      expect(repo.commits).to include second_commit
    end

    it 'adds commits to the current branch' do
      repo.add_commit(first_commit)
      expect(repo.branches[:master]).to eq first_commit

      repo.add_commit(second_commit)
      expect(repo.branches[:master]).to eq second_commit
    end

    xit 'keeps track of the parent commit' do
      repo.add_commit(first_commit)
      repo.add_commit(second_commit)

      expect(second_commit.parents).to include first_commit
    end
  end
end
