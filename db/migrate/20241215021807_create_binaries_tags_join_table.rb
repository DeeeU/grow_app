class CreateBinariesTagsJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_join_table :binaries, :tags do |t|
      t.index :binary_id
      t.index :tag_id
    end
  end
end
