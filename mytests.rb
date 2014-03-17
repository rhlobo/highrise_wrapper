require 'highrise'

Highrise::Base.site = 'https://personal1788.highrisehq.com'
Highrise::Base.user = 'ee54dd83345c800c14b6fda0a650659e'
Highrise::Base.format = :xml

@people = Highrise::Person.find_all_across_pages(:params => {:tag_id => 12345})

puts @people
