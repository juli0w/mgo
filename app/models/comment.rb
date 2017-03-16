class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  default_scope -> { order('created_at ASC') }

  def owner? current_user
    user == current_user || (current_user and current_user.admin?)
  end
end
