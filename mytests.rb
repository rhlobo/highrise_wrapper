require 'highrise'

Highrise::Base.site = 'https://personal1788.highrisehq.com'
Highrise::Base.user = 'ee54dd83345c800c14b6fda0a650659e'
Highrise::Base.format = :xml

#@people = Highrise::Person.find_all_across_pages(:params => {:tag_id => 12345})
@people = Highrise::Person.find_all_across_pages

# [#<Highrise::Person:0x9db1d80 @attributes={"author_id"=>1018065, "background"=>nil, "company_id"=>nil, "created_at"=>2014-03-17 22:11:22 UTC, "first_name"=>"A", "group_id"=>nil, "id"=>201374388, "last_name"=>"A", "owner_id"=>nil, "title"=>nil, "updated_at"=>2014-03-17 22:11:22 UTC, "visible_to"=>"Everyone", "company_name"=>nil, "linkedin_url"=>nil, "avatar_url"=>"http://dge9rmgqjs8m1.cloudfront.net/highrise/missing/avatar.gif?r=3", "contact_data"=>#<Highrise::Person::ContactData:0x9db0a98 @attributes={"instant_messengers"=>[], "twitter_accounts"=>[], "email_addresses"=>[], "phone_numbers"=>[], "addresses"=>[], "web_addresses"=>[]}, @prefix_options={}, @persisted=true>, "subject_datas"=>[#<Highrise::Person::SubjectData:0x9dafc88 @attributes={"id"=>118062439, "subject_field_id"=>878834, "subject_field_label"=>"Customer ID", "value"=>"A"}, @prefix_options={}, @persisted=true>]}, @prefix_options={}, @persisted=true>]


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

#c = Contact.new "site", "user", {name: "fernando"}
#puts c.name
puts @people.to_json

=begin
{
	"author_id":1018065,
	"background":null,
	"company_id":202863650,
	"created_at":"2014-03-17T22:11:22Z",
	"first_name":"Roberto",
	"group_id":null,
	"id":201374388,
	"last_name":"Lobo",
	"owner_id":null,
	"title":"Project Manager",
	"updated_at":"2014-03-29T20:40:56Z",
	"visible_to":"Everyone",
	"company_name":"Empresa",
	"linkedin_url":null,
	"avatar_url":"http://dge9rmgqjs8m1.cloudfront.net/highrise/missing/avatar.gif?r=3",
	"contact_data": {
		"instant_messengers":[],
		"twitter_accounts":[],
		"email_addresses":[{
			"address":"rhlobo+highrise@gmail.com",
			"id":103683105,
			"location":"Home"
		}],
		"phone_numbers":[{
			"id":164635766,
			"location":"Work",
			"number":"84442234"
		}],
		"addresses":[],
		"web_addresses":[{
			"id":164635767,
			"location":"Work",
			"url":"http://how.i.drycode.it"
		}]
	},
	"subject_datas":[{
		"id":118062439,
		"subject_field_id":878834,
		"subject_field_label":"Customer ID",
		"value":"ID"
	}]
}
=end
