ENV['RACK_ENV'] = 'development'

require_relative '../../app.rb'  # <-- your sinatra app
require 'rspec'
require 'rack/test'

# make sure to rake db:migrate and rake db:seed

describe 'Score' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "determins the overall_score" do #calcuates score over many topics
    #create a couple of items
    user = User.create(:number => "+12222222")
    Score.create(:user_id => user.id, :question_id => 1, :point => 1)
    Score.create(:user_id => user.id, :question_id => 7, :point => 1)
    Score.create(:user_id => user.id, :question_id => 2, :point => 1)
    expect(Score.overall_score(user)).to eq("Your total score for all quizzes is: 3 out of 3. That's 100.0% correct! ")
  end

  it "determine the score for the quiz only" do
    user = User.create(:number => "+133333333")
    topic = Topic.find(1)
    Score.create(:user_id => user.id, :question_id => 1, :point => 1)
    Score.create(:user_id => user.id, :question_id => 2, :point => 1)
    #five questions in seed.
    expect(Score.quiz_score(user,topic)).to eq("You got 2/5 on this quiz. ")
  end

  it "has user played before .played_before?(user_id)" do
    user = User.find(1)
    expect(Score.played_before?(user.id)).to be true

    expect(Score.played_before?(999)).to be false

  end

end
