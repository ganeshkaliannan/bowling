class BowlingGamesController < ApplicationController
  before_action :authenticate_user!

  TOTAL_FRAMES = 10
  before_action :set_bowling_game, only: [:show, :edit, :update, :destroy,:bowling_frame,:score_collecter,:calculate_score]

  # GET /bowling_games
  # GET /bowling_games.json
  def index
    @bowling_games = BowlingGame.all
  end

  # GET /bowling_games/1
  # GET /bowling_games/1.json
  def show
  end

  # GET /bowling_games/new
  def new
    @bowling_game = BowlingGame.new
  end

  # GET /bowling_games/1/edit
  def edit
  end

  # POST /bowling_games
  # POST /bowling_games.json
  def create
    @bowling_game = BowlingGame.new(bowling_game_params)

    respond_to do |format|
      if @bowling_game.save
        format.html { redirect_to @bowling_game, notice: 'Bowling game was successfully created.' }
        format.json { render :show, status: :created, location: @bowling_game }
      else
        format.html { render :new }
        format.json { render json: @bowling_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bowling_games/1
  # PATCH/PUT /bowling_games/1.json
  def update
    respond_to do |format|
      if @bowling_game.update(bowling_game_params)
        format.html { redirect_to @bowling_game, notice: 'Bowling game was successfully updated.' }
        format.json { render :show, status: :ok, location: @bowling_game }
      else
        format.html { render :edit }
        format.json { render json: @bowling_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bowling_games/1
  # DELETE /bowling_games/1.json
  def destroy
    @bowling_game.destroy
    respond_to do |format|
      format.html { redirect_to bowling_games_url, notice: 'Bowling game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #building frame logic
  def bowling_frame
    if params[:frame_number].blank?
      session["game_#{params[:id]}".to_sym] = Array.new
      @frame_number = 1
    else
      @frame_number = params[:frame_number].to_i+1
    end
  end

  #collecting the score for each frames and store it on the session with dynamic key
  def score_collecter
    scores = [params[:try_one].to_i,params[:try_two].to_i]
    if scores.include?(10)
      scores = [10]
    end
    frame_number = params[:frame_number].to_i
    session["game_#{params[:id]}".to_sym] << scores
    unless frame_number == TOTAL_FRAMES
      redirect_to bowling_frame_bowling_game_path(@bowling_game,frame_number: frame_number)
    else
      redirect_to calculate_score_bowling_game_path(@bowling_game,frame_number: frame_number)
    end
  end

  #calculating score and generte the final result
  def calculate_score
    frame_scores = session["game_#{params[:id]}".to_sym]
    if frame_scores.length >= TOTAL_FRAMES
      @total_score = @bowling_game.calc_score(frame_scores)
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_bowling_game
    @bowling_game = BowlingGame.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bowling_game_params
    params.require(:bowling_game).permit(:player_name, :player_email)
  end
end
