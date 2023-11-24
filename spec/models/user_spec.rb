require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'methods' do
    describe '#name' do
      it 'returns a users name' do
        u = described_class.create(first_name: 'Brevin', last_name: 'Smider', provider: :google_oauth2, uid: '001')
        expect(u.name).to eq('Brevin Smider')
      end
    end

    describe '#auth_provider' do
      it 'testing that a users authentication provider is google' do
        u = described_class.create(provider: :google_oauth2, uid: '001')
        expect(u.auth_provider).to eq('Google')
      end

      it 'testing that a users authentication provider is github' do
        u = described_class.create(provider: :github, uid: '001')
        expect(u.auth_provider).to eq('Github')
      end
    end

    describe '.find_google_user' do
      it 'returns a user found through a google UID' do
        u = described_class.create(provider: :google_oauth2, uid: '001')
        expect(described_class.find_google_user('001')).to eq(u)
      end
    end

    describe '.find_github_user' do
      it 'returns a user found through a github UID' do
        u = described_class.create(provider: :github, uid: '001')
        expect(described_class.find_github_user('001')).to eq(u)
      end
    end
  end
end