module HighriseWrapper
  module ActiveRecord
    def highrise_save
      puts 'Saving #{fullname} to highrise'

      # Map fields

      Highrise::Base.site = self.highrise_base_url
      Highrise::Base.user = self.highrise_token
      Highrise::Base.format = :xml  

      person = Highrise::Person.new do |p|

      end

      begin
        person.save!
      rescue Exception => e
        #shoud get rails logger if available
        puts person.errors
      end
      self.highrise_id = person.attributes['id']

      puts company.highrise_base_url
      puts company
      puts 'funfa??'
    end

    def highrise_remove
      puts 'Removing #{fullname} from highrise'

      Highrise::Base.site = self.highrise_base_url
      Highrise::Base.user = self.highrise_token
      Highrise::Base.format = :xml  

      person = Highrise::Person.find(highrise_id)
      person.destroy
      self.highrise_id = nil
    end
  end
end