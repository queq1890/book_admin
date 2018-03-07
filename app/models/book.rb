class Book < ActiveRecord::Base
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

# pryで見ると大丈夫なのになぜかエラーになる
  def add_lovely_to_cat
    self.name = self.name.gsub(/Cat/) do |matched|
      "lovely #{matched}"
    end
  end
end
