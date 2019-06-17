require "rails_helper"

RSpec.feature "Shorten a URL", type: :feature do

  scenario "A user submits a long URL to be shortened" do
    visit "/"

    expect(page).to have_text "Enter the full URL to be shortened"

    invalid_url = "this.com/will/not/work"
    fill_in "url_long_url", with: invalid_url
    expect {
      click_on "Shrink it!"
    }.not_to change(Url, :count)

    expect(page).to have_text "not a valid URL"
    expect(page).to have_selector "#url_long_url[value='#{invalid_url}']"

    fill_in_and_verify_url("http://bukk.it/shipit.jpg")

    click_on "Shorten another"

    second_long_url = "http://bukk.it/squirrel-catapult.gif"
    fill_in_and_verify_url(second_long_url)

    click_on "Try it out!"

    expect(current_url).to eq second_long_url
  end

  def fill_in_and_verify_url(long_url)
    fill_in "url_long_url", with: long_url

    expect {
      click_on "Shrink it!"
      expect(page).to have_text "Success"
    }.to change(Url, :count).by(1)

    new_url = Url.last

    expect(page).to have_text "Here is your short URL:"
    expect(page).to have_text new_url.token
    expect(page).to have_text new_url.long_url

    new_url
  end

end
