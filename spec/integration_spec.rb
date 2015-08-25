require("spec_helper")
require("capybara/rspec")
require("./app")
Capybara.app = Sinatra::Application


describe("/surveys", {type: :feature}) do
  it("displays empty message on index when no surveys available") do
    visit("/")
    expect(page).to have_content("There are no surveys.")
  end

  it("successfully adds a survey") do
    visit("/")
    fill_in("title", with: "Who Am I?")
    click_button("Add Survey")
    expect(page).to have_content("Who Am I?")
  end

  it("successfully displays a survey") do
    survey = Survey.create({title: "Who Am I?"})
    visit("/")
    click_link("Who Am I?")
    expect(page).to have_content("Who Am I?")
  end
end
