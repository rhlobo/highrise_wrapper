# Highrise_wrapper

Gem built to wrap the highrise gem. 
This is a POC created to be used in my personal studies.

## Installation

Add this line to your application's Gemfile:

    gem 'Highrise_wrapper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install Highrise_wrapper

## Usage

You can start to use with just a few steps. All you need is to
have a class including our `Contact` module that:

- implements a `highrise_hash` method that returns a hash with the contact information using the format the highrise_api ( https://github.com/basecamp/highrise-api ) uses
- has `highrise_token` and `highrise_base_url` available

### Example code

```ruby
class Contact < ActiveRecord::Base
  include HighriseWrapper::ActiveRecord

  belongs_to :company

  def fullname
    "#{first_name} #{last_name}"
  end

  def highrise_hash
  {
    'first_name' => first_name,
    'last_name' => last_name,
    'title' => job_title,
    'company_name' => company_name,
    'contact_data' =>  {
      'email_addresses' => [{
        'address' => email,
        'location' => 'Work'
      }],
      'phone_numbers' => [{
        'number' => phone,
        'location' => 'Work'
      }],
      'web_addresses' => [{
        'location' => 'Work',
        'url' => website
      }]
    }
  }
  end

  def highrise_token
    company.highrise_token
  end

  def highrise_base_url
    company.highrise_base_url
  end
end
```

### Sample app

There is an example application you can take a look at:

- Source: http://github.com/rhlobo/loboapp
- Demo: 

## Contributing

1. Fork it ( http://github.com/rhlobo/Highrise_wrapper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
