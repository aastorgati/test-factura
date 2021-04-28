require 'rest-client'
require 'json'

class Usuario
    attr_accessor :email, :password
    def initialize(email='test@test.cl', password='admin123')
        @email = email
        @password = password
    end
end

class Factura
    attr_accessor :client_dni, :debtor_dni, :document_amount, :folio, :expiration_date
    def initialize(client_dni='76329692-K', debtor_dni='77360390-1', document_amount=1000000, folio=75, 
        expiration_date='2021-05-27')
        @client_dni = client_dni
        @debtor_dni = debtor_dni
        @document_amount = document_amount
        @folio = folio
        @expiration_date = expiration_date
    end
end

class Cotizacion
    attr_accessor :document_rate, :commission, :advance_percent
    def initialize(document_rate, commission, advance_percent)
        @document_rate = document_rate
        @commission = commission
        @advance_percent = advance_percent
    end
end

usuario = Usuario.new()
response_login = RestClient.post 'http://localhost:3000/api/v1/login', {email: usuario.email, password: usuario.password}.to_json, {content_type: :json, accept: :json}
if response_login.code == 200
    token = JSON.parse(response_login)["token"]
    factura = Factura.new()
    begin
        response = RestClient.post 'http://localhost:3000/api/v1/quotation', 
        {
            client_dni: factura.client_dni,
            debtor_dni: factura.debtor_dni,
            document_amount: factura.document_amount,
            folio: factura.folio,
            expiration_date: factura.expiration_date
        }.to_json, {"X-Api-Key": token,content_type: :json, accept: :json}
        if response.code == 200
            res_cotizacion = JSON.parse(response)
            cotizacion = Cotizacion.new(res_cotizacion["document_rate"].to_f, res_cotizacion["commission"].to_f, res_cotizacion["advance_percent"].to_f)
            expiration_date = DateTime.parse(factura.expiration_date)
            coaunt_days = (expiration_date.to_date - DateTime.now.to_date).to_i + 1
            costo_financiamiento = factura.document_amount * (cotizacion.advance_percent/100) * ((cotizacion.document_rate/100) / 30 * coaunt_days)
            giro_recibir = (factura.document_amount * (cotizacion.advance_percent/100)) - (costo_financiamiento + cotizacion.commission)
            excedentes = factura.document_amount - (factura.document_amount * (cotizacion.advance_percent/100))

            p "Costo de financiamiento: $#{costo_financiamiento}"
            p "Giro a recibir: $#{giro_recibir}"
            p "Excedentes: $#{excedentes}"
        end
    rescue RestClient::ExceptionWithResponse => e
        if e.response.code == 401
            p "No esta autorizado a revisar esta opcion sin token"
        end
    end
    
end

# rails g model quote document_rate:decimal commission:decimal advance_percent:decimal invoice:references
# rails g model Invoice client_dni:string debtor_dni:string document_amount:decimal folio:integer expiration_date:date
