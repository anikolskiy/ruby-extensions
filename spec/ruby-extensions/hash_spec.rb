require 'spec_helper'

describe Hash do
  describe 'sanitized_html_safe' do
    let(:hash) do
      {
        some_key_1: '<script>something 1</script>',
        some_key_2: {
          some_key_3: '<script>something 3</script>',
          some_key_4: [
            '<script>something 4</script>'
          ]
        },
        some_key_5: '<div>something 5</div>'
      }.sanitized_html_safe
    end

    it 'should remove <script> tag' do
      expect(hash[:some_key_1]).to eq 'something 1'
      expect(hash[:some_key_2][:some_key_3]).to eq 'something 3'
      expect(hash[:some_key_2][:some_key_4]).to eq ['something 4']
    end

    it 'should keep other html tags' do
      expect(hash[:some_key_5]).to eq '<div>something 5</div>'
    end

    it 'should be html_safe' do
      expect(hash[:some_key_1]).to be_html_safe
      expect(hash[:some_key_2][:some_key_3]).to be_html_safe
      expect(hash[:some_key_2][:some_key_4][0]).to be_html_safe
      expect(hash[:some_key_5]).to be_html_safe
    end
  end
end
