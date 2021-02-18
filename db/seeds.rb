# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

csv_data = File.read(Rails.root.join('db/experts.csv').to_s)

csv = CSV.new(csv_data, headers: true, header_converters: :symbol, converters: :all)

Level.create!(name: "Врач высшей категори", level_status: 1)
Level.create!(name: "Врач вторая категори", level_status: 2)
Level.create!(name: "Врач третей категори", level_status: 3)

products_data = csv.to_a.map { |row| row.to_hash }

products_data.each do |item|

  category = Category.where(name: item[:category]).first_or_create!


  product = category.experts.create!(full_name: item[:full_name], description: item[:description],
  level_id: item[:level], experience: item[:experience], additional_education: item[:additional_education],
  procedure: item[:procedure], address: item[:address], medical_center: item[:medical_center],
  email: item[:email], phone: item[:phone], image: item[:image], hw_start_monday: item[:hw_start_monday],
  hw_end_monday: item[:hw_end_monday], hw_start_tuesday: item[:hw_start_tuesday],
  hw_end_tuesday: item[:hw_end_tuesday], hw_start_wednesday: item[:hw_start_wednesday],
  hw_end_wednesday: item[:hw_end_wednesday], hw_start_thursday: item[:hw_start_thursday],
  hw_end_thursday: item[:hw_end_thursday], hw_start_friday: item[:hw_start_friday],
  hw_end_friday: item[:hw_end_friday], hw_start_saturday: item[:hw_start_saturday],
  hw_end_saturday: item[:hw_end_saturday], hw_start_sunday: item[:hw_start_sunday],
  hw_end_sunday: item[:hw_end_sunday], education: item[:education])
  # product.attachment.attach(io: File.open(Rails.root.join('app', 'assets', 'images', item[:image])),
  #                           filename: item[:image])
end

AdminUser.first_or_create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
