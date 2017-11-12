class Ticket < ApplicationRecord
  include SearchableModel

  belongs_to :submitter, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :organization, optional: true
  has_many :tag_lists, as: :taggable
  has_many :tags, through: :tag_lists

  enum ticket_type: %i(incident problem question task)
  enum priority: %i(low normal high urgent)
  enum status: %i(open pending hold solved closed)
  enum via: %i(web chat voice)

  def self.searchable_attributes
    non_searchables = ["id", "updated_at", "submitter_id", "assignee_id", "organization_id"]
    additional_searchables = ["submitter", "assignee", "organization"]

    column_names - non_searchables + additional_searchables
  end

  def self.search_by(field, term)
    case field
    when "submitter", "assignee"
      if term.present?
        joins(field.to_sym).where("users.name = ?", term)
      else
        where(field => nil)
      end
    else
      super(field, term)
    end
  end

end
