require "rails_helper"

RSpec.feature "Error handling", type: :feature do

  scenario "The application gracefully handles invalid short URLs" do
    visit "/FOO"

    expect(page).to have_text "404 Not Found"
    expect(page).to have_text /You tried to access 'http:\/\/[\w\.].*\/FOO', which is not a valid page./

    click_on "Take Me Home"

    expect(current_path).to eq new_url_path
  end

end
