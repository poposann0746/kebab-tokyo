# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
require "csv"

csv_path = Rails.root.join("db", "seeds", "shops.csv")
raise "CSV not found: #{csv_path}" unless File.exist?(csv_path)

puts "Seeding shops from #{csv_path}..."

count_before = Shop.count

CSV.foreach(csv_path, headers: true) do |row|
  attrs = row.to_h.slice(
    "name", "address", "lat", "lng",
    "image_url1", "image_url2", "image_url3",
    "area"
  )

  # CSVは文字列なので、数値カラムは変換（空ならnil）
  attrs["lat"] = attrs["lat"].presence&.to_f
  attrs["lng"] = attrs["lng"].presence&.to_f

  # 増殖防止（MVP版）：name + address が同じなら同じ店舗扱い
  shop = Shop.find_or_initialize_by(
    name: attrs["name"],
    address: attrs["address"]
  )

  shop.assign_attributes(attrs)
  shop.save!
end

count_after = Shop.count
puts "Done. Shops: #{count_before} -> #{count_after}"
