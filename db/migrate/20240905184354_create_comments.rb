class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|

      t.string :description
      t.references :commentable, polymorphic: true, null: false
      t.references :user

      t.timestamps
    end
  end
end
