require './db/db_adapter.rb'
require 'sinatra'
require 'json'
require 'byebug'


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
    char_data = db.execute("select * from characters where shortname = '#{params['name']}'")
    friendships = db.execute("select support_character, class from friendship_sets where character = '#{params['name']}'")
    partners = db.execute("select support_character, class from partner_sets where character = '#{params['name']}'")
    res = char_data.first
    res['friendship_sets'] = friendships
    res['partner_sets'] = partners
    db.close
    res.to_json
  end

end
