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
  Post.create!(contents.shuffle)
end

Post.roots.last(10).each_with_index do |post, index|
  post.children.create!(contents.shuffle)

  next unless index >= 7

  post.children.each do |child_post|
    child_post.children.create!(contents.shuffle)
  end
end
