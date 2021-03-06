class Article < ApplicationRecord
  validates :title, :url, presence: true
  include PgSearch::Model
  pg_search_scope :search_by_title_and_body, against: [:title, :body]
end
