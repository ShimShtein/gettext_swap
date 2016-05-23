# GettextSwap

This gem adds the ability to swap words in strings marked for translation.
It is an extension to [fast_gettext](https://github.com/grosser/fast_gettext).

For example, given you have set the system to replace `<my project>` with `GettextSwap`:

``` ruby
swapped = _('Welcome to <my project')
# => 'Welcome to GettextSwap'
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gettext_swap'
```

And then execute:

    $ bundle

## Usage

First you have to build a yaml file that will contain the rules for the swapper.

1. The yaml should contain a main root element `swap`
2. Each rule consists of two sub elements: `search` - regular expression to search in the source, and `replace` - the string to use for replacement.

Example:

``` yaml
swap:
  - search: '\bForeman\b(?!-)'
    replace: 'Satellite'
  - search: '\bsmart proxy\b(?!-)'
    replace: 'capsule'
  - search: '\bproxy\b(?!-)'
    replace: 'Capsule'
```

To apply the rules, point GettextSwap to the file containing the rules.

``` ruby
GettextSwap.configure 'config/test/test.yaml'
```

## Development

This gem uses [rubocop](https://github.com/bbatsov/rubocop) to validate styling and minitest framework for testing.
Run `rubocop` and `rake test` to verify your code.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ShimShtein/gettext_swap.

## License

See [LICENSE](LICENSE) file.
