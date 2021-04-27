node(:code) {|o| o.code.presence }
node(:name) {|o| o.name.presence }
node(:brand) {|o| o.brand.presence }
node(:count) {|o| o.count.to_i.presence }
node(:price) {|o| o.price.to_f.presence }
node(:created_at) {|o| o.created_at.strftime('%d-%m-%Y %H:%M').presence }
node(:updated_at) {|o| o.updated_at.strftime('%d-%m-%Y %H:%M').presence }
node(:category) do |o|
  if o.category.present?
    o.category.name.presence
  end
end