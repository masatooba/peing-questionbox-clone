class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :nickname
      t.string :image
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
