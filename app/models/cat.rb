class Cat < ApplicationRecord
  belongs_to :shop

  enum tail_type: {
    '長い尻尾': '長い尻尾',
    'かぎしっぽ': 'かぎしっぽ',
    'ボブテイル': 'ボブテイル'
  }
end
