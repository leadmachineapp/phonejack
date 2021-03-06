require "test_helper"

class PhonejackTest < Minitest::Test
  def setup
    @valid_numbers = YAML.load_file('test/valid_numbers.yml')
  end

  def test_valid_with_keys_returns_true
    assert Phonejack.valid?("3175082489", "US", [:fixed_line, :mobile, :toll_free])
  end

  def test_valid_with_keys_returns_false
    refute Phonejack.valid?("448444156790", "GB", [:fixed_line, :mobile, :toll_free])
    assert Phonejack.valid?("448444156790", "GB", [:shared_cost])
  end

  def test_valid_with_invalid_country_returns_false
    refute Phonejack.valid?("448444156790", "NOTREAL")
    assert Phonejack.invalid?("448444156790", "NOTREAL")
  end

  def test_valid_types_is_not_empty_when_valid
    @valid_numbers.each do |country, number_object|
      number_object.each do |_name, number_data|
        number_data.each do |_type, number|
          assert Phonejack.valid?(number, country)
          refute Phonejack.invalid?(number, country)
        end
      end
    end
  end

  def test_sanitize_removes_all_non_numeric_characters
    assert_equal "", Phonejack.sanitize("asdfasdfa")
    assert_equal "123", Phonejack.sanitize("abc123")
  end

  def test_detect_country_for_numbers
    @valid_numbers.each do |country, number_object|
      number_object.each do |_name, number_data|
        assert_equal country, Phonejack.detect_country(number_data[:e164_formatted])
      end
    end
  end

  def test_valid_formatted_national_number_for_countries
    @valid_numbers.each do |country, number_object|
      number_object.values.each do |number_data|
        number_data.values.each do |number|
          telephone_number = Phonejack.parse(number, country)
          assert_equal number_data[:national_formatted], telephone_number.national_number
        end
      end
    end
  end

  def test_valid_formatted_international_number_for_countries
    @valid_numbers.each do |country, number_object|
      number_object.values.each do |number_data|
        number_data.values.each do |number|
          telephone_number = Phonejack.parse(number, country)
          assert_equal number_data[:international_formatted], telephone_number.international_number
        end
      end
    end
  end

  def test_valid_formatted_e164_numbers_for_countries
    @valid_numbers.each do |country, number_object|
      number_object.values.each do |number_data|
        number_data.values.each do |number|
          telephone_number = Phonejack.parse(number, country)
          assert_equal number_data[:e164_formatted], telephone_number.e164_number
        end
      end
    end
  end

  # Our data override file ensures that this number is valid but doesn't provide a formatting rule
  # which means the national and international number methods should just return the normalized number
  def test_override_file_correctly_formats
    number_obj = Phonejack.parse('81', :br)
    assert_equal '81', number_obj.national_number
    assert_equal '81', number_obj.international_number
    assert_equal '+5581', number_obj.e164_number
  end

  def test_detect_country_returns_nil_if_country_not_found
    assert_nil Phonejack.detect_country("1")
  end

  def test_returns_empty_string_if_input_is_nil
    country_inputs = [nil, '', :us]
    number_inputs = [nil, '']
    methods = [:international_number, :national_number, :e164_number]

    country_inputs.product(number_inputs, methods).each do |country, number, method|
      assert_equal '', Phonejack.parse(number, country).public_send(method)
    end
  end

  def test_valid_types_with_invalid_country_returns_false
    assert_predicate Phonejack.parse("448444156790", "NOTREAL").valid_types, :empty?
  end

  def test_returns_original_string_when_country_is_nil
    assert_equal '13175082205', Phonejack.parse('13175082205', nil).international_number
    assert_equal '13175082205', Phonejack.parse('13175082205', nil).national_number
    assert_equal '13175082205', Phonejack.parse('13175082205', nil).e164_number
  end

  def test_invalid_numbers_go_to_default_pattern
    Phonejack.default_format_pattern = "(\\d{3})(\\d{3})(\\d*)"
    Phonejack.default_format_string = "($1) $2-$3"
    invalid_number = "1111111111"
    assert_equal "(111) 111-1111", Phonejack.parse(invalid_number, :us).national_number

    Phonejack.instance_variable_set(:@default_format_pattern, nil)
    Phonejack.instance_variable_set(:@default_format_string, nil)
  end
end
