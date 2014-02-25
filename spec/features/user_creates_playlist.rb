require 'spec_helper'

describe "a user can create a playlist" do

  let(:user) { FactoryGirl.create(:user)}
  let(:tick_tock) { FactoryGirl.create(:song}
  let(:love_is_my_drug) { FactoryGirl.create(:song)}

  before do
    user.purchase(tick_tock)
    user.purchase(love_is_my_drug)
  end

  it "creates a playlist" do
    # Setup
    login(user)

    # Workflow for feature
    visit user_path(user)
    click_link "Create Playlist"
    fill_in "Title", with: "Sweet Beats"
    select tick_tock.title, from: "playlist_songs"
    click_button "Create"

    # Expectations
    within ".playlist" do
      expect(page).to have_content "Sweet Beats"

      within ".songs" do
        expect(page).to have_content tick_tock.title
        expect(page).to_not have_content love_is_my_drug.title
      end
    end
  end

  def login(user)
    visit "/login"
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Log in!"
  end
end