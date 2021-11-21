class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :team_city
      t.string :team_name
      t.integer :division_id
      t.timestamps
    end
  end
end
