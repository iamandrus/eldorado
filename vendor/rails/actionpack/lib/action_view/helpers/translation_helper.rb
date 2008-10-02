require 'action_view/helpers/tag_helper'

module ActionView
  module Helpers
    module TranslationHelper
      def translate(*args)
        args << args.extract_options!.merge(:raise => true)
        I18n.translate *args

      rescue I18n::MissingTranslationData => e
        keys = I18n.send :normalize_translation_keys, e.locale, e.key, e.options[:scope]
        content_tag('span', keys.join(', '), :class => 'translation_missing')
      end
<<<<<<< HEAD:vendor/rails/actionpack/lib/action_view/helpers/translation_helper.rb
      alias :t :translate
=======
>>>>>>> i18n:vendor/rails/actionpack/lib/action_view/helpers/translation_helper.rb

      def localize(*args)
        I18n.localize *args
      end
<<<<<<< HEAD:vendor/rails/actionpack/lib/action_view/helpers/translation_helper.rb
      alias :l :localize
=======
>>>>>>> i18n:vendor/rails/actionpack/lib/action_view/helpers/translation_helper.rb
    end
  end
end