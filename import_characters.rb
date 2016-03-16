require 'yaml'
require 'sqlite3'

db = SQLite3::Database.new 'fe.db'
paths = Dir['characters/*.yml']

def get_class_id(shortname, db)
  puts shortname
  return nil if shortname.nil?
  res = db.execute "select id from classes where shortname like ?", shortname
  return res[0][0]
end

paths.each do |file|
  params = YAML.load_file(file)
  shortname = File.basename(file, '.yml')
  base_class_id = get_class_id(params['base_class'], db)
  heart_class_id = get_class_id(params['heart_class'], db)
  alt_heart_class_id = get_class_id(params['alt_heart_class'], db)
  prepromote_id = get_class_id(params['prepromote_class'], db)
  db.execute "insert into characters (name, shortname, base_class_id, heart_class_id, alt_heart_class_id, prepromote_id) values (?,?,?,?,?,?)",
    params['name'], shortname, base_class_id, heart_class_id, alt_heart_class_id, prepromote_id

  res = db.execute "select id from characters where shortname like ?", shortname
  char_id = res[0][0]

  skill = params['skill']
  res = db.execute "select id from skills where shortname like ?", skill
  if res.empty?
    db.execute "insert into skills (shortname) values (?)", skill
    res = db.execute "select id from skills where shortname like ?", skill
  end
  skill_id = res[0][0]

  db.execute "insert into characters_to_skills (character_id, skill_id) values (?, ?)",
               char_id, skill_id

end


def sets(type, char_id, params, db)
  if not params[type].nil? then
    params[type].each do |friend, friendclass|
      puts friend
      puts friendclass
      res = db.execute "select id from characters where shortname like ?", friend
      friend_id = res[0][0]

      res = db.execute "select id from classes where shortname like ?", friendclass
      if res.nil? || res[0].nil? then
        friendclass_id = nil
      else
        friendclass_id = res[0][0]
      end
      
      db.execute "insert into #{type} (character_id, support_character_id, class_id) values (?,?,?)",
                   char_id, friend_id, friendclass_id
    end
  end
end


# 2nd pass for supports
paths.each do |file|
  params = YAML.load_file(file)
  shortname = File.basename(file, '.yml')
  res = db.execute "select id from characters where shortname like ?", shortname
  char_id = res[0][0]

  sets('friendship_sets', char_id, params, db)
  sets('partner_sets', char_id, params, db)

end


