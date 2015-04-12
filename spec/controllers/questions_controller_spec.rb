require 'spec_helper'

describe QuestionsController do
  let(:question) {Question.new(title: "Wat is dis?", content: "I'm truly confused with what the goal is for this website.")}
  let(:inv_question) {Question.new(title: 123, content: []])}

  context "index" do
    it "returns recent questions" do
      get :index
      expect(assigns(:recent_questions)).to eq(Question.find_most_recent)
    end
    it "returns highest voted questions" do
      get :index
      expect(assigns(:highest_voted_questions)).to eq(Question.find_highest_voted.reverse)
    end
    it "returns trending questions" do
      get :index
      expect(assigns(:trending)).to eq(Question.find_trending.reverse)
    end
  end

  context "create" do
    # This might not be testing our question controllers but rails instead
    it "creates a new question" do
      params = { question: {title: "Wat is dis?", content: "I'm truly confused with what the goal is for this website."}}
      post(:create, params)
      expect(Question.last.title).to eq("Wat is dis?")
    end

    it "should create a valid question" do
      question.save
      expect(question).to be_valid
    end

    # This might not be testing our question controllers but rails instead
    it "shouldn't allow a question to be created with invalid params" do
      params = {question:{title: 123, content: []}}
      post(:create, params)
      expect(:create).to raise_error
    end

    it "should not create a invalid question" do
      inv_question.save
      expect(inv_question).to be_invalid
    end
  end

  # context "update" do
  #   it "updates an existing question" do

  #   end
  #   it "does not update a question with erronous attributes"

  #   end
  # end

  # context "destroy" do
  #   it "should delete an existing question"

  #   end
  # end

end