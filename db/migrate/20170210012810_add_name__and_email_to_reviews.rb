class AddNameAndEmailToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :name, :string
    add_column :reviews, :email, :string
  end
end
