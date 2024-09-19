class CreateTask < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|

      t.string :title
      t.string :description
      t.integer :situation, default: 1
      t.date :estimated_time
      t.references :user

      t.timestamps
    end
  end
end
