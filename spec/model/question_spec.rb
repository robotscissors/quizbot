ENV['RACK_ENV'] = 'development'

require_relative '../../app.rb'  # <-- your sinatra app
require 'rspec'
require 'rack/test'

# make sure to rake db:migrate and rake db:seed

describe 'Question' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end


  it ".get_first_id" do #retrieves the first question id
    topic = Topic.first
    expect(Question.get_first_id(topic)).to eq(1)
  end

  it ".get_question(postion)" do #used to get the question based on array position
    expect(Question.get_question(1)).to  eq("You can catch the flu from the vaccine. (Reply T or F)")
  end

  it ".get_answer(current_place)" do # used to retrieve the answer from the question position
    current_place = Score.create(:user_id => 1, :question_id => 1) #point is nil
    expect(Question.get_answer(current_place)).not_to be_empty
    expect(Question.get_answer(current_place)).to eq('f')
  end

  it ".is_there_a_next_question?(user)" do # is there a next question?
    current_place = Score.create(:user_id => 1, :question_id => 1) #point is nil
    expect(Question.get_answer(current_place)).not_to be_empty
    User.create(:number => "+13232221111")
    user = User.find(1)
    expect(Question.is_there_a_next_question?(user)).to be true
  end

  it ".repeat_question(user)" do
    user = User.find(1)
    expect(Question.repeat_question(user)).to eq("The question is: You can catch the flu from the vaccine. (Reply T or F)")
  end

  it ".next_question(user)" do
    user = User.find(1)
    expect(Question.next_question(user)).to eq("Your next question: Do you need a flu shot every year? (Reply T or F)")
  end
end
