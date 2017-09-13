require 'numberjack/version'
require 'utilities/hash'
require 'active_model/numberjack_validator' if defined?(ActiveModel)

module Numberjack
  autoload :DataImporter,      'numberjack/data_importer'
  autoload :TestDataGenerator, 'numberjack/test_data_generator'
  autoload :Parser,            'numberjack/parser'
  autoload :Number,            'numberjack/number'
  autoload :Formatter,         'numberjack/formatter'
  autoload :Country,           'numberjack/country'
  autoload :NumberFormat,      'numberjack/number_format'
  autoload :NumberValidation,  'numberjack/number_validation'
  autoload :ClassMethods,      'numberjack/class_methods'

  extend ClassMethods
end
