class CreateBinaries < ActiveRecord::Migration[7.1]
  def change
    create_table :binaries, id: :bigint do |t|
      t.string :title
      t.string :context

      t.timestamps
    end
  end
end
