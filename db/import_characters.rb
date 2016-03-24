require 'yaml'
require './db_adapter'

db = PGAdapter.new
db.connect('fedb')
paths = Dir['characters/*.yml']

paths.each do |file|
  params = YAML.load_file(file)
  shortname = File.basename(file, '.yml')
  db.execute("insert into characters (name, shortname, base_class, heart_class, alt_heart_class, prepromote) values ('#{params['name']}','#{shortname}','#{params['base_class']}','#{params['heart_class']}','#{params['alt_heart_class']}','#{params['prepromote']}')")

  skill = params['skill']
  res = db.execute("select shortname from skills where shortname like '#{skill}'")
  if res.empty?
    db.execute("insert into skills (shortname) values ('#{skill}')")
  end

  db.execute("insert into characters_to_skills (character, skill) values ('#{shortname}', '#{skill}')")

end


def sets(type, shortname, params, db)
  if not params[type].nil? then
    params[type].each do |friend, friendclass|
      puts friend
      puts friendclass
      db.execute("insert into #{type} (character, support_character, class) values ('#{shortname}','#{friend}','#{friendclass}')")
    end
  end
end


# 2nd pass for supports
paths.each do |file|
  params = YAML.load_file(file)
  shortname = File.basename(file, '.yml')

  sets('friendship_sets', shortname, params, db)
  sets('partner_sets', shortname, params, db)

end


