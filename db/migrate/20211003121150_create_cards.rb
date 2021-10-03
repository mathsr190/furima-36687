class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.integer   :number,    null: false
      t.integer   :exp_month, null: false
      t.integer   :exp_year,  null: false
      t.integer   :cvc,       null: false
      t.timestamps
    end
  end
end
