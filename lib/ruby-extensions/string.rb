class String
  include ActionView::Helpers::SanitizeHelper

  def self.sanitized_html_scrubber
    @sanitized_html_scrubber ||= begin
                                   scrubber = Rails::Html::TargetScrubber.new
                                   scrubber.tags = %w[script]
                                   scrubber
                                 end
  end

  def sanitized_html_safe
    sanitize(self, scrubber: self.class.sanitized_html_scrubber)
  end
end
