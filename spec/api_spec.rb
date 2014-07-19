require 'git/repository'
require 'api'

describe Git do
  it 'starts with an empty list of repositories' do
    expect(Git::repositories).to be_empty
  end

  describe '#init' do
    it 'creates a new repository' do
      Git::init

      expect(Git::repositories.length).to be 1
      expect(Git::repositories.first.class).to be Repository
    end
  end
end
