require("spec_helper")

describe(Question) do
  describe("#answers") do
    it("returns all answers for a question") do
      test_question = Question.create({:question => "What is your most embarassing moment?"})
      test_answer1 = Answer.create({:answer => "answer1", :question_id => test_question.id})
      test_answer2 = Answer.create({:answer => "answer2", :question_id => test_question.id})
      expect(test_question.answers()).to(eq([test_answer1, test_answer2]))
    end
  end
end
