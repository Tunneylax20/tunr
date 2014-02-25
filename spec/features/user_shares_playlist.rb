require 'spec_helper'

describe "a user can share a playlist" do
  let(:creator) { FactoryGirl.create(:user) }
  let(:shared) { FactoryGirl.create(:user) }
  let(:some_other_user) { FactoryGirl.create(:user) }

  let(:playlist) { FactoryGirl.create(:playlist, user: creator) }

  it "can only be seen by people who it is shared with" do
    login(creator)

    visit user_path(creator)
    click_link playlist.title
    click_link "Edit"
    select shared.email, from: "Shared"
    click_button "Save"

    logout(creator)
    login(shared)

    visit user_path(shared)
    within ".playlists" do
      expect(page).to have_content playlist.title
    end
    click_link playlist.title
    within ".playlist" do
      expect(page).to have_content playlist.title
    end

    logout(shared)
    login(some_other_user)

    visit user_path(some_other_user)
    within ".playlists" do
      expect(page).to_not have_content playlist.title
    end
    visit playlist_path(playlist)
    expect(page).to_not have_content playlist.title
  end

  def login(user)
    visit "/login"
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Log in!"
  end

  def logout(user)
    click_link "Log Out #{user.first_name}!"
  end
end