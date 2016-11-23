class BracesValidator

  BRACE_PAIRS = Hash['(',')','[',']','{','}']

  def self.valid?(string)
    braces = string.scan all_brackets_regexp
    close_brace_stack = []

    while braces.any?
      cursor = braces.pop

      # if it's a close brace
      if BRACE_PAIRS.values.include? cursor
        close_brace_stack.push cursor

      # if it's an open brace
      elsif BRACE_PAIRS.keys.include? cursor
        last_close_brace = close_brace_stack.pop
        return false unless matching_pair?(cursor, last_close_brace)
      end
    end

    close_brace_stack.empty?
  end

  private

  def self.matching_pair?(open, close)
    BRACE_PAIRS[open] == close
  end

  def self.all_brackets_regexp
    Regexp.new "[#{Regexp.escape (BRACE_PAIRS.keys + BRACE_PAIRS.values).join}]"
  end
end
