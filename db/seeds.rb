# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.create(name: 'Dog Chews', published: true, category: 'otc')
Product.create(name: 'Catnip', published: true, category: 'otc')
Product.create(name: 'Aspirin', published: true, category: 'otc')
Product.create(name: 'Benadryl', published: true, category: 'otc')
Product.create(name: 'Penicillin', published: true, category: 'prescription')
Product.create(name: 'Steroid Creme', published: true, category: 'prescription')
Product.create(name: 'Carfentanil', published: true, category: 'restricted')