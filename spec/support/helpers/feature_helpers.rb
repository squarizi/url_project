module FeatureHelpers

  # Opens the page in the public directory so images, JS & CSS work properly
  def show_page(port = 3000)
    save_page Rails.root.join("public", "capybara.html")
    %x(launchy http://localhost:#{port}/capybara.html)
  end

end
