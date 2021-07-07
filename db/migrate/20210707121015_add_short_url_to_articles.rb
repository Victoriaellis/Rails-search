class AddShortUrlToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :short_url, :string
  end
end
