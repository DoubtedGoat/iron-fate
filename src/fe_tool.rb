require 'sinatra'
require 'json'


class FEService < Sinatra::Base
  get '/' do
    "Hello World"
  end
  
  get '/characters/all' do 
    content_type :json
    db = PGAdapter.new
    db.connect('fedb')
    res = db.execute('select shortname from characters')
    res = res.flatten
    res.to_json
    db.close
  end

  get '/characters/:name' do
    db = PGAdapter.new
    db.connect('fedb')
    content_type :json
    res = db.execute("select * from characters where shortname like '#{params['name']}'")
    res.to_json
    db.close
  end

end
