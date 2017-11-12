module SearchableModel
  extend ActiveSupport::Concern

  module ClassMethods

    def boolean_columns
      columns.select do |col|
        col.sql_type=="boolean"
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

    def search_by(field, term)
      term = boolify(term) if boolean_columns.include? field

      case field
      when "tag"
        where(id: self.joins(:tags).where("tags.name = ?", term))
      when "domain"
        where(id: self.joins(:domains).where("domains.name = ?", term))
      when *column_names
        where("coalesce(#{field}, '') = ?", term)
      else
        all
      end
    end
  end

end
