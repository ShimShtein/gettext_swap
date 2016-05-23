require 'test_helper'

# Tests the repository
class GettextSwapRepositoryTest < ActiveSupport::TestCase
  include FastGettext::Translation

  setup do
    @initialized ||= GettextSwap.configure 'config/test/test.yaml'
  end

  test 'it changes brand words' do
    res = _('Hello from Foreman')
    assert_equal 'Hello from Satellite', res
  end

  test 'it works on translated text' do
    res = _('Please translate Foreman')
    assert_equal 'Translated Satellite', res
  end

  test 'it follows order from the rules file' do
    res = _('Test smart proxy replacement')

    # ensure the branding does not confuse between
    # 'smart proxy' => 'capsule' and 'proxy' => 'capsule'
    # in the latter case we will get 'smart capsule'
    assert_equal 'Test capsule replacement', res
  end
end
