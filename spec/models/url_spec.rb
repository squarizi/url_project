require 'rails_helper'

RSpec.describe Url, type: :model do
  it "sets the token when creating a new record" do
    url = build :url
    expect {
      url.valid?
    }.to change(url, :token).from(nil)
  end

  it "sets the token to a 7-character alphanumeric value" do
    expect(create(:url, token: '').token).to match /\A[A-Z0-9]{7}\z/
  end

  it "uses the :token value as the URL parameter" do
    url = build :url, token: "ABCD123"
    expect(url.to_param).to eq url.token
  end

  it "does not change the token when updating an existing record" do
    url = create :url
    expect {
      url.update_attributes(updated_at: Time.zone.now)
    }.not_to change(url, :token)
  end

  it "requires a long URL" do
    expect(build :url, long_url: nil).not_to be_valid
  end

  it "requires that the long URL be a valid URL" do
    expect(build :url, long_url: "http/not/valid").not_to be_valid
  end

  describe ".with_token" do
    let!(:url) { create :url }

    it "returns the Url with the given token value" do
      expect(Url.with_token(url.token)).to eq url
    end

    context "given multiple matching tokens" do
      let!(:url2) { build(:url, token: url.token).tap { |u| u.save(validate: false) } }

      it "returns the first Url only" do
        expect(Url.with_token(url2.token)).to eq url
      end
    end
  end

  context 'when token generated is nearby than a persisted token' do
    let!(:url_test) { create(:url, token: 'ABCX123') }

    before { create(:url, token: 'ABCD123') }

    it 'should be changed the token value' do
      expect(url_test.token).not_to eq 'ABCX123'
    end
  end
end
