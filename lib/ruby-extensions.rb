if defined?(Rails)
  %w[
    array
    hash
    string
  ].each do |name|
    current_path = File.dirname(__FILE__)
    require File.join(current_path, 'ruby-extensions', File.dirname(name), File.basename(name, '.rb'))
  end

  %w[
    model_sanitization
  ].each do |name|
    current_path = File.dirname(__FILE__)
    require File.join(current_path, 'rails-extensions', File.dirname(name), File.basename(name, '.rb'))
  end
end
