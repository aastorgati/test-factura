class CreateQuotes < ActiveRecord::Migration[6.1]
  def change
    create_table :quotes do |t|
      t.decimal :document_rate
      t.decimal :commission
      t.decimal :advance_percent
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
