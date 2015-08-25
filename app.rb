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

get ('/') do
  @surveys = Survey.all()
  erb(:index)
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
