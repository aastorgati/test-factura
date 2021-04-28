class Invoice < ApplicationRecord
    def quotation
        Quote.where(invoice_id: self.id).size > 0 ? Quote.where(invoice_id: self.id).last : []
    end
end
