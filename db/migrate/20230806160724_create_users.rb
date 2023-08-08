# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table(:users) do |t|
      t.string(:display_name)
      t.string(:email)
      t.string(:country)
      t.string(:birthdate)
      t.string(:spotify_user_id)
      t.string(:spotify_product)
      t.string(:spotify_followers)
      t.string(:spotify_access_token)
      t.string(:spotify_refresh_token)
      t.string(:spotify_profile_image_url)
      t.string(:spotify_profile_image_width)
      t.string(:spotify_profile_image_height)

      t.timestamps
    end
    add_index(:users, :spotify_user_id, unique: true)
  end
end
