require 'telephone_number_parser/version'
require 'utilities/hash'
require 'active_model/telephone_number_validator' if defined?(ActiveModel)

module TelephoneNumberParser
  autoload :DataImporter,      'telephone_number_parser/data_importer'
  autoload :TestDataGenerator, 'telephone_number_parser/test_data_generator'
  autoload :Parser,            'telephone_number_parser/parser'
  autoload :Number,            'telephone_number_parser/number'
  autoload :Formatter,         'telephone_number_parser/formatter'
  autoload :Country,           'telephone_number_parser/country'
  autoload :NumberFormat,      'telephone_number_parser/number_format'
  autoload :NumberValidation,  'telephone_number_parser/number_validation'
  autoload :ClassMethods,      'telephone_number_parser/class_methods'

  extend ClassMethods
end
