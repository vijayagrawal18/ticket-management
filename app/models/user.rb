class User < ApplicationRecord
  has_many :tag_lists, as: :taggable
  has_many :tags, through: :tag_lists

  belongs_to :organization, optional: true
  has_many :assigned_tickets, foreign_key: "assignee_id", class_name: "Ticket"
  has_many :submitted_tickets, foreign_key: "submitter_id", class_name: "Ticket"

end