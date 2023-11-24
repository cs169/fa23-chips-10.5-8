# frozen_string_literal: true

Before('@load-seed-data') do
  # rubocop:disable Rails/FilePath
  load Rails.root.join('db', 'seeds.rb').to_s
  # rubocop:enable Rails/FilePath
end
