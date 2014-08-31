require 'spec_helper'

describe Git::Commit do
  let(:tree)          { ['files'] }
  let(:message)       { 'this is a commit' }
  let(:parent_commit) { double 'commit' }

  it 'has a git tree, commit_message, and sha' do
    commit = Git::Commit.new tree, message

    expect(commit.tree).to eq tree
    expect(commit.message).to eq message
    expect(commit.sha.length).to eq 7
  end

  it 'has a parent commit' do
    commit = Git::Commit.new tree, message, parent_commit

    expect(commit.parents).to include parent_commit
  end
end
