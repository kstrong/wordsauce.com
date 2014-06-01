require 'sinatra'
require 'sinatra/assetpack'

assets do
  serve '/js', from: 'js'
  serve '/bower_components', from: 'bower_components'

  js :modernizr, [
    '/bower_components/modernizr/modernizr.js'
  ]

  js :libs, [
    '/bower_components/jquery/dist/jquery.js',
    '/bower_components/foundation/js/foundation.js'
  ]

  js :application, [
    '/js/app.js'
  ]

  js_compression :jsmin
end

get '/' do
  erb :sauce
end

get '/found' do
  erb :foundation_sample
end

get '/band' do
  erb :band
end

get '/music' do
  erb :music
end

get '/tour' do
  erb :tour
end

get '/media' do
  erb :media
end

get '/contact' do
  erb :contact
end
