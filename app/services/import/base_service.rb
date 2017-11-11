class Import::BaseService

  attr_reader :file_path

  def initialize file_path
    @file_path = file_path
  end

  def load_file
    begin
      load_records.each do |attributes|
        begin
          ActiveRecord::Base.transaction do
            import_record attributes
          end
        rescue => error
          log_import_error(error, attributes)
          @total -= 1
        end
      end
    rescue => error
      Rails.logger.error "Import failed due to"
      Rails.logger.error error.message
      Rails.logger.error error.backtrace
    end

    Rails.logger.info "Completed #{entity_name} import for #{@total}"
    Rails.logger.info "-"*30
  end

  private

  def import_record
    raise "To be implemented by child class"
  end

  def entity_name
    raise "To be implemented by child class"
  end

  def load_records
    file = File.read(file_path)
    @records = JSON.parse(file)

    @total = @records.count
    Rails.logger.info "#{entity_name}: Starting import of #{@total} records."
    @records
  end

  def log_import_error(error, attributes)
    Rails.logger.error "Error while importing #{entity_name}: #{attributes["_id"]}. Skipping"
    Rails.logger.error "Msg: #{error.message}"
    Rails.logger.error "-"*10
  end


  def get_organization attributes
    organization_id = attributes.delete("organization_id")
    Organization.find_by!(_id: organization_id) if organization_id
  end
end
