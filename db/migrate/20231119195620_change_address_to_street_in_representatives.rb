# frozen_string_literal: true

class ChangeAddressToStreetInRepresentatives < ActiveRecord::Migration[5.2]
  def change
    rename_column :representatives, :address, :street
  end
end
