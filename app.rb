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