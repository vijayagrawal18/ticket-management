class TagList < ApplicationRecord
  belongs_to :tag
  belongs_to :taggable, polymorphic: true

  scope :having_all,  -> tag_ids, taggable_type {
    where(tag_id: tag_ids, taggable_type: taggable_type).group(:taggable_id)
                                                        .having("count('id') = ?", tag_ids.count)
  }
end
