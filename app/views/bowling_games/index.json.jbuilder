json.array!(@bowling_games) do |bowling_game|
  json.extract! bowling_game, :id, :player_name, :player_email, :frame_scores, :total_score
  json.url bowling_game_url(bowling_game, format: :json)
end
