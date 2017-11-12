class User < ApplicationRecord
  include SearchableModel

  belongs_to :organization, optional: true, counter_cache: true

  has_many :tag_lists, as: :taggable
  has_many :tags, through: :tag_lists

  has_many :assigned_tickets, foreign_key: "assignee_id", class_name: "Ticket"
  has_many :submitted_tickets, foreign_key: "submitter_id", class_name: "Ticket"

  def self.searchable_attributes
    (column_names - ["id", "updated_at", "organization_id"] + ["organization"])
  end

end
