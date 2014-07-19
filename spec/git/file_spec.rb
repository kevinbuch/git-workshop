require 'git/file'

describe Git::File do
  it 'has a path and content' do
    file = Git::File.new '/fake/filepath', 'content'

    expect(file.path).to eq '/fake/filepath'
    expect(file.content).to eq 'content'
  end

  it 'has a history' do
    file = Git::File.new '/fake/filepath', 'content'

    file.update 'new content'

    expect(file.history.length).to be 2
  end
end
