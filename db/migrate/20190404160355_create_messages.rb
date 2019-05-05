class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :body
      t.string :response_body
      t.integer :user_id
      t.binary :image

      t.timestamps
    end
  end
end
