require 'spec_helper'

describe Git::Commit do
  let(:author) { 'snoop' }
  let(:committer) { 'dre' }
  let(:tree) { double 'tree' }
  let(:parent_commit) { double 'commit' }

  it 'has a git tree, author, and committer' do
    commit = Git::Commit.new tree, author, committer

    expect(commit.tree).to eq tree
    expect(commit.author).to eq author
    expect(commit.committer).to eq committer
  end

  it 'has a parent commit' do
    commit = Git::Commit.new tree, author, committer, parent_commit

    expect(commit.parents).to include parent_commit
  end
end
