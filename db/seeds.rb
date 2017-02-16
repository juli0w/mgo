# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ['Material de construção', 'Alimentação', 'Lazer', 'Saúde', 'Serviços'].each do |category|
#   Category.create(name: category)
# end

Category.delete_all
c = Category.create(name: "Alimentação", code: 'restaurants')
Category.create(name: "Lanchonetes", code: 'diners', ancestor_id: c.id)
Category.create(name: "Pizzarias", code: 'pizza', ancestor_id: c.id)
Category.create(name: "Fast Food", code: 'hotdogs', ancestor_id: c.id)
Category.create(name: "Cafés", code: 'cafes', ancestor_id: c.id)
Category.create(name: "Churrascarias", code: 'steak', ancestor_id: c.id)
Category.create(name: "Japonês", code: 'japanese', ancestor_id: c.id)

c = Category.create(name: "Vida noturna", code: 'nightlife')
Category.create(name: "Bares", code: 'bars', ancestor_id: c.id)
Category.create(name: "Casas de show", code: 'musicvenues', ancestor_id: c.id)
Category.create(name: "Boates", code: 'danceclubs', ancestor_id: c.id)

c = Category.create(name: "Serviços", code: 'localservices')
Category.create(name: "Costureiras", code: 'sewingalterations', ancestor_id: c.id)
Category.create(name: "Imóveis", code: 'realestate', ancestor_id: c.id)
Category.create(name: "Materiais de construção", code: 'buildingsupplies', ancestor_id: c.id)

c = Category.create(name: "Compras", code: 'shopping')
Category.create(name: "Computadores", code: 'computers', ancestor_id: c.id)
Category.create(name: "Casa e jardim", code: 'homeandgarden', ancestor_id: c.id)
# Category.create(name: "Esportivos", code: 'sportgoods', ancestor_id: c.id)
# Category.create(name: "Brinquedos", code: 'toys', ancestor_id: c.id)

c = Category.create(name: "Vida ativa", code: 'active')
Category.create(name: "Clubes esportivos", code: 'sports_clubs', ancestor_id: c.id)
Category.create(name: "Parques de diversão", code: 'amusementparks')
Category.create(name: "Parques", code: 'parks')
# Category.create(name: "Viagem", code: 'hotelstravel')

User.delete_all
User.create(email: "admin@admin.com", password: "123123", password_confirmation: "123123")
