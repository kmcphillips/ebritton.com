require "sinatra/base"
require "json"

class EbrittonApp < Sinatra::Application
  set :erb, format: :html5

  get '/' do
    erb :index
  end

  get '/stylesheet.css' do
    scss :stylesheet
  end

  helpers do
    def obfuscated_email(text:nil, link_class:"")
      obfuscated = "#{ email_parts.to_json }.reverse().join('@')"
      "<script>
        document.write('<a href=\"mailto:' + #{ obfuscated } + '\" class=\"#{ link_class }\">#{ text || ["' + ", obfuscated, " + '"].join }</a>');
      </script>"
    end

    def email_parts
      ["eliot", "ebritton.com"].reverse
    end
  end
end
