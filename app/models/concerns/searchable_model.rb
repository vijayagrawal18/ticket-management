module SearchableModel
  extend ActiveSupport::Concern

  module ClassMethods

    def search_by(field, term)
      term = cast(field, term)

      case field
      when "tag", "domain", "organization_id"
        send "search_by_#{field}", term
      when *column_names
        generic_search_by field, term
      else
        all
      end
    end

    def boolean_columns
      columns_for "boolean"
    end

    def datetime_columns
      columns_for "datetime"
    end

    def columns_for(type)
      columns.select do |col|
        col.sql_type == type
      end.map do |col|
        col.name
      end
    end

    def boolify(term)
      if term == "true"
        true
      elsif term == "false"
        false
      else
        term
      end
    end

    def cast(field, term)
      if boolean_columns.include? field
        boolify term
      elsif datetime_columns.include? field
        DateTime.parse(term) rescue term
      else
        term
      end
    end

    def search_by_tag term
      if term.present?
        where(id: self.joins(:tags).where("tags.name = ?", term))
      else
        where.not(id: TagList.where(taggable_type: self.to_s).select(:taggable_id))
      end
    end

    def search_by_organization_id term
      if term.present?
        where(organization: Organization.where("_id = ?", term))
      else
        where(organization_id: nil)
      end
    end

    def generic_search_by field, term
      if term.present?
        where(field => term)
      else
        where("#{field} = ? or #{field} IS NULL", term)
      end
    end
  end
end
