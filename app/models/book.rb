class Book < ActiveRecord::Base
  # enumを使うことでコード上ではわかりやすい文字列を使いつつActiveRecord側では数値に変換して使用可能に
  enum status: %W(reservation now_on_sale end_of_print)
  # ハッシュで明示的に数値を指定することも可能 enum status: { reservation: 0,  now_on_sale: 1, end_of_print: 2 }

  before_validation :add_lovely_to_cat

  scope :costly, -> { where("price > ?", 3000) }
  scope :written_about, ->(theme) { where("name like ?", "%#{theme}%",)}

  belongs_to :publisher

  has_many :book_authors
  has_many :authors, through: :book_authors

  validates :name, presence: true
  validates :name, length: { maximum: 15 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  # 独自のバリデーションを定義
  # validate do |book|
  #   if book.name.include?("exercise")
  #     book.errors[:name] << "I don't like exercise."
  #   end
  # end

  after_destroy :if => :high_price? do |book|
    Rails.logger.warn "Book with high price is deleted: #{book.attributes.inspect}"
    Rails.logger.warn "Please check"
  end

# pryで見ると大丈夫なのになぜかエラーになる
  def add_lovely_to_cat
    self.name = self.name.gsub(/Cat/) do |matched|
      "lovely #{matched}"
    end
  end

  def high_price?
    price >= 5000
  end
end
