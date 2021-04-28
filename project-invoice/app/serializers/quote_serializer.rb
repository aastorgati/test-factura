class QuoteSerializer < ActiveModel::Serializer
  attributes :document_rate, :commission, :advance_percent
end
