require 'phonejack/version'
require 'utilities/hash'
require 'active_model/phonejack_validator' if defined?(ActiveModel)

module Phonejack
  autoload :DataImporter,      'phonejack/data_importer'
  autoload :TestDataGenerator, 'phonejack/test_data_generator'
  autoload :Parser,            'phonejack/parser'
  autoload :Number,            'phonejack/number'
  autoload :Formatter,         'phonejack/formatter'
  autoload :Country,           'phonejack/country'
  autoload :NumberFormat,      'phonejack/number_format'
  autoload :NumberValidation,  'phonejack/number_validation'
  autoload :ClassMethods,      'phonejack/class_methods'

  extend ClassMethods
end
