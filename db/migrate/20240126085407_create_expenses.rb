class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.string :name
      t.date :date
      t.float :amount
      t.text :description

      t.timestamps
    end
  end
end
