# What is it?

Phonejack is global phone number validation gem based on Google's [libphonenumber](https://github.com/googlei18n/libphonenumber) library.

This was forked from https://github.com/mobi/telephone_number as the chosen gem name (telephone_number), and class name (TelephoneNumber) were too generic and clashed with existing model names

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'phonejack'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install phonejack

## Rails Validation

`validates :my_attribute_name, phonejack: {country: proc{|record| record.country}, types: [:fixed_line, :mobile, etc]}`

#### Valid Phone Types
- `:area_code_optional`
- `:fixed_line`
- `:mobile`
- `:no_international_dialling`
- `:pager`
- `:personal_number`
- `:premium_rate`
- `:shared_cost`
- `:toll_free`
- `:uan`
- `:voicemail`
- `:voip`

#### Country

- In this example, `record.country` must yield a valid two letter country code such as `:us` or `:ca`


## Manual Usage

You can obtain a `Phonejack` object by calling:

```
phone_object = Phonejack.parse("3175082237", :us) ==>

#<Phonejack::Number:0x007fe3bc146cf0
  @country=:US,
  @e164_number="13175083348",
  @national_number="3175083348",
  @original_number="3175083348">
```
After that you have the following instance methods available to you.

- ### `valid_types`

  Returns all types that the number is considered valid for.

  `phone_object.valid_types ==> [:fixed_line, :mobile, :toll_free]`

- ### `valid?`

  Returns boolean value indicating whether or not `valid_types` is empty.

  `phone_object.valid? ==> true`

- ### `national_number(formatted: true)`

  Returns the national formatted number including special characters such as parenthesis and dashes. You can omit the special characters by passing `formatted: false`

  `phone_object.national_number ==> "(317) 508-2237"`

- ### `international_number(formatted: true)`

  Returns the international formatted number including special characters such as parenthesis and dashes. You can omit the special characters by passing `formatted: false`

  `phone_object.international_number ==> "+1 317-508-2237"`

- ### `e164_number(formatted: true)`

  Returns the international formatted number including special characters such as parenthesis and dashes. You can omit the special characters by passing `formatted: false`

  `phone_object.e164_number ==> "+13175082237"`

- ### `country`

  Returns an object containing data related a the number's country.

  ```
  phone_object.country ===>
   #<Phonejack::Country:0x007fb976267410
   @country_code="1",
   @country_id="US",
   ...
  ```

### Class Methods

  You also have the following class methods available to you.

  - #### `parse`

    Returns a Phonejack object.

    `Phonejack.parse("3175082237", :US)`

    If you pass an E164 formatted number, we will determine the country on the fly.

    `Phonejack.parse("+13175082237")`

  - #### `valid?`

    Returns boolean value indicating whether or not a particular number is valid.

    `Phonejack.valid?("3175082237", :US) ==> true`

    If you are looking to validate against a specific set of keys, you can pass in an array of keys

    ```
    Phonejack.valid?("3175082237", :US, [:mobile, :fixed_line]) ==> true
    Phonejack.valid?("3175082237", :US, [:toll_free]) ==> false
    ```

  - #### `invalid?`

    Returns boolean value indicating whether or not a particular number is invalid.

    `Phonejack.invalid?("3175082237", :US) ==> false`

    If you are looking to invalidate against a specific set of keys, you can pass in an array of keys

    ```
    Phonejack.invalid?("3175082237", :US, [:mobile, :fixed_line]) ==> false
    Phonejack.invalid?("3175082237", :US, [:toll_free]) ==> true
    ```


## Configuration

### Override File

In the event that you need to override the data that Google is providing, you can do so by setting an override file. This file is expected to be in the same format as Google's as well as serialized using Marshal.

To generate a serialized override file:

    ruby bin/console
    Phonejack.generate_override_file("/path/to/file")

In this instance, `/path/to/file` represents an xml file that has your custom data in the same structure that Google's data is in.

You can set the override file with:

    Phonejack.override_file = "/path/to_file.dat"

### Default Number Pattern

If Phonejack is passed an invalid number and then asked to format that number, it will simply return an unformatted string of the originally passed number. This is because formatting rules will not be found for invalid numbers. If this is unacceptable, you can set a `default_format_pattern` and `default_format_string` that Phonejack will use attempt to format invalid numbers.

```
Phonejack.default_format_pattern = "(\\d{3})(\\d{3})(\\d*)"
Phonejack.default_format_string = "($1) $2-$3"

invalid_number = "1111111111"
phone_object = Phonejack.parse(invalid_number, :US)
phone_object.national_number ==> "(111) 111-1111"
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

While developing new functionality, you may want to test against specific phone numbers. In order to do this, add the number to `lib/phonejack/test_data_generator.rb` and then run `rake data:test:import`. This command will reach out to the demo application provided by Google and pull the correct formats to test against.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

