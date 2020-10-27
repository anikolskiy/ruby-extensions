class Hash
  def sanitized_html_safe
    each do |k, v|
      self[k] = v.sanitized_html_safe if v.respond_to?(:sanitized_html_safe)
    end
  end
end
