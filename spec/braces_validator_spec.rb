require 'rspec'
require 'braces_validator'

describe BracesValidator do
  describe 'valid?' do
    def expect_validation_to_be(test_string, expected_value)
      actual_value = BracesValidator.valid?(test_string)
      expect(actual_value).to be expected_value
    end

    context 'given a string with no braces' do
      it 'returns true' do
        expect_validation_to_be 'This sentence has no parens.', true
      end
    end

    context 'given single, unmatched parens' do
      it 'returns false if open parentheses do not have close parentheses' do
        expect_validation_to_be 'This sentence has (only an open paren.', false
      end

      it 'returns false if close parentheses do not have open parentheses' do
        expect_validation_to_be 'This sentence has only a close paren).', false
      end
    end

    context 'given a string with a single pair of parens' do
      it 'returns true if parentheses are matched' do
        expect_validation_to_be 'This sentence has (parens).', true
      end

      it 'returns false if open and close parentheses come in wrong order' do
        expect_validation_to_be 'This sentence has) bad (paren order.', false
      end

      it 'returns false if pair is two open parens' do
        expect_validation_to_be 'This (sentence has (two open parens.', false
      end

      it 'returns false if pair is two closed parens' do
        expect_validation_to_be 'This sentence) has two) close parens.', false
      end
    end

    context 'given a string with multiple pairs of parens' do
      it 'returns true if parens are in matching un-nested pairs' do
        expect_validation_to_be 'This (sentence) has (un-nested) parens', true
      end

      it 'returns false if parens are not in matching un-nested pairs' do
        expect_validation_to_be 'This (sentence) has (un-nested( parens', false
      end

      it 'returns true if parens are in matching nested pairs' do
        expect_validation_to_be 'This (sentence (has) nested parens).', true
      end

      it 'returns false if parens are not in matching nested pairs' do
        expect_validation_to_be 'This (sentence (has( nested parens).', false
      end
    end
  end
end
