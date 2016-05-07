# Feature: Game edit
#   As a user
#   I want to edit game details
#   So I can change email and name
feature 'Game edit' do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User changes game details
  #   Given I am signed in
  #   When I change player email address & name
  #   Then I see an game updated message
  scenario 'user changes game details' do
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:bowling_game)
    login_as(user, :scope => :user)
    visit edit_bowling_game_path(game)
    fill_in 'bowling_game_player_email', :with => 'gopi@neevtech.com'
    fill_in 'bowling_game_player_name', with: 'Gopi Kaliannan'
    click_button 'Update Bowling game'
    expect(page).to have_content('Bowling game was successfully updated.')
  end

 end
