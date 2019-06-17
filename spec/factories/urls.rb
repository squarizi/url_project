FactoryGirl.define do
  factory :url do
    sequence(:long_url) { |n| "http://abc-#{n}.com" }
  end
end
