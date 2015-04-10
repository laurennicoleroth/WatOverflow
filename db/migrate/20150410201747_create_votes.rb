class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :up, default: false
      t.boolean :down, default: false
      t.references :votable, polymorphic: true, index: true
      t.timestamps null:false
    end
  end
end
