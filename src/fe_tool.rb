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
    res = db.execute('select shortname, name from characters')
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

  get '/classes/:name' do
    db = PGAdapter.new
    db.connect('fedb')
    content_type :json
    class_data = db.execute("select * from classes where shortname = '#{params['name']}'")
    res = class_data.first
    weapons = db.execute("select weapons.shortname, weapons.name from classes join classes_to_weapons as c2w on classes.shortname=c2w.class join weapons on c2w.weapon=weapons.shortname where classes.shortname='#{params['name']}'")
    res['weapons'] = weapons

    skills = db.execute("select skills.shortname, skills.name from classes join classes_to_skills as c2s on classes.shortname=c2s.class join skills on c2s.skill=skills.shortname where classes.shortname='#{params['name']}'")
    res['skills'] = skills

    db.close
    res.to_json
  end

end
