require 'rails_helper'

describe CommentsController do
  let(:qcomment) {Comment.new(body: "Comment to a question", commentable_type: "Question")}
  let(:acomment) {Comment.new(body: "Comment to an answer", commentable_type: "Answer")}
  let(:ben) {User.create(name: "Ben", email: "Somethingclever@harharhar.com", password: "testing123")}
  before(:each) do
    stub_current_user ben
    stub_authorize_user!
  end

  context 'create' do
    it "creates a new comment" do
      params = {comment: {body: "Praying for the test to work", commentable_type: "Question"}}
      post(:create, params)
      expect(Comment.last.body).to eq("Praying for the test to work")
    end

    # # TODO: Fix invalid comments test
    it "does not create a new comment if it is invalid" do
      # params = {comment: {body:}}
      comments = Comment.count
      post(:create, params)
      expect(Comment.count).to eq(comments)
    end
  end

  context 'update' do
     it "updates an comment" do
      qcomment.save
      params = {id: qcomment.id, comment: {body: "let's switch it up"}}
      put(:update, params)
      expect(qcomment.reload.body).to eq("let's switch it up")
    end
    it "does not update a comment invalid attributes" do
      qcomment.save
      params = {id: qcomment.id, comment: {body: [] }}
      put(:update, params)
      expect(qcomment.reload.body).to eq("Comment to a question")
    end
  end

  context 'destroy' do
    it "should delete an existing comment" do
      acomment.save
      comments = Comment.count
      del_comment = {id: acomment.id}
      delete(:destroy, del_comment)
      expect(Comment.count).to_not eq(comments)
    end
  end
end