require 'sinatra'
require 'sqlite3'
#require 'jbuilder'
require 'json'

class FEService < Sinatra::Base

  get '/' do
    "Hello World"
  end
  
  get '/characters/all' do 
    content_type :json
    db = SQLite3::Database.open './db/fe.db'
    res = db.execute 'select shortname from characters'
    res = res.flatten
    res.to_json
  end

  get '/characters/:name' do
    content_type :json
    db = SQLite3::Database.open './db/fe.db'
    db.results_as_hash = true
    res = db.execute 'select * from characters where shortname like ?', params['name']
    res.to_json
  end

end
