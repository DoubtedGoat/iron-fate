require 'yaml'
require './db_adapter'


db = PGAdapter.new
db.connect('fedb')
paths = Dir['classes/*.yml']

db.execute("insert into classes (name, shortname) values ('avatar_secondary', 'avatar_secondary')")

paths.each do |file|
  params = YAML.load_file(file)
  shortname = File.basename(file, '.yml')
  puts shortname, params['name']
  db.execute("insert into classes (name, shortname) values ('#{params['name']}', '#{shortname}')")

  params['skills'].each_with_index do |skill, index|
    res = db.execute("select shortname from skills where shortname like '#{skill}'")
    if res.empty?
      db.execute("insert into skills (shortname) values ('#{skill}')")
    end

    level = (5*index)    
    level += 5 if params['promotions'].nil?

    db.execute("insert into classes_to_skills (level, class, skill) values ('#{level}','#{shortname}','#{skill}')")
  end

  params['weapons'].each_with_index do |weapon, index|
    res = db.execute("select shortname from weapons where shortname like '#{weapon}'")
    if res.empty?
      db.execute("insert into weapons (shortname) values ('#{weapon}')")
    end

    db.execute("insert into classes_to_weapons (class, weapon) values ('#{shortname}','#{weapon}')")
  end
end

# 2nd pass for promotions
paths.each do |file|
  params = YAML.load_file(file)
  shortname = File.basename(file, '.yml')
  next if params['promotions'].nil?
  params['promotions'].each do |promotion|
    db.execute("insert into classes_to_promotions (class, promotion) values ('#{shortname}','#{promotion}')")
  end
end
