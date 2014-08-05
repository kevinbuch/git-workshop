require 'spec_helper'

describe Git::Commit do
  let(:author) { 'snoop' }
  let(:tree) { double 'tree' }
  let(:parent_commit) { double 'commit' }

  it 'has a git tree and author' do
    commit = Git::Commit.new tree, author

    expect(commit.tree).to eq tree
    expect(commit.author).to eq author
  end

  it 'has a parent commit' do
    commit = Git::Commit.new tree, author, parent_commit

    expect(commit.parents).to include parent_commit
  end
end
