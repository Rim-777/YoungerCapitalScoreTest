class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.float :score_from
      t.float :score_to
      t.string :name

      t.timestamps null: false
    end
  end
end
