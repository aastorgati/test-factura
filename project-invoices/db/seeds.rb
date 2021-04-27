User.create!(email: 'test@ksec.cl', password: 'admin123')
category = Category.create!(code: 'c1', name: 'lacteos')
Product.create!(code: 'p1', name: 'leche', brand: 'colun', count: 1, price: 900, category_id: category.id)
