class CreateDivisions < ActiveRecord::Migration[6.1]
  def change
    create_table :divisions do |t|
      t.string :division_name
      t.integer :league_id
      t.timestamps
    end
  end
end
