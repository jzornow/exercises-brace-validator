require 'rspec'
require 'braces_validator'
require 'braces_validator_spec_contexts'

describe BracesValidator do
  describe 'valid?' do

    def expect_valid_string(test_string)
      expect_validation_to_be test_string, true
    end

    def expect_invalid_string(test_string)
      expect_validation_to_be test_string, false
    end

    def expect_validation_to_be(test_string, expected_value)
      actual_value = BracesValidator.valid?(test_string)
      expect(actual_value).to be expected_value
    end

    context 'given a string with no braces' do
      it 'returns true' do
        expect_valid_string 'This sentence has no parens.'
      end
    end

    include_examples 'a brace validator', 'paren',          '(', ')'
    include_examples 'a brace validator', 'square bracket', '[', ']'
    include_examples 'a brace validator', 'curly bracket',  '{', '}'

    context 'given a combination of brace types' do
      it 'returns true if all braces are matched and appropriately ordered' do
        expect_valid_string 'This (is a [string {with} nested] [braces])'
      end

      it 'returns false if braces are unmatched' do
        expect_invalid_string 'This (is a [string {with} nested] [braces]'
      end

      it 'returns false if braces are ordered improperly' do
        expect_invalid_string 'This (is a [string {with} nested)] [braces]'
      end
    end
  end
end
