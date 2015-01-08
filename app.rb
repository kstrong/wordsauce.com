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
tours = [
  {
    name: 'Sauce or Die Tour 2014',
    dates: [
      { date: '7/13/2014', location: 'Ventura, CA', venue: 'Surf Rodeo @ Pierpont Beach', links: ['http://surfrodeo.org'] },
      { date: '7/25/2014', location: 'Cayucos, CA', venue: 'Cayucos Tavern', links: ['http://www.oldcayucostavern.com/'] },
      { date: '7/29/2014', location: 'San Luis Obispo, CA', venue: 'Frog N Peach', links: ['http://www.frogandpeachpub.com/'] },
      { date: '8/1/2014', location: 'Visalia, CA', venue: 'The Cellar Door', links: ['https://www.facebook.com/events/727321980660712/?ref=5'] },
      { date: '8/2/2014', location: 'Ventura, CA', venue: 'Bombay Bar &amp; Grill', links: ['http://www.bombaybarandgrill.com/'] },
      { date: '8/4/2014', location: 'Santa Monica, CA', venue: 'TRiP', links: ['http://www.tripsantamonica.com/'] },
      { date: '8/7/2014', location: 'Long Beach, CA', venue: 'Liquid Lounge', links: ['https://www.facebook.com/pages/Liquid-Lounge/118392788173092'] },
      { date: '8/8/2014', location: 'Lomita, CA', venue: 'The Firehouse', links: ['https://www.facebook.com/firehouse.lomita'] },
      { date: '8/9/2014', location: 'San Diego, CA', venue: 'Casa De Snowdrop', links: [] },
      { date: '8/11/2014', location: 'Anaheim, CA', venue: 'World Famous Doll Hut', links: ['https://www.facebook.com/worldfamousdh'], prtm: true },
      { date: '8/13/2014', location: 'Gilroy, CA', venue: 'Studio 222', links: ['https://www.facebook.com/studio222productions'] },
      { date: '8/14/2014', location: 'San Jose, CA', venue: 'The Caravan', links: ['https://www.facebook.com/CaravanLounge'], prtm: true },
      { date: '8/15/2014', location: 'San Jose, CA', venue: 'The Back Bar', links: ['https://www.facebook.com/backbar408'] },
      { date: '8/16/2014', location: 'Half Moon Bay, CA', venue: 'Old Princeton Landing', links: ['http://theoldprincetonlanding.com/music-schudule/august-2014/'] },
      { date: '8/18/2014', location: 'Pacifica, CA', venue: 'Winter\'s Tavern', links: ['http://winterstavern.com/'] },
      { date: '8/21/2014', location: 'Alameda, CA', venue: 'The Fireside Lounge', links: ['http://www.thefiresidelounge.com/'] },
      { date: '8/22/2014', location: 'Eureka, CA', venue: 'The Siren\'s Song Tavern', links: ['http://www.thesirenssongtavern.com/'] },
      { date: '8/23/2014', location: 'Coos Bay, OR', venue: 'Blue Moon Saloon &amp; Cafe', links: ['https://www.facebook.com/pages/Blue-Moon-Saloon-Cafe/464595053656497'] },
      { date: '8/26/2014', location: 'Medford, OR', venue: 'Johnny B\'s', links: ['https://www.facebook.com/pages/Johnny-Bs/166694203347915'], prtm: true },
      { date: '8/27/2014', location: 'Ashland, OR', venue: 'Club 66', links: ['https://www.facebook.com/Club66MusicCafe'] },
      { date: '8/28/2014', location: 'Auburn, CA', venue: 'Pistol Petes', links: ['https://www.facebook.com/pages/Pistol-Petes-Brew-Cue/115203675165310'] },
      { date: '8/29/2014', location: 'Ukiah, CA', venue: 'Ukiah Brewing Company', links: ['http://ukiahbrewing.com/'] },
      { date: '8/30/2014', location: 'Concord, CA', venue: 'Red Hat', links: ['https://www.facebook.com/redhatsportsbar'] }
    ]
  },
  {
    name: 'Fall 2014',
    dates: [
      { date: '9/12/2014', location: 'San Diego, CA', venue: 'Gallagher\'s', links: ['http://gallagherspubob.com/'] },
      { date: '10/2/2014', location: 'Pomona, CA', venue: 'Flyway at Fox', links: ['https://www.facebook.com/events/1487677891492088/'] },
      { date: '10/31/2014', location: 'San Luis Obispo, CA', venue: 'Cal Poly', links: [] },
      { date: '11/15/2014', location: 'Lompoc, CA', venue: 'Johnny\'s Bar &amp; Grill', links: ['https://www.facebook.com/events/1491665211104852/'] },
      { date: '11/18/2014', location: 'San Luis Obispo, CA', venue: 'Frog N Peach', links: [] },
      { date: '11/22/2014', location: 'Ventura, CA', venue: 'Bombay Bar &amp; Grill', links: [] },
      { date: '12/12/2014', location: 'Paso Robles, CA', venue: 'Downtown Brewing Company', links: [] },
      { date: '12/20/2014', location: 'San Luis Obispo, CA', venue: 'Creekside Brewing Company', links: [] }
    ]
  },
  {
    name: 'Winter 2015',
    dates: [
      { date: '1/23/2014', location: 'Avila Beach, CA', venue: 'Mr. Rick\'s', links: [] }
    ]
  }
]

get '/' do
  shows = tours.flat_map { |tour| tour[:dates] }
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
  @tours = tours
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
