class Array
  def sanitized_html_safe
    each_with_index do |v, i|
      self[i] = v.sanitized_html_safe if v.respond_to?(:sanitized_html_safe)
    end
  end
end
