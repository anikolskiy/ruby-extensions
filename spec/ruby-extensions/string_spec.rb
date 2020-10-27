require 'spec_helper'

describe String do
  describe 'sanitized_html_safe' do
    it 'should remove <script> tag' do
      expect('<script>something</script>'.sanitized_html_safe).to eq 'something'
    end

    it 'should keep other html tags' do
      expect('<div>something</div>'.sanitized_html_safe).to eq '<div>something</div>'
    end

    it 'should be html_safe' do
      expect('<div>something</div>'.sanitized_html_safe).to be_html_safe
    end
  end
end
