class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.string :client_dni
      t.string :debtor_dni
      t.decimal :document_amount
      t.integer :folio
      t.date :expiration_date

      t.timestamps
    end
  end
end
