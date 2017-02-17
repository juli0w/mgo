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
c = Category.where(name: "Alimentação", code: 'restaurants').first_or_create
Category.where(name: "Lanchonetes", code: 'diners', ancestor_id: c.id).first_or_create
Category.where(name: "Pizzarias", code: 'pizza', ancestor_id: c.id).first_or_create
Category.where(name: "Fast Food", code: 'hotdogs', ancestor_id: c.id).first_or_create
Category.where(name: "Cafés", code: 'cafes', ancestor_id: c.id).first_or_create
Category.where(name: "Churrascarias", code: 'steak', ancestor_id: c.id).first_or_create
Category.where(name: "Japonês", code: 'japanese', ancestor_id: c.id).first_or_create

c = Category.where(name: "Vida noturna", code: 'nightlife').first_or_create
Category.where(name: "Bares", code: 'bars', ancestor_id: c.id).first_or_create
Category.where(name: "Casas de show", code: 'musicvenues', ancestor_id: c.id).first_or_create
Category.where(name: "Boates", code: 'danceclubs', ancestor_id: c.id).first_or_create

c = Category.where(name: "Serviços", code: 'localservices').first_or_create
Category.where(name: "Costureiras", code: 'sewingalterations', ancestor_id: c.id).first_or_create
Category.where(name: "Imóveis", code: 'realestate', ancestor_id: c.id).first_or_create
Category.where(name: "Materiais de construção", code: 'buildingsupplies', ancestor_id: c.id).first_or_create

c = Category.where(name: "Compras", code: 'shopping').first_or_create
Category.where(name: "Computadores", code: 'computers', ancestor_id: c.id).first_or_create
Category.where(name: "Casa e jardim", code: 'homeandgarden', ancestor_id: c.id).first_or_create
Category.where(name: "Shoppings", code: 'shoppingcenters', ancestor_id: c.id).first_or_create
# Category.create(name: "Esportivos", code: 'sportgoods', ancestor_id: c.id)
# Category.create(name: "Brinquedos", code: 'toys', ancestor_id: c.id)

c = Category.where(name: "Vida ativa", code: 'active').first_or_create
Category.where(name: "Clubes esportivos", code: 'sports_clubs', ancestor_id: c.id).first_or_create
Category.where(name: "Parques de diversão", code: 'amusementparks').first_or_create
Category.where(name: "Parques", code: 'parks').first_or_create
# Category.create(name: "Viagem", code: 'hotelstravel')

# User.delete_all
User.where(email: "admin@admin.com").first_or_create(password: "123123", password_confirmation: "123123")
