class BowlingGame < ActiveRecord::Base
  PINS = 10

  #Calculate total score
  def calc_score(frame_scores)
    total = []
    frame_scores.each_with_index do |frame_score, index|

    	puts frame_scores.inspect
      if strike?(frame_score)
        total << frame_scores[index..index+2].flatten.compact[0..2].sum
      elsif spare?(frame_score)
        puts frame_scores[index..index+1].flatten.compact[0..2].inspect
        total << frame_scores[index..index+1].flatten.compact[0..2].sum if frame_scores[index..index+1].flatten.compact[0..2].length >=3
      else
        total << frame_score.sum
      end
    end
    return total.sum
  end

  #Check for spares
  def spare?(frame_score)
    frame_score.sum == PINS
  end

  #Check for strikes
  def strike?(frame_score)
    (frame_score[0] || frame_score[1]) == PINS
  end


end
