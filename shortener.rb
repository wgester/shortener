require 'sinatra'
require 'active_record'
require 'pry'
require 'securerandom'

###########################################################
# Configuration
###########################################################

set :public_folder, File.dirname(__FILE__) + '/public'


configure :development, :production do
    ActiveRecord::Base.establish_connection(
       :adapter => 'sqlite3',
       :database =>  'db/dev.sqlite3.db'
     )
end

# Handle potential connection pool timeout issues
after do
    ActiveRecord::Base.connection.close
end

###########################################################
# Models
###########################################################
# Models to Access the database through ActiveRecord.
# Define associations here if need be
# http://guides.rubyonrails.org/association_basics.html

class Link < ActiveRecord::Base
  # attr_accessor :count
end

###########################################################
# Routes
###########################################################

get '/' do
    @links = Link.all
    erb :index
end

get '/new' do
    erb :form
end

post '/new' do
    url = params[:url]
    short = SecureRandom.urlsafe_base64(4, false)
    prevEntry = Link.where(url: url).take(1)[0]
    if !prevEntry
      Link.create(:url=> url, :shortUrl=> short)
      short
    else
      prevEntry[:shortUrl]
    end
end

get '/:shortUrl' do
  if entry = Link.find_by_shortUrl(params[:shortUrl])
    entry.update_attribute(:count, entry[:count] + 1)
    redirect 'http://'+ entry[:url]
  else
    redirect to '/'
  end
end




# MORE ROUTES GO HERE