# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'methods' do
    let!(:google_user) do
      described_class.create(provider: :google_oauth2, uid: '001', first_name: 'Brevin', last_name: 'Smider')
    end
    let!(:github_user) do
      described_class.create(provider: :github, uid: '001', first_name: 'Brevin', last_name: 'Smider')
    end

    describe '#name' do
      it 'returns a users name' do
        expect(google_user.name).to eq('Brevin Smider')
      end
    end

    describe '#auth_provider' do
      it 'returns Google as the auth provider' do
        expect(google_user.auth_provider).to eq('Google')
      end

      it 'returns Github as the auth provider' do
        expect(github_user.auth_provider).to eq('Github')
      end
    end

    describe '.find_google_user' do
      it 'returns a user found through a google UID' do
        expect(described_class.find_google_user('001')).to eq(google_user)
      end
    end

    describe '.find_github_user' do
      it 'returns a user found through a github UID' do
        expect(described_class.find_github_user('001')).to eq(github_user)
      end
    end
  end
end
