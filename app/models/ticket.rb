class Ticket < ApplicationRecord
  include SearchableModel

  has_many :tag_lists, as: :taggable
  has_many :tags, through: :tag_lists

  belongs_to :submitter, class_name: 'User', counter_cache: :submitted_tickets_count
  belongs_to :assignee, class_name: 'User', optional: true, counter_cache: :assigned_tickets_count
  belongs_to :organization, optional: true, counter_cache: true

  enum ticket_type: %i(incident problem question task)
  enum priority: %i(low normal high urgent)
  enum status: %i(open pending hold solved closed)
  enum via: %i(web chat voice)

  def self.searchable_attributes
    @@_searchable_attributes ||= begin
      non_searchables = ["id", "updated_at"]

      column_names - non_searchables + [TAG_FIELD]
    end
  end

  def self.search_by(field, term)
    case field
    when "submitter_id", "assignee_id"
      if term.present?
        value = User.where(_id: term)
      else
        value = nil
      end

      where(field => value)
    else
      super(field, term)
    end
  end
end
