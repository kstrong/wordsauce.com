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
      { date: '4/16/2016', location: 'San Luis Obispo, CA', venue: 'Boo Boo Records' },
      { date: '4/21/2016', location: 'Los Angeles, CA', venue: 'Los Globos' },
      { date: '4/22/2016', location: 'Oceanside, CA', venue: 'Davina\'s Cabo Grill' },
      { date: '4/23/2016', location: 'Ojai, CA', venue: 'The Deer Lodge' },
      { date: '6/3/2016',  location: 'Santa Clara County, CA', venue: 'Mt. Madonna' },
      { date: '6/5/2016',  location: 'Watsonville, CA', venue: 'Live on KPIG Radio' },
      { date: '6/15/2016', location: 'San Luis Obispo, CA', venue: 'Tap It Brewery' },
      { date: '6/19/2016', location: 'Cachagua, Monterey County, CA', venue: 'Big Surreal 2016' }
    ]
  },
  {
    name: 'Summer 2016',
    dates: [
      { date: '7/17/2016', location: 'Ventura, CA', venue: 'Surf Rodeo @ Pierpont Beach', links: ['http://surfrodeo.org'] },
      { date: '8/26/2016', location: 'Paso Robles, CA', venue: 'Tooth &amp; Nail Winery', links: ['https://www.facebook.com/events/108699699573764/'] },
      { date: '8/27/2016', location: 'Grover Beach, CA', venue: 'Stone Soup Music Festival and Street Faire', links: ['http://www.aggbchamber.com/stone-soup'] },
      { date: '9/3/2016',  location: 'San Luis Obispo, CA', venue: 'Brews &amp; Bites 2016', links: ['https://nightout.com/events/slobrewsandbites/tickets'] },
      { date: '9/4/2016',  location: 'Ventura, CA', venue: 'The LAB' }
    ]
  },
  {
    name: 'Fall 2016',
    dates: [
      { date: '11/17/2016', location: 'San Luis Obispo, CA', venue: 'SLO Brew', links: ['http://www.slobrew.com/events/7002755/wordsauce-reason-to-rebel/'] }
    ]
  },
  {
    name: 'Winter 2017',
    dates: [
      { date: '12/31/2016', location: 'Morro Bay, CA', venue: 'The Siren', links: ['https://www.facebook.com/events/1690653724559375/'] },
      { date: '1/21/2017', location: 'San Luis Obispo, CA', venue: 'Fremont Theatre', links: ['https://www.facebook.com/events/1269814203062519/'] }
    ]
  },
  {
    name: 'Spring 2017',
    dates: [
      { date: '3/31/2017', location: 'San Diego, CA', venue: 'Aztec Brewing Company', links: ['http://www.aztecbrewery.com/'] },
      { date: '4/1/2017', location: 'San Diego, CA', venue: '710 Beach Club', links: ['http://www.710bc.com/'] },
      { date: '4/22/2017', location: 'Morro Bay, CA', venue: 'The Siren', links: ['http://thesirenmorrobay.com/'] },
      { date: '5/25/2017', location: 'Ventura, CA', venue: 'The Majestic Ventura Theatre', links: ['https://www.facebook.com/events/103873563463142/'] },
      { date: '5/26/2017', location: 'San Luis Obispo, CA', venue: 'Fremont Theatre', links: ['https://www.facebook.com/events/264933723946041/'] },
      { date: '6/11/2017',  location: 'Watsonville, CA', venue: 'Live on KPIG Radio' },
      { date: '6/17/2017', location: 'Santa Barbara, CA', venue: 'Live Oak Music Festival', links: ['http://www.liveoakfest.org/'] }
    ]
  },
  {
    name: 'Summer 2017',
    dates: [
      { date: '6/22/2017', location: 'Cachagua Valley, CA', venue: 'Big Surreal 2017', links: ['http://www.luvlabproductions.org/'] },
      { date: '7/15/2017', location: 'Ventura, CA', venue: 'Surf Rodeo @ Pierpont Beach', links: ['http://surfrodeo.org'] },
      { date: '7/23/2017', location: 'Paso Robles, CA', venue: 'California Mid-State Fair', links: ['https://www.midstatefair.com/fair/'] },
      { date: '8/4/2017', location: 'Santa Maria, CA', venue: 'Ca\' Del Grevino', links: ['https://grevino.com/'] },
      { date: '8/23/2017',  location: 'San Luis Obispo, CA', venue: 'SLO Brew', links: ['https://www.slobrew.com/events/7611695/wordsauce-canto/'] },
    ]
  },
  {
    name: 'Fall 2017',
    dates: [
      { date: '10/28/2017', location: 'Morro Bay, CA', venue: 'The Siren', links: ['https://www.facebook.com/events/699866660209372/'] },
      { date: '11/24/2017', location: 'Ojai, CA', venue: 'The Deer Lodge', links: ['https://www.facebook.com/events/810020579122840/'] },
      { date: '12/14/2017', location: 'San Luis Obispo, CA', venue: 'Fremont Theatre', links: ['http://www.bigbigslo.com/locals-night'] },
    ]
  },
  {
    name: 'Winter 2018',
    dates: [
      { date: '1/19/2018', location: 'Morro Bay, CA', venue: 'The Siren', links: ['https://www.facebook.com/events/1930012330659872/'] },
      { date: '2/12/2018',  location: 'San Luis Obispo, CA', venue: 'SLO Brew', links: ['https://www.facebook.com/events/1598311630251041/'] },
      { date: '3/19/2018',  location: 'Fresno, CA', venue: 'Tioga Sequoia Brewing Company', links: ['https://www.facebook.com/events/1577818665667193/'] },
    ]
  },
  {
    name: 'Spring 2018',
    dates: [
      { date: '4/20/2018',  location: 'Creston, CA', venue: 'Hoof Fest'},
      { date: '5/6/2018',  location: 'San Luis Obispo, CA', venue: 'SLO Brew', links: ['https://www.slobrew.com/events/8168705/con-brio-the-sextones-wordsauce/'] },
      { date: '6/7/2018', location: 'Morro Bay, CA', venue: 'The Siren', links: ['https://www.ticketfly.com/purchase/event/1705410'] },
    ]
  },
  {
    name: 'Summer 2018',
    dates: [
      { date: '7/3/2018',  location: 'San Luis Obispo, CA', venue: 'SLO Brew', links: ['https://www.slobrew.com/'] },
      { date: '7/4/2018',  location: 'San Francisco, CA', venue: 'Boom Boom Room' },
      { date: '7/8/2018',  location: 'Quincy, CA', venue: 'High Sierra Music Festival', links: ['http://highsierramusic.com/'] },
      { date: '8/4/2018',  location: 'Langley, WA', venue: 'Little BIG Fest', links: ['https://www.facebook.com/littlebigfestival'] },
      { date: '8/11/2018', location: 'Morro Bay, CA', venue: 'The Siren', links: ['http://www.ticketfly.com/event/1711681-wordsauce-album-release-party-morro-bay/'] },
      { date: '9/8/2018',  location: 'San Luis Obispo, CA', venue: 'SLO Brew Rock', links: ['https://www.slobrew.com/events/8557075/slo-brew-30th-anniversary-festival/'] },
      { date: '9/22/2018',  location: 'Visalia, CA', venue: 'Barrelhouse Brewing Co.', links: ['https://www.barrelhousebrewing.com/locations-visalia/'] },
    ]
  },
  {
    name: 'Fall 2018',
    dates: [
      { date: '11/10/2018',  location: 'Paso Robles, CA', venue: 'Barrelhouse Brewing Co.', links: ['https://www.barrelhousebrewing.com/locations-paso-robles'] },
    ]
  }
]

get '/' do
  shows = tours.flat_map { |tour| tour[:dates] }
  @shows = shows.select { |show| Date.strptime(show[:date], '%m/%d/%Y') >= Date.today }
  erb :sauce
end

# get '/example' do
#   shows = tours.flat_map { |tour| tour[:dates] }
#   @shows = shows.select { |show| Date.strptime(show[:date], '%m/%d/%Y') >= Date.today }
#   erb :sauce_ads
# end

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

get '/thesaucepot' do
  redirect 'http://saucepotstudios.com/', 301
end
