# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['Material de construção', 'Alimentação', 'Lazer', 'Saúde', 'Serviços'].each do |category|
  Category.create(name: category)
end

Company.create({ name: 'Loja do Pintor', category: Category.find_by_name('Material de construção'),
                 description: 'Tudo em tintas imobiliárias e automotivas' })

Company.create({ name: 'Gilson Schelbauer', category: Category.find_by_name('Serviços'),
                 description: 'Advogado criminal' })

User.create(email: "admin@admin.com", password: "123123", password_confirmation: "123123")
