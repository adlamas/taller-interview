class CreateReservation < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :book, null: false
      t.string :email, null: false
      t.string :status, null: false

      # add_index uniqueness [book, email]

      t.timestamps
    end
  end
end
