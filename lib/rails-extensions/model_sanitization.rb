module ModelSanitization
  extend ActiveSupport::Concern

  class_methods do
    def not_sanitized_attribute(attr)
      @not_sanitized_attributes ||= []
      @not_sanitized_attributes << attr.to_s unless @not_sanitized_attributes.include?(attr.to_s)
    end

    def sanitized_attribute?(attr)
      !@not_sanitized_attributes&.include?(attr)
    end

    def not_sanitized_model
      @not_sanitized_model = true
    end

    def sanitized_model?
      !@not_sanitized_model
    end
  end

  included do
    before_validation do
      if self.class.sanitized_model?
        changed_attributes.keys.each do |attr|
          if self.class.sanitized_attribute?(attr.to_s) &&
              [:string, :text].include?(type_for_attribute(attr).type) &&
              self[attr].is_a?(String)

            self[attr] = self[attr].sanitized_html_safe
          end
        end
      end
    end
  end
end
