class CreateTags < ActiveRecord::Migration[7.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.string :color, null:false, default: '#FFFFFF'
      t.string :context

      t.timestamps
    end
  end
end
