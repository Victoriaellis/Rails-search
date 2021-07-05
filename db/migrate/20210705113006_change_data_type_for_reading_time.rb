class ChangeDataTypeForReadingTime < ActiveRecord::Migration[6.0]
  def change
    change_column :articles, :reading_time, :string
  end
end
