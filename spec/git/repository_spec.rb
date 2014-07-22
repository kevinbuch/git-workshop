require 'git/repository'

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
end
