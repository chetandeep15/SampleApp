require 'rails_helper'

describe 'ApplicationHelper' do
  describe 'full_title' do
    it 'should return full title' do
      expect(full_title('foo')).to eq("Sample App | foo")
    end

    it 'should include base title' do
      expect(full_title('foo')).to match(/Sample App/)
    end

    it 'should include page title' do
      expect(full_title('foo')).to match(/foo/)
    end

    it 'should not include the separator' do
      expect(full_title('')).to match(/^|/)
    end
  end

end
