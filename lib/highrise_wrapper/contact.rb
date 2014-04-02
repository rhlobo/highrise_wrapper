module HighriseWrapper
  module ActiveRecord
    def on_highrise?
      !self.highrise_id.nil?
    end

    def highrise_save
      logger.info 'Saving #{fullname} to highrise'

      begin
        setup_highrise
        person = Highrise::Person.new(self.highrise_hash)
        person.save!
        self.highrise_id = person.attributes['id']
        self.save!
      rescue Exception => exception
        logger.error(
          "It was not possible to save contact to highrise: " +
          "#{exception.class} (#{exception.message})")
        return false
      end
    end

    def highrise_remove
      logger.info 'Removing #{fullname} from highrise'

      begin
        setup_highrise
        person = Highrise::Person.find(highrise_id)
        person.destroy
        self.highrise_id = nil
        self.save!
      rescue Exception => exception
        logger.error(
          "It was not possible to remove contact from highrise: " +
          "#{exception.class} (#{exception.message})")
        return false
      end
    end

    private
    def setup_highrise
        Highrise::Base.site = self.highrise_base_url
        Highrise::Base.user = self.highrise_token
        Highrise::Base.format = :xml
    end
  end
end