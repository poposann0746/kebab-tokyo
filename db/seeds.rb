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

# ── レビューのシードデータ ──
puts "Seeding reviews..."

# テスト用ユーザーを作成（既存なら再利用）
test_users = 5.times.map do |i|
  User.find_or_create_by!(email: "test#{i + 1}@example.com") do |u|
    u.password = "password123"
  end
end

categories = Review.categories.keys
meat_types = Review.meat_types.keys
sauce_types = Review.sauce_types.keys

comments = [
  "肉がジューシーで最高でした！",
  "ソースの辛さがちょうどいい。リピ確定。",
  "野菜たっぷりでヘルシー感あり。",
  "コスパ良し。ランチにぴったり。",
  "パンがモチモチで美味しかった。",
  "ボリューム満点！お腹いっぱいになります。",
  "スパイシーで本格的な味わい。",
  "友達にもおすすめしたい一品。",
  "深夜に食べるケバブは格別。",
  "チキンとビーフのミックスが一番好き。"
]

review_count_before = Review.count

Shop.find_each do |shop|
  10.times do |i|
    user = test_users[i % test_users.size]

    # 同一ユーザー・同一店舗で重複作成を防止
    next if Review.exists?(user: user, shop: shop, comment: comments[i])

    Review.create!(
      user: user,
      shop: shop,
      category: categories.sample,
      meat_type: meat_types.sample,
      sauce_type: sauce_types.sample,
      overall_score: rand(1..10),
      meat_taste: rand(1..5),
      sauce_taste: rand(1..5),
      vegetable_amount: rand(1..5),
      bread_compatibility: rand(1..5),
      value_for_money: rand(1..5),
      comment: comments[i]
    )
  end
end

review_count_after = Review.count
puts "Done. Reviews: #{review_count_before} -> #{review_count_after}"
