require 'spec_helper'

describe Git::Tree do
  it 'has many git files' do
    files = [1,2,3]
    tree = Git::Tree.new files

    expect(tree.files.length).to eq 3
  end
end
