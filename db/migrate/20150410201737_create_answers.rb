class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body, null: false
      t.boolean :best, default: false
      t.references :user, null: false
      t.references :question, null: false
      t.timestamps null: false
    end
  end
end
