# frozen_string_literal: true

class NewsItem < ApplicationRecord
  belongs_to :representative
  has_many :ratings, dependent: :delete_all

  VALID_ISSUES = ['Free Speech', 'Immigration', 'Terrorism', 'Social Security and Medicare', 'Abortion',
                  'Student Loans', 'Gun Control', 'Unemployment', 'Climate Change', 'Homelessness',
                  'Racism', 'Tax Reform', 'Net Neutrality', 'Religious Freedom', 'Border Security',
                  'Minimum Wage', 'Equal Pay'].freeze

  def self.find_for(representative_id)
    NewsItem.find_by(
      representative_id: representative_id
    )
  end

  validates :issue, inclusion: { in: VALID_ISSUES, allow_blank: true }
end
