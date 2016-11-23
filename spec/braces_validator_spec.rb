require 'rspec'
require 'braces_validator'

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

    context 'given single, unmatched parens' do
      it 'returns false if open parentheses do not have close parentheses' do
        expect_invalid_string 'This sentence has (only an open paren.'
      end

      it 'returns false if close parentheses do not have open parentheses' do
        expect_invalid_string 'This sentence has only a close paren).'
      end
    end

    context 'given a string with a single pair of parens' do
      it 'returns true if parentheses are matched' do
        expect_valid_string 'This sentence has (parens).'
      end

      it 'returns false if open and close parentheses come in wrong order' do
        expect_invalid_string 'This sentence has) bad (paren order.'
      end

      it 'returns false if pair is two open parens' do
        expect_invalid_string 'This (sentence has (two open parens.'
      end

      it 'returns false if pair is two closed parens' do
        expect_invalid_string 'This sentence) has two) close parens.'
      end
    end

    context 'given a string with multiple pairs of parens' do
      it 'returns true if parens are in matching un-nested pairs' do
        expect_valid_string 'This (sentence) has (un-nested) parens'
      end

      it 'returns false if parens are not in matching un-nested pairs' do
        expect_invalid_string 'This (sentence) has (un-nested( parens'
      end

      it 'returns true if parens are in matching nested pairs' do
        expect_valid_string 'This (sentence (has) nested parens).'
      end

      it 'returns false if parens are not in matching nested pairs' do
        expect_invalid_string 'This (sentence (has( nested parens).'
      end
    end
  end
end
