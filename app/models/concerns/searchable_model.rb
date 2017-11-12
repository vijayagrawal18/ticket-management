module SearchableModel
  extend ActiveSupport::Concern

  module ClassMethods

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

    def search_by(field, term)
      term = cast(field, term)

      case field
      when "tag"
        where(id: self.joins(:tags).where("tags.name = ?", term))
      when "domain"
        where(id: self.joins(:domains).where("domains.name = ?", term))
      when "organization"
        where(organization: Organization.where("name = ?", term))
      when *column_names
        if term.present?
          where(field => term)
        else
          where("#{field} = ? or #{field} IS NULL", term)
        end
      else
        all
      end
    end
  end

end
