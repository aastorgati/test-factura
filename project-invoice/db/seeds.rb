
Invoice.create!(client_dni: '76329692-K', debtor_dni: '77360390-1', document_amount: 1000000, folio: 75, 
   expiration_date: '2021-05-27')
Quote.create!(document_rate: 1.9, commission: 23990, advance_percent: 90, invoice_id: 1)
Quote.create!(document_rate: 1.5, commission: 23990, advance_percent: 99, invoice_id: 1)
Quote.create!(document_rate: 1.9, commission: 23990, advance_percent: 99, invoice_id: 1)
User.create!(name: 'admin', email: 'test@test.cl', password: 'admin123', password_confirmation: 'admin123')
