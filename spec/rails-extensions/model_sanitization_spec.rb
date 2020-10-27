require 'spec_helper'

describe ModelSanitization do
  class SanitizationTestModel < ActiveRecord::Base
    include ModelSanitization
  end

  context 'default behavior' do
    before do
      SanitizationTestModel.class_eval('@not_sanitized_model = nil')
      SanitizationTestModel.class_eval('@not_sanitized_attributes = nil')
    end

    it 'should sanitize string attribute' do
      model = SanitizationTestModel.new name: "<script>alert('a');</script>"
      model.valid?
      expect(model.name).to eq "alert('a');"
    end

    it 'should sanitize text attribute' do
      model = SanitizationTestModel.new content: "<script>alert('a');</script>"
      model.valid?
      expect(model.content).to eq "alert('a');"
    end
  end

  context 'entire model is marked to not be sanitized' do
    before do
      SanitizationTestModel.class_eval('@not_sanitized_attributes = nil')
      SanitizationTestModel.not_sanitized_model
    end

    it 'should not sanitize string attribute' do
      model = SanitizationTestModel.new name: "<script>alert('a');</script>"
      model.valid?
      expect(model.name).to eq "<script>alert('a');</script>"
    end

    it 'should not sanitize text attribute' do
      model = SanitizationTestModel.new content: "<script>alert('a');</script>"
      model.valid?
      expect(model.content).to eq "<script>alert('a');</script>"
    end
  end

  context 'only some attributes are marked to not be sanitized' do
    before do
      SanitizationTestModel.class_eval('@not_sanitized_model = nil')
      SanitizationTestModel.class_eval('@not_sanitized_attributes = nil')
      SanitizationTestModel.not_sanitized_attribute(:name)
    end

    it 'should not sanitize string attribute' do
      model = SanitizationTestModel.new name: "<script>alert('a');</script>"
      model.valid?
      expect(model.name).to eq "<script>alert('a');</script>"
    end

    it 'should sanitize text attribute' do
      model = SanitizationTestModel.new content: "<script>alert('a');</script>"
      model.valid?
      expect(model.content).to eq "alert('a');"
    end
  end
end
