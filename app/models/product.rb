class Product < ActiveRecord::Base
  validates :merchant_id, presence: true
  validates :merchant_id, numericality: true
  validates :name, presence: true
  belongs_to :merchant
  has_many :order_items
  has_many :orders, through: :order_items
  has_and_belongs_to_many :categories
  # http://guides.rubyonrails.org/association_basics.html#the-has-and-belongs-to-many-association

end
