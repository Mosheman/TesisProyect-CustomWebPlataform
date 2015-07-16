class CreateTwitterCredentials < ActiveRecord::Migration
  def change
    create_table :twitter_credentials do |t|
      t.string :consumer_key,  null: false
      t.string :consumer_secret,  null: false
      t.string :access_token
      t.string :access_token_secret
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
