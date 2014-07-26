require 'spec_helper'

describe Git::File do
  let(:file) { Git::File.new '/repo_name/fake/filepath', 'content' }

  before :each do
    create_repository 'repo_name'
  end

  it 'gets the repo name from the filepath' do
    expect(file.path).to eq '/fake/filepath'
    expect(file.content).to eq 'content'
  end

  it 'has a history' do
    file.update 'new content'

    expect(file.history.length).to be 2
  end

  it 'only accepts filepaths that start with a slash' do
    pending "`expect(_).to raise_error` isn't working"
    # not working for some reason...
    expect(Git::File.new('invalid_filepath', 'content')).to raise_error
  end
end
