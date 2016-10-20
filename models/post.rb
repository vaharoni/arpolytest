class Post < ActiveRecord::Base
  has_many :assets, as: :attachable, dependent: :destroy
end
