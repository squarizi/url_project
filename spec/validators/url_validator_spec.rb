require "rails_helper"

RSpec.describe UrlValidator do

  subject(:validator) { UrlValidator.new(attributes: :url)}

  let(:error_array) { [] }
  let(:errors) { double "Errors", "[]" => error_array }
  let(:model) { double "Model", errors: errors}

  ["http://www.test.com",
   "http://test.com",
   "http://test.net",
   "https://www.test.com",
   "http://a.fi",
   "https://usa.gov"].each do |good_url|
    it "should pass with good URL '#{good_url}'" do
      expect(model).not_to receive(:errors)
      validator.validate_each(model, "url", good_url)
    end
  end

  ["www.test.com",
   "test.com",
   "junk://test.net",
   "htps://www.test.com",
   "//a.fi",
   "lakjdsf"].each do |bad_url|
    it "should fail with invalid URL '#{bad_url}'" do
      expect(error_array).to receive("<<").once
      validator.validate_each(model, "url", bad_url)
    end
  end

end
