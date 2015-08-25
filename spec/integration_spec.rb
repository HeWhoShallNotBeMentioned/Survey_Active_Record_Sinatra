require("capybara/rspec")
require("./app")
require("spec_helper")
Capybara.app = Sinatra::Application


describe("/surveys", {type: :feature}) do
  it("displays empty message on index when no surveys available") do
    visit("/")
    expect(page).to have_content("There are no surveys. Why don't you add one?")
  end
end
