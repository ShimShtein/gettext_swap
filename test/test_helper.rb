$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'gettext_swap'

require 'minitest/autorun'

require 'active_support/all'

# rubocop:disable Style/ClassAndModuleChildren
class Minitest::Test
  FastGettext.add_text_domain(
    'test',
    :type => :po,
    :path => File.join(File.expand_path('../../', __FILE__), 'locale'))
  FastGettext.text_domain = 'test'
  FastGettext.available_locales = ['en']
  FastGettext.locale = 'en'
end
