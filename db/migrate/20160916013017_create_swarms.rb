class CreateSwarms < ActiveRecord::Migration[5.0]
  def change
    create_table :swarms do |t|
      t.string :swarm_id
      t.string :name
      t.string :swarm_nodes
    end
    add_index :swarms, :swarm_id, unique: true
  end
end
