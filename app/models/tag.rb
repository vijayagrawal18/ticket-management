class Tag < ApplicationRecord
  has_many :tag_lists
  has_many :organizations, :through => :tag_lists, :source => :taggable,
           :source_type => 'Organization'

  has_many :users, :through => :tag_lists, :source => :taggable,
           :source_type => 'User'
end
