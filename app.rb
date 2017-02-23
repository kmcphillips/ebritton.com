require "sinatra/base"

class EbrittonApp < Sinatra::Application
  set :erb, format: :html5

  get '/' do
    erb :index
  end

  get '/stylesheet.css' do
    scss :stylesheet
  end
end
