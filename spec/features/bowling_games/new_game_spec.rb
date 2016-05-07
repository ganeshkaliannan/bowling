# Feature: Manage bowling game
#   As a user
#   I want to create the new bowling game
feature 'New Bowling creation' do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Visitor can sign up with valid email address and password
  #   Given I am not signed in
  #   When I sign up with a valid email address and password
  #   Then I see a successful sign up message
  scenario 'visitor can create the new bowling game with valid email address and name' do
    user = FactoryGirl.create(:user)
    login_as(user, scope: :user)
    visit new_bowling_game_path
    fill_in 'bowling_game_player_email', with: 'ganesh.kaliannan@gmail.com'
    fill_in 'bowling_game_player_name', with: 'Ganesh Kaliannan'
    click_button 'Create Bowling game'
    expect(page).to have_content('Bowling game was successfully created.')
  end
end
