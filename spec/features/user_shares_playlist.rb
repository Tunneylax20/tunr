require 'spec_helper'

describe "a user can share a playlist with a friend" do
  let(:creator) do 
    User.create!({
      email: "j@k.co",
      password: "jeff",
      password_confirmation: "jeff",
      first_name: "Jeff",
      last_name: "K",
      dob: Date.today,
      balance: 100.00
    }) 
  end

  let(:viewer) do 
    User.create!({
      email: "d@t.co",
      password: "drew",
      password_confirmation: "drew",
      first_name: "Drew",
      last_name: "T",
      dob: Date.today,
      balance: 100.00
    }) 
  end

  let(:user_three) do 
    User.create!({
      email: "bryan@t.co",
      password: "bryan",
      password_confirmation: "bryan",
      first_name: "bryan",
      last_name: "T",
      dob: Date.today,
      balance: 100.00
    }) 
  end


  let(:kesha) do
    Artist.create!({
      name: "Ke$ha",
      photo_url: "http://placekitten.com/g/200/200"
    })
  end

  let(:tick_tock) do
    Song.create!({
      title: "Tick Tock",
      price: 1.99,
      artist: kesha
    })
  end

  let(:love_is_my_drug) do
    Song.create!({
      title: "Love is My Drug",
      price: 0.99,
      artist: kesha
    })
  end

  before do
    creator.purchase(tick_tock)
    creator.purchase(love_is_my_drug)
  end

  it "shares the playlist with only one friend" do
    # Setup
    login(creator)

    # Workflow for feature
    visit user_path(creator)
    click_link "Create Playlist"
    fill_in "Title", with: "Sweet Beats"
    select tick_tock.title, from: "playlist_songs"
    click_button "Create"

    # Expectations
    within ".playlist" do
      expect(page).to have_content "Sweet Beats"
      expect(page).to have_content "bryan"
    end

    logout(creator)

    login(viewer)
    visit user_path(viewer)
    clink_link "View Playlists"

    within ".playlist" do
      expect(page).to have_content "Sweet Beats"
    end

    logout(viewer)

    login(user_three)
    visit user_path(user_three)
    clink_link "View Playlists"

    within ".playlist" do
      expect(page).to_not have_content "Sweet Beats"
    end
  end

  def login(user)
    visit "/login"
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Log in!"
  end
end