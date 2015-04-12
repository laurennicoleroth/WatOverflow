require 'rails_helper'

describe AnswersController do
  let(:tracy) {User.create(name: "Tracy", email: "ADrinkWith@JamAndBread.com", password: "onesiesANDdecals")}
  let(:question) {Question.create(title: "Question?", content: "Answer!", user_id: tracy.id)}
  let(:answer) {Answer.new(body: "Sound of music, man. Sound of music.", user_id: tracy.id, question_id: question.id)}
  before(:each) do
    stub_current_user tracy
    stub_authorize_user!
  end

  context "index" do
    it "returns all answers" do
      get :index
      expect(assigns(:answers)).to eq(Answer.all)
    end
  end

  context "create" do
    it "creates a new answer" do
      params = {answer: {body: "THIS IS A TESTTTT (300 movie reference)", question_id: question.id}}
      post(:create, params)
      expect(Answer.last.body).to eq("THIS IS A TESTTTT (300 movie reference)")
    end

    # TODO: Fix invalid answers test
    it "does not create a new answer if it is invalid" do
      params = {}
      answers = Answer.count
      post(:create, params)
      expect(Answer.count).to eq(answers)
    end
  end

  context "update" do
    it "updates an answer" do
      answer.save
      params = {id: answer.id, answer: {body: "Why rspec, why"}}
      put(:update, params)
      expect(answer.reload.body).to eq("Why rspec, why")
    end
    it "does not update a answer invalid attributes" do
      answer.save
      params = {id: answer.id, answer: {body: [] }}
      put(:update, params)
      expect(answer.reload.body).to eq("Sound of music, man. Sound of music.")
    end
  end

  context "destroy" do
    it "should delete an existing answer" do
      answer.save
      answers = Answer.count
      del_answer = {id: answer.id}
      delete(:destroy, del_answer)
      expect(Answer.count).to_not eq(answers)
    end
  end
end