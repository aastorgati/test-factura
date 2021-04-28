class Api::V1::InvoicesController < Api::V1::ApplicationController
    before_action :set_product, except: [:index, :quotation]

    def index
      @invoices = Invoice.all
      
      render json: @invoices, status: :ok
      
    end

    def create
      @invoice = Invoice.new(invoice_params)

      if @invoice.save
        render json: @invoice, status: :created
      else
        render json: {
          message: 'create failed',
          errors: @invoice.errors
        }, status: :unprocessable_entity
      end
    end

    def update
      if @invoice.update(invoice_params)
        render json: @invoice, status: :ok
      else
        render json: {
          message: 'update failed',
          errors: @invoice.errors
        }, status: :unprocessable_entity
      end
    end

    def quotation
      invoice = Invoice.find_by(invoice_params)
      if invoice.present?
        @quote = invoice.quotation
      end
      
      render json: @quote
    end

    private

    def set_invoice
        @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(
        :client_dni, :debtor_dni, :document_amount, :folio, 
        :expiration_date
      )
    end
end
