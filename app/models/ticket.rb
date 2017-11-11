class Ticket < ApplicationRecord
  belongs_to :submitter, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :organization, optional: true
  has_many :tag_lists, as: :taggable
  has_many :tags, through: :tag_lists

  enum ticket_type: %i(incident problem question task)
  enum priority: %i(low normal high urgent)
  enum status: %i(open pending hold solved closed)
  enum via: %i(web chat voice)
end
