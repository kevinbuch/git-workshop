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

  it 'starts with a master branch that has no commits' do
    expect(repo.branches[:master]).to be_nil
  end

  xit 'can add commits to the current branch' do
    first_commit = double 'first_commit'
    second_commit = double 'second_commit'

    repo.add_commit(first_commit)
    repo.add_commit(second_commit)

    expect(repo.commits[repo.current_branch]).to include first_commit
    expect(repo.commits[repo.current_branch]).to include second_commit
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
