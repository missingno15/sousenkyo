module Sousenkyo
  class Il8n
    VAR_PATTERN = /\{\{(.*?)\}\}/
    LOCALE_MSGS = YAML.load_file(
      File.join(Sousenkyo.config_path, "locale", "#{Sousenkyo.locale}.yml")
    )

    class << self 
      def t(keystr, variables = {})
        keys = keystr.split(".").map(&:to_sym)

        msg = keys.reduce(LOCALE_MSGS) do |locale, k| 
          value = locale[k]
          if value.nil?
            raise Sousenkyo::Errors::TranslationNotFound
          else
            value
          end
          value
        end

        puts transform(msg, variables)
      end

      private

      def transform(msg, variables)
        extract_vars(msg).each do |var|
          substitute_value = variables[var]
          msg.sub!(/\{\{[\s,#{var}]*?\}\}/, substitute_value.to_s)
        end

        msg
      end

      def extract_vars(str)
        str.scan(VAR_PATTERN).flatten.map do |var|
          var.strip.to_sym
        end
      end
    end
  end
end
