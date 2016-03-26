require 'sinatra'
require 'sinatra/assetpack'
require 'sinatra/config_file'
require 'sinatra/content_for'

config_file 'configuration.yml'

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
      { date: '1/23/2015', location: 'Avila Beach, CA', venue: 'Mr. Rick\'s', links: [] },
      { date: '2/10/2015', location: 'San Luis Obispo, CA', venue: 'Frog N Peach', links: [] },
      { date: '2/21/2015', location: 'Los Osos, CA', venue: 'Sweet Springs Saloon', links: [], prtm: true },
      { date: '2/26/2015', location: 'San Luis Obispo, CA', venue: 'SLO Brew', links: [] }
    ]
  },
  {
    name: 'Spring 2015',
    dates: [
      { date: '3/21/2015', location: 'San Luis Obispo, CA', venue: '273 Fest @ Tap It Brewery', links: [] },
      { date: '4/4/2015',  location: 'Ventura, CA', venue: 'Bombay Bar &amp; Grill', links: [] },
      { date: '4/24/2015', location: 'Gilroy, CA', venue: 'The Longhouse' },
      { date: '4/25/2015', location: 'Concord, CA', venue: 'Red Hat' },
      { date: '5/2/2015',  location: 'Cayucos, CA', venue: 'Hoof Fest' },
      { date: '6/5/2015',  location: 'Santa Barbara, CA', venue: 'Velvet Jones' },
      { date: '6/20/2015', location: 'San Luis Obispo, CA', venue: 'Tap It Brewery' }
    ]
  },
  {
    name: 'Summer 2015',
    dates: [
      { date: '7/18/2015', location: 'San Luis Obispo, CA', venue: 'SLO Brew', links: ['http://www.slobrewingco.com/calendar/view/3414'] },
      { date: '7/24/2015', location: 'Gilroy, CA', venue: 'The Longhouse' },
      { date: '7/25/2015', location: 'Tulare, CA', venue: 'Halfy\'s' },
      { date: '7/26/2015', location: 'Ventura, CA', venue: 'Bombay Bar &amp; Grill' },
      { date: '8/15/2015', location: 'Half Moon Bay, CA', venue: 'Old Princeton Landing' },
      { date: '9/7/2015',  location: 'San Luis Obispo, CA', venue: 'SLO Brew', links: ['http://www.slobrewingco.com/calendar/view/3437'] },
      { date: '9/18/2015', location: 'Ventura, CA', venue: 'Discovery', links: ['https://nightout.com/events/zion-i/9-18-2015/tickets#.VfYM453BzGc'] }
    ]
  },
  {
    name: 'Fall 2015',
    dates: [
      { date: '10/6/2015',  location: 'San Luis Obispo, CA', venue: 'Frog N Peach' },
      { date: '10/23/2015', location: 'Morro Bay, CA', venue: 'The Siren' },
      { date: '10/29/2015', location: 'San Luis Obispo, CA', venue: 'SLO Brew', links: ['http://www.slobrewingco.com/calendar/view/3473'] },
      { date: '11/7/2015',  location: 'San Luis Obispo, CA', venue: 'Tap It Brewery' },
      { date: '12/18/2015',  location: 'San Luis Obispo, CA', venue: 'SLO Brew', links: ['http://www.slobrewingco.com/calendar/view/3496'] },
      { date: '12/19/2015',  location: 'Morro Bay, CA', venue: 'The Siren' }
    ]
  },
  {
    name: 'Winter 2016',
    dates: [
      { date: '1/21/2016', location: 'San Luis Obispo, CA', venue: 'Fremont Theatre', links: ['https://www.facebook.com/events/1738295209722581/'] }
    ]
  },
  {
    name: 'Spring 2016',
    dates: [
      { date: '4/21/2016', location: 'Los Angeles, CA', venue: 'Los Globos' }
    ]
  }
]

get '/' do
  shows = tours.flat_map { |tour| tour[:dates] }
  @shows = shows.select { |show| Date.strptime(show[:date], '%m/%d/%Y') >= Date.today }
  erb :sauce
end

get '/example' do
  shows = tours.flat_map { |tour| tour[:dates] }
  @shows = shows.select { |show| Date.strptime(show[:date], '%m/%d/%Y') >= Date.today }
  erb :sauce_ads
end

get '/band' do
  erb :band
end

get '/music' do
  erb :music
end

get '/tour' do
  @tours = tours.reverse
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

get '/store' do
  redirect settings.store_url, 302
end
