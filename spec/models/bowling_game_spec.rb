require 'rails_helper'
describe BowlingGame  do
  before(:each) { @game = BowlingGame.new(player_email: 'ganesh.kaliannan@gmail.com',player_name: 'ganesh') }


  it 'should return false for non spare score' do
    # setup
    frame_scores = [2,2]
    expect(@game.spare?(frame_scores)).to eq false
  end


  it 'should return true for spare score' do
    # setup
    frame_scores = [5,5]
    expect(@game.spare?(frame_scores)).to eq true
  end


  it 'should return true for strike score' do
    # setup
    frame_scores = [10,0]
    expect(@game.strike?(frame_scores)).to eq true
  end

  it 'should return false for non strike score' do
    # setup
    frame_scores = [1,0]
    expect(@game.strike?(frame_scores)).to eq false
  end

  it 'should calculate bowling score for ten frames' do
    # setup
    frame_scores = [[2, 2], [2, 4], [5, 5], [4, 4], [1, 1], [4, 1], [2, 7], [5, 2], [9, 0], [8, 1]]
    expect(@game.calc_score(frame_scores)).to eq 73
  end


  it 'should calculate bowling score for two frames wwith spare' do
    # setup
    frame_scores = [[3, 7], [3, 4]]
    expect(@game.calc_score(frame_scores)).to eq 20
  end
   
    it 'should calculate bowling score for two frames with strike' do
    # setup
    frame_scores = [[10], [3, 4]]
    expect(@game.calc_score(frame_scores)).to eq 24
  end



end
