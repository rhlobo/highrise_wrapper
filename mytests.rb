
require 'highrise'
require 'highrise_wrapper'

require 'virtus'
require 'simple_attribute_mapper'


########### highrise setup
Highrise::Base.site = 'https://personal1788.highrisehq.com'
Highrise::Base.user = 'ee54dd83345c800c14b6fda0a650659e'
Highrise::Base.format = :xml

#@people = Highrise::Person.find_all_across_pages(:params => {:tag_id => 12345})
#@people = Highrise::Person.find_all_across_pages

# [#<Highrise::Person:0x9db1d80 @attributes={"author_id"=>1018065, "background"=>nil, "company_id"=>nil, "created_at"=>2014-03-17 22:11:22 UTC, "first_name"=>"A", "group_id"=>nil, "id"=>201374388, "last_name"=>"A", "owner_id"=>nil, "title"=>nil, "updated_at"=>2014-03-17 22:11:22 UTC, "visible_to"=>"Everyone", "company_name"=>nil, "linkedin_url"=>nil, "avatar_url"=>"http://dge9rmgqjs8m1.cloudfront.net/highrise/missing/avatar.gif?r=3", "contact_data"=>#<Highrise::Person::ContactData:0x9db0a98 @attributes={"instant_messengers"=>[], "twitter_accounts"=>[], "email_addresses"=>[], "phone_numbers"=>[], "addresses"=>[], "web_addresses"=>[]}, @prefix_options={}, @persisted=true>, "subject_datas"=>[#<Highrise::Person::SubjectData:0x9dafc88 @attributes={"id"=>118062439, "subject_field_id"=>878834, "subject_field_label"=>"Customer ID", "value"=>"A"}, @prefix_options={}, @persisted=true>]}, @prefix_options={}, @persisted=true>]


########### conversion tests
###################### contact
class Contact
  include HighriseWrapper::ActiveRecord
  include Virtus.model

  attribute :name, String
  attribute :last_name, String
  attribute :company_name, String
  attribute :job_title, String
  attribute :phone, String
  attribute :website, String
  attribute :email, String

  def initialize attributes
    attributes.each { |k, v| instance_variable_set("@#{k}", v) }
  end
end

c = Contact.new({
  :email => "ha@hihi.com",
  :name => "Astolfo",
  :last_name => "Aguiar",
  :company_name => "AspasCorp",
  :job_title => "Auxiliar",
  :phone => "",
  :website => ""})

puts 'the contact'
puts c.as_json
puts

###################### mapping v1
class Person
  attr_accessor :test_name, :test_last_name

  def initialize site, user, attributes
    @site = site
    @user = user
    attributes.each { |k, v| instance_variable_set("@test_#{k}", v) }
  end
end

p = Person.new "site", "user", c.as_json
puts 'the person'
puts p.as_json
puts

###################### mapping v2
class PersonMapper
  include Virtus.model

  attribute :first_name, String
  attribute :last_name, String
  attribute :title, String
  attribute :company_name, String
  attribute :avatar_url, String
  attribute :email, String
  attribute :home_phone, String
end

mapper = SimpleAttributeMapper::Mapper.new({
  :name => :first_name,
  :job_title => :title,
  :phone => :home_phone
})

p2 = mapper.map(c, PersonMapper)
puts 'the person (mapped)'
puts p2.as_json
puts

###################### mapping v3

hmapper = SimpleAttributeMapper::Mapper.new({
  :name => :first_name,
})

hp = hmapper.map(c, Highrise::Person)
puts 'the highrise person (mapped directly)'
puts hp.as_json
puts

###################### mapping v4

hp2 = Highrise::Person.new(p2.attributes)
puts 'the highrise person (mapped with person mapper)'
puts hp2.as_json
puts

###################### mapping v5

class ContactDataMapper
  include Virtus.model

  attribute :email_addresses, Array
  attribute :phone_numbers, Array
  attribute :web_addresses, Array
end

class PersonMapper2
  include Virtus.model

  attribute :first_name, String
  attribute :last_name, String
  attribute :title, String
  attribute :company_name, String
  attribute :avatar_url, String
  attribute :email, String
  attribute :contact_data, ContactDataMapper
end

SimpleAttributeMapper.from(c).to(PersonMapper2).with({
  :name => :first_name,
  :job_title => :title,
})

###################### mapping v6

hmapper3 = SimpleAttributeMapper::Mapper.new({
  :name => :first_name,
  :last_name => :last_name,
  :job_title => :title,
  :company_name => :company_name,
  :email => :email,
  :phone => :contact_data {:phone_numbers [:number]}
})

hp3 = hmapper3.map(c, Highrise::Person)
puts 'the highrise person (mapped directly - declaring everything)'
puts hp3.as_json
puts



#puts @people.to_json
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
