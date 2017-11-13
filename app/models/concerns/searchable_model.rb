module SearchableModel
  extend ActiveSupport::Concern

  TAG_FIELD = "tags"
  DOMAIN_FIELD = "domains"
  ORGANIZATION_FIELD = "organization_id"

  module ClassMethods

    def search_by(field, term)
      term = cast(field, term)

      case field
      when TAG_FIELD, DOMAIN_FIELD, ORGANIZATION_FIELD
        send "search_by_#{field}", term
      when *column_names
        generic_search_by field, term
      else
        all
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

    def boolean_columns
      @_boolean_columns ||= columns_for "boolean"
    end

    def datetime_columns
      @_datetime_columns ||=  columns_for "datetime"
    end

    def string_columns
      @_string_columns ||=  columns_for "varchar"
    end

    def columns_for type
      columns.select do |col|
        col.sql_type == type
      end.map do |col|
        col.name
      end
    end

    def boolify term
      if term == "true"
        true
      elsif term == "false"
        false
      else
        term
      end
    end

    def search_by_tags term
      if term.present?
        term_array = term.split(",").map { |name| name.strip.upcase }
        tags = Tag.where("UPPER(name) IN (?)", term_array)

        return none if tags.count != term_array.compact.count

        where(id: TagList.having_all(tags, self.to_s).select(:taggable_id))
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
        if string_columns.include? field
          where("UPPER(#{field}) = UPPER(?)", term)
        else
          where(field => term)
        end
      else
        where("#{field} = ? or #{field} IS NULL", term)
      end
    end
  end
end
