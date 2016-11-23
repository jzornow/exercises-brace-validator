shared_examples 'a brace validator' do |brace_type, open_brace, close_brace|

  context "given single, unmatched #{brace_type}" do
    it "returns false if open #{brace_type} is unclosed" do
      expect_invalid_string "This sentence has #{open_brace}only an open brace."
    end

    it "returns false if close #{brace_type} is unopened" do
      expect_invalid_string "This sentence has only a close#{close_brace}."
    end
  end

  context "given a string with a single pair of #{brace_type}s" do
    it "returns true if #{brace_type}s are matched" do
      expect_valid_string "This #{open_brace}sentence is matched#{close_brace}."
    end

    it "returns false if open and close #{brace_type}s come in wrong order" do
      expect_invalid_string "Bad #{close_brace}sentence#{open_brace}."
    end

    it "returns false if pair is two open #{brace_type}s" do
      expect_invalid_string "Bad #{open_brace}sentence#{open_brace}."
    end

    it "returns false if pair is two closed #{brace_type}s" do
      expect_invalid_string "Bad #{close_brace}sentence#{close_brace}."
    end
  end

  context "given a string with multiple pairs of #{brace_type}s" do
    it "returns true if #{brace_type}s are in matching un-nested pairs" do
      expect_valid_string "This is a good #{open_brace}example#{close_brace} "\
                          "#{open_brace}sentence#{close_brace}."
    end

    it "returns false if #{brace_type}s are not in matching un-nested pairs" do
      expect_invalid_string "This #{open_brace}sentence#{close_brace} has " \
                            "#{open_brace}un-nested#{open_brace} #{brace_type}s"
    end

    it "returns true if #{brace_type}s are in matching nested pairs" do
      expect_valid_string "This #{open_brace}sentence #{open_brace}has" \
                          "#{close_brace} nested #{brace_type}s#{close_brace}."
    end

    it "returns false if #{brace_type}s are not in matching nested pairs" do
      expect_invalid_string "This #{open_brace}sentence #{open_brace}has" \
                            "#{open_brace} nested #{brace_type}s#{close_brace}."
    end
  end

end
