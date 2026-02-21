# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "seedの実行を開始します..."

genre_names = ['和菓子', '洋菓子', 'パン']

genres = genre_names.map do |name|
  Genre.find_or_create_by!(name: name)
end

puts "ジャンルのデータ登録が完了しました。"

# test userの作成
test_user1 = User.find_or_create_by!(email: "test-user1@example.com") do |u|
  u.name = "test_user1"
  u.password = "password"
end

test_user2 = User.find_or_create_by!(email: "test-user2@example.com") do |u|
  u.name = "test_user2"
  u.password = "password"
end

puts "ユーザーのデータ登録が完了しました。"

Post.find_or_create_by!(title: "マカロン") do |p|
  p.image = ActiveStorage::Blob.create_and_upload!(
    io: File.open(Rails.root.join("app/assets/images/macarons.jpg")), filename: "macarons.jpg" )
  p.genre_id = genres[1].id # 洋菓子
  p.user_id = test_user1.id
end

Post.find_or_create_by!(title: "どら焼き") do |p|
  p.image = ActiveStorage::Blob.create_and_upload!(
    io: File.open(Rails.root.join("app/assets/images/dorayaki.jpeg")), filename: "dorayaki.jpeg" )
  p.genre_id = genres[0].id # 和菓子
  p.user_id = test_user2.id
end

puts "テストデータの登録が完了しました。"
puts "seedの実行が完了しました！"