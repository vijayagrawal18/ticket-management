module Searchable
  extend ActiveSupport::Concern

  included do
    before_action :set_model, :set_fields, :verify_params, only: [:index]
  end

  private

  def search(entity)
    entity = entity.search_by(@search_field, @search_term) if @search_field
    entity
  end

  def set_fields
    @fields = @model.searchable_attributes.inject({}) do |hash, attribute|
      hash[attribute.gsub("_", ' ').titleize] = attribute
      hash
    end
  end

  def verify_params
    @search_field = params[:field]
    @search_term = params[:value]&.strip
    handle_field_selection
    handle_invalid_field
  end

  def handle_invalid_field
    if @search_field.present? && @fields.values.exclude?(@search_field)
      flash.now[:alert] = "#{params[:field]} not available for search"
      @search_field = nil
      @search_term = nil
    end
  end

  def handle_field_selection
    if @search_field.blank? && @search_term.present?
      flash.now[:alert] = "Please select a field"
    end
  end
end
