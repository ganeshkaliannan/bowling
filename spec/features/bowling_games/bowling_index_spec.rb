# Feature: Bowling index page
#   As a user
#   I want to see a list of bowlling games
feature 'Bowling index page' do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Games listed on bowling index page
  #   Given I am signed in
  #   When I visit the bowling index page
  #   Then I see all player name and email address
  scenario 'user sees all player name & email' do
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:bowling_game)
    login_as(user, scope: :user)
    visit bowling_games_path
    expect(page).to have_content game.player_email
    expect(page).to have_content game.player_name
  end

end
