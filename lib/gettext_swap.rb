require 'fast_gettext'
require 'active_support/all'
require 'gettext_swap/version'
require 'gettext_swap/swapper_repository'
require 'gettext_swap/exceptions'
require 'gettext_swap/configuration'

module GettextSwap
  # monkey patch FastGettext.add_text_domain to wrap the suggested
  # domain with branding domain wrapper
  module FastGettextPatch
    def self.included(klass)
      klass.class_eval do
        def add_text_domain_with_wrapping(name, options)
          repo = add_text_domain_without_wrapping(name, options)

          wrapper = GettextSwap::SwapperRepository.new repo

          translation_repositories[name] = wrapper
        end

        alias_method_chain :add_text_domain, :wrapping
      end
    end
  end

  FastGettext.include FastGettextPatch
end
