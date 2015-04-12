require 'rails_helper'

describe QuestionsController do
  let(:hoa) {User.create(name: "Hoa", email: "Hoanderful@impact.com", password: "123")}
  let(:question) {Question.new(title: "Wat is dis?", content: "I'm truly confused with what the goal is for this website.", user_id: hoa.id)}
  before(:each) do
    stub_current_user hoa
    stub_authorize_user!
  end

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
    it "creates a new question" do
      params = { question: {title: "Wat is dis?", content: "I'm truly confused with what the goal is for this website."}}
      post(:create, params)
      expect(Question.last.title).to eq("Wat is dis?")
    end

    # TODO: Fix invalid questions test
    it "shouldn't allow a question to be created with invalid params" do
      params = {question: {title: 123}}
      questions = Question.count
      post(:create, params)
      expect(Question.count).to eq(questions)
    end
  end

  context "update" do
    it "updates an existing question" do
      question.save
      params = {id: question.id, question: {title: "This is new", content: "This may or may not work"}}
      put(:update, params)
      expect(question.reload.title).to eq("This is new")
    end
    it "does not update a question with erronous attributes" do
      question.save
      params = {id: question.id, question: {title: 123, content: "Say my name, say my name"}}
      put(:update, params)
      expect(question.reload.title).to_not eq(123)
    end
  end

  context "destroy" do
    it "should delete an existing question" do
      question.save
      questions = Question.count
      del_question = {id: question.id}
      delete(:destroy, del_question)
      expect(Question.count).to_not eq(questions)
    end
  end

end