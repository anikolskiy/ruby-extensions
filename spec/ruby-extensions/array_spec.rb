require 'spec_helper'

describe Array do
  describe 'sanitized_html_safe' do
    let(:array) do
      [
        '<script>something 1</script>',
        { some_key: '<script>something 2</script>' },
        '<div>something 3</div>'
      ].sanitized_html_safe
    end

    it 'should remove <script> tag' do
      expect(array[0]).to eq 'something 1'
      expect(array[1][:some_key]).to eq 'something 2'
    end

    it 'should keep other html tags' do
      expect(array[2]).to eq '<div>something 3</div>'
    end

    it 'should be html_safe' do
      expect(array[0]).to be_html_safe
      expect(array[1][:some_key]).to be_html_safe
      expect(array[2]).to be_html_safe
    end
  end
end
