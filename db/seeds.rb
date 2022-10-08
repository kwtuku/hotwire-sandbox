10.times do
  Post.create!(
    [
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
  )
end
