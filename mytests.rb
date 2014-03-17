require 'highrise'

Highrise::Base.site = 'https://personal1788.highrisehq.com'
Highrise::Base.user = 'ee54dd83345c800c14b6fda0a650659e'
Highrise::Base.format = :xml

#@people = Highrise::Person.find_all_across_pages(:params => {:tag_id => 12345})
@people = Highrise::Person.find_all_across_pages

# [#<Highrise::Person:0x9db1d80 @attributes={"author_id"=>1018065, "background"=>nil, "company_id"=>nil, "created_at"=>2014-03-17 22:11:22 UTC, "first_name"=>"A", "group_id"=>nil, "id"=>201374388, "last_name"=>"A", "owner_id"=>nil, "title"=>nil, "updated_at"=>2014-03-17 22:11:22 UTC, "visible_to"=>"Everyone", "company_name"=>nil, "linkedin_url"=>nil, "avatar_url"=>"http://dge9rmgqjs8m1.cloudfront.net/highrise/missing/avatar.gif?r=3", "contact_data"=>#<Highrise::Person::ContactData:0x9db0a98 @attributes={"instant_messengers"=>[], "twitter_accounts"=>[], "email_addresses"=>[], "phone_numbers"=>[], "addresses"=>[], "web_addresses"=>[]}, @prefix_options={}, @persisted=true>, "subject_datas"=>[#<Highrise::Person::SubjectData:0x9dafc88 @attributes={"id"=>118062439, "subject_field_id"=>878834, "subject_field_label"=>"Customer ID", "value"=>"A"}, @prefix_options={}, @persisted=true>]}, @prefix_options={}, @persisted=true>]
p @people.methods


class Contact
	attr_accessor :name, :last_name, :email, :company, :job_title, :phone, :website

	def initialize
	end

	def save
	end
end