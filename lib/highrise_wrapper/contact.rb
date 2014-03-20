module Highrise_wrapper

	class Contact
		attr_accessor :name, :last_name, :email, :company, :job_title, :phone, :website

		def initialize site, user, attributes
			@site = site
			@user = user
			attributes.each { |k, v| instance_variable_set("@#{k}", v) }
		end

		def save
		end
	end

end