$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'gettext_swap'
require 'test_helper'
require 'gettext_swap/configuration'

class GettextSwapTest < ActiveSupport::TestCase
  setup do
    @good_yaml = <<-YAML
      swap:
        - search: 'search1'
          replace: 'value1'
        - search: 'search2'
          replace: 'value2'
      YAML

    @bad_yaml = <<-YAML
      swap:
        - search: 'search3'
          replace: 'value3'
        - zzsearch: 'search4'
          replace: 'value4'
    YAML
    @config = GettextSwap::Configuration.new
  end

  test 'it accepts valid yaml' do
    yaml = YAML.load(@good_yaml)
    @config.read_yaml(yaml)

    assert_equal 2, @config.rules.length
  end

  test 'it rejects bad yaml' do
    yaml = YAML.load(@good_yaml)
    @config.read_yaml(yaml)
    yaml = YAML.load(@bad_yaml)

    assert_raises GettextSwap::Exception do
      @config.read_yaml(yaml)
    end

    assert_equal 2, @config.rules.length
    assert_not_empty @config.rules.select { |_, val| val == 'value1' }
    assert_empty @config.rules.select { |_, val| val == 'value3' }
  end

  test 'it requires top element' do
    bad_yaml = <<-YAML
    no_swap:
      - search: 'search3'
        replace: 'value3'
      - search: 'search4'
        replace: 'value4'
    YAML
    yaml = YAML.load(bad_yaml)
    assert_raises GettextSwap::Exception do
      @config.read_yaml(yaml)
    end
  end

  test 'it requires replacement value' do
    bad_yaml = <<-YAML
    no_swap:
      - search: 'search3'
      - search: 'search4'
        replace: 'value4'
    YAML
    yaml = YAML.load(bad_yaml)
    assert_raises GettextSwap::Exception do
      @config.read_yaml(yaml)
    end
  end

  test 'it requires search value' do
    bad_yaml = <<-YAML
    no_swap:
      - replace: 'value4'
      - search: 'search4'
        replace: 'value4'
    YAML
    yaml = YAML.load(bad_yaml)
    assert_raises GettextSwap::Exception do
      @config.read_yaml(yaml)
    end
  end
end
