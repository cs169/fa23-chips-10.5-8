# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []
    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = title_temp = ''
      rep_info.offices.each do |office|
        if office.official_indices.include?(index)
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end
      address = official.address&.first
      street, city, state, zip = address ? [address.line1, address.city, address.state, address.zip] : ['', '', '', '']
      rep = Representative.find_or_initialize_by({ name: official.name, ocdid: ocdid_temp, title: title_temp,
street: street, city: city, state: state, zip: zip, political_party: official.party, photo: official.photo_url })
      rep.save if rep.new_record?
      reps.push(rep)
    end
    reps
  end
end
