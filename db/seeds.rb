User.destroy_all
Post.destroy_all
Like.destroy_all

alice = User.create!(
  email: 'alice@example.com',
  password: 'password',
  confirmed_at: Time.current,
  name: 'アリス',
  username: 'alice',
  description: 'アリスです'
)
bob = User.create!(
  email: 'bob@example.com',
  password: 'password',
  confirmed_at: Time.current,
  name: 'ボブ',
  username: 'bob'
)

contents = [
  { content: 'a' * 300 },
  { content: 'おはよう' },
  { content: 'こんにちは' },
  { content: 'こんばんは' },
  { content: 'アンニョンハセヨ' },
  { content: 'オラ' },
  { content: 'ナマステ' },
  { content: 'ニーハオ' },
  { content: 'ボンジュール' },
  { content: 'ボンジョルノ' }
]

10.times do
  attributes = contents.map { |content| { user: [alice, bob].sample }.merge(content) }
  Post.create!(attributes.shuffle)
end

Post.roots.last(10).each_with_index do |post, index|
  attributes = contents.map { |content| { user: [alice, bob].sample }.merge(content) }
  post.children.create!(attributes.shuffle)

  next unless index >= 7

  post.children.each do |child_post|
    attributes = contents.map { |content| { user: [alice, bob].sample }.merge(content) }
    child_post.children.create!(attributes.shuffle)
  end
end

posts = Post.roots.last(10)
50.times do |n|
  user = User.create!(
    email: "user#{n}@example.com",
    password: 'password',
    confirmed_at: Time.current,
    name: "user#{n}",
    username: "user#{n}"
  )

  posts.each do |post|
    user.likes.create!(post: post)
  end
end
