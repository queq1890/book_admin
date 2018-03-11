module ApplicationHelper
  # ヘルパー描くの初めてかもしれない
  def to_hankaku(str)
    str.tr('Ａ-Ｚａ-ｚ', 'A-Za-z')
  end
end
