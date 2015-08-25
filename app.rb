ENV['RACK_ENV'] = 'development'
require('sinatra/activerecord')
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/survey/')
require('./lib/question/')
require('./lib/answer/')
require('pg')
require('pry')

get ("/") do
  erb(:index)
end

get ('/surveys') do
  @surveys = Survey.all()
  erb(:surveys)
end

post ('/surveys/new') do
  title = params.fetch('title')
  @survey = Survey.create({title: title})
  erb(:survey)
end

get ("/surveys/:id") do
  id = params.fetch('id').to_i
  @survey = Survey.find(id)
  erb(:survey)
end

get ("/surveys/:id/edit") do
  id = params.fetch('id').to_i
  @survey = Survey.find(id)
  erb(:edit_survey)
end

patch ("/surveys/:id") do
  id = params.fetch('id').to_i
  title = params.fetch("title")
  @survey = Survey.find(id)
  @survey.update({title: title})
  erb(:survey)
end

delete ("/surveys/:id") do
  id = params.fetch("id").to_i
  Survey.find(id).destroy()
  @surveys = Survey.all()
  redirect('/')
end

post ("/surveys/:survey_id/questions/new") do
  survey_id = params.fetch("survey_id").to_i
  question = params.fetch("question")
  @survey = Survey.find(survey_id)
  Question.create({survey_id: survey_id, question: question})
  erb(:survey)
end

get ("/questions/:id/edit") do
  id = params.fetch('id').to_i
  @question = Question.find(id)
  erb(:edit_question)
end

patch ("/questions/:id") do
  id = params.fetch('id').to_i
  question_value = params.fetch("question")
  question = Question.find(id)
  survey_id = question.survey_id()
  @survey = Survey.find(survey_id)
  question.update({question: question_value})
  erb(:survey)
end

delete ("/questions/:id") do
  id = params.fetch("id").to_i
  question = Question.find(id)
  survey_id = question.survey_id
  question.destroy()
  @survey = Survey.find(survey_id)
  erb(:survey)
end

get ("/take/surveys") do
  @surveys = Survey.all
  erb(:take_surveys)
end

get ("/take/surveys/:id/edit") do
  id = params.fetch('id').to_i
  @survey = Survey.find(id)
  @questions = @survey.questions()
  erb(:take_survey)
end

patch ("/take/surveys/:survey_id") do
  survey_id = params.fetch("survey_id").to_i
  survey = Survey.find(survey_id)
  survey.questions.each do |question|
    answer = params.fetch("#{question.id}")
    Answer.create({answer: answer, question_id: question.id})
  end
  @surveys = Survey.all
  erb(:take_surveys)
end
