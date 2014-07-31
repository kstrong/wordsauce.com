require 'sinatra'
require 'sinatra/assetpack'
require 'sinatra/content_for'

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

# Should link to venue and location
shows = [
  { date: '7/13/2014', location: 'Ventura, CA', venue: 'Surf Rodeo @ Pierpont Beach', links: ['http://surfrodeo.org'] },
  { date: '7/25/2014', location: 'Cayucos, CA', venue: 'Cayucos Tavern', links: [] },
  { date: '7/29/2014', location: 'San Luis Obispo, CA', venue: 'Frog N Peach', links: ['http://www.frogandpeachpub.com/'] },
  { date: '8/1/2014', location: 'Visalia, CA', venue: 'The Cellar Door', links: ['https://www.facebook.com/events/727321980660712/?ref=5'] },
  { date: '8/2/2014', location: 'Ventura, CA', venue: 'Bombay Bar &amp; Grill', links: ['http://www.bombaybarandgrill.com/'] },
  { date: '8/4/2014', location: 'Santa Monica, CA', venue: 'TRiP', links: [] },
  { date: '8/7/2014', location: 'Long Beach, CA', venue: 'Liquid Lounge', links: [] },
  { date: '8/8/2014', location: 'Lomita, CA', venue: 'The Firehouse', links: [] },
  { date: '8/9/2014', location: 'San Diego, CA', venue: 'Casa De Snowdrop', links: [] },
  { date: '8/13/2014', location: 'Gilroy, CA', venue: 'Studio 222', links: [] },
  { date: '8/15/2014', location: 'San Jose, CA', venue: 'The Back Bar', links: [] },
  { date: '8/16/2014', location: 'Half Moon Bay, CA', venue: 'Old Princeton Landing', links: [] },
  { date: '8/18/2014', location: 'Pacifica, CA', venue: 'Winter\'s Tavern', links: [] },
  { date: '8/21/2014', location: 'Alameda, CA', venue: 'The Fireside Lounge', links: [] },
  { date: '8/22/2014', location: 'Eureka, CA', venue: 'The Siren\'s Song Tavern', links: [] },
  { date: '8/27/2014', location: 'Ashland, OR', venue: 'Club 66', links: [] },
  { date: '8/28/2014', location: 'Auburn, CA', venue: 'Pistol Petes', links: [] },
  { date: '8/29/2014', location: 'Ukiah, CA', venue: 'Ukiah Brewing Company', links: ['http://ukiahbrewing.com/'] },
  { date: '8/30/2014', location: 'Concord, CA', venue: 'Red Hat', links: [] }
]

get '/' do
  @shows = shows.select { |show| Date.strptime(show[:date], '%m/%d/%Y') >= Date.today }
  erb :sauce
end

get '/band' do
  erb :band
end

get '/music' do
  erb :music
end

get '/tour' do
  @shows = shows
  erb :tour
end

get '/media' do
  erb :media
end

get '/contact' do
  erb :contact
end

get '/epk' do
  erb :epk, :layout => :no_menu
end
