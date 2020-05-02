class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :game, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.datetime :returned_time
      t.datetime :return_time

      t.timestamps
    end
  end
end
