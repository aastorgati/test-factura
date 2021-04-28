require 'rest-client'
require 'json'

class Factura
    def initialize(client_dni='76329692-K', debtor_dni='77360390-1', document_amount=1000000, folio=75, 
        expiration_date='2020-11-30')
        @client_dni = client_dni
        @debtor_dni = debtor_dni
        @document_amount = document_amount
        @folio = folio
        @expiration_date = expiration_date
    end
    def ingresar
        p 'ingresa el folio'

    end
end

class Usuario
    attr_accessor :email, :password
    def initialize(email='test@test.cl', password='admin123')
        @email = email
        @password = password
    end
end

usuario = Usuario.new()
response_login = RestClient.post 'http://localhost:3000/api/v1/login', {email: usuario.email, password: usuario.password}.to_json, {content_type: :json, accept: :json}
if response_login.code == 200
    token = JSON.parse(response_login)["token"]
    begin
        response = RestClient.get 'http://localhost:3000/api/v1/invoices', {"X-Api-Key": token,content_type: :json, accept: :json}
        if response.code == 200
            p "......>response: #{JSON.parse(response)}"
        end
    rescue RestClient::ExceptionWithResponse => e
        if e.response.code == 401
            p ".......>no esta autorizado a revisar esta opcion sin token"
        end
    end
    
end


# rails g model Invoice client_dni:string debtor_dni:string document_amount:decimal folio:integer expiration_date:date
