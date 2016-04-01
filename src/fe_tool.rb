require './db/db_adapter.rb'
require 'sinatra'
require 'json'


class FEService < Sinatra::Base
  set :root, './'
  get '/' do
    File.read(File.join('public', 'index.html'))
  end
  
  get '/characters/all' do 
    content_type :json
    db = PGAdapter.new
    db.connect('fedb')
    res = db.execute('select shortname from characters')
    res = res.collect { |el| el['shortname'] }
    db.close
    res.to_json
  end

  get '/characters/:name' do
    db = PGAdapter.new
    db.connect('fedb')
    content_type :json
    res = db.execute("select * from characters where shortname like '#{params['name']}'")
    db.close
    res.to_json

  end

end
