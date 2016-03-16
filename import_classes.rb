require 'yaml'
require 'sqlite3'

db = SQLite3::Database.new 'fe.db'
paths = Dir['classes/*.yml']

db.execute "insert into classes (name, shortname) values (?, ?)", 'avatar_secondary', 'avatar_secondary'

paths.each do |file|
  params = YAML.load_file(file)
  shortname = File.basename(file, '.yml')
  puts shortname, params['name']
  db.execute "insert into classes (name, shortname) values (?, ?)", params['name'], shortname
  res = db.execute "select id from classes where shortname like ?", shortname
  class_id = res[0][0]

  params['skills'].each_with_index do |skill, index|
    res = db.execute "select id from skills where shortname like ?", skill
    if res.empty?
      db.execute "insert into skills (shortname) values (?)", skill
      res = db.execute "select id from skills where shortname like ?", skill
    end
    skill_id = res[0][0]

    level = (5*index)    
    level += 5 if params['promotions'].nil?

    db.execute "insert into classes_to_skills (level, class_id, skill_id) values (?,?,?)",
                 level, class_id, skill_id
  end

  params['weapons'].each_with_index do |weapon, index|
    res = db.execute "select id from weapons where shortname like ?", weapon
    if res.empty?
      db.execute "insert into weapons (shortname) values (?)", weapon
      res = db.execute "select id from weapons where shortname like ?", weapon
    end
    weapon_id = res[0][0]

    level = (5*index)    
    level += 5 if params['promotions'].nil?

    db.execute "insert into classes_to_weapons (class_id, weapon_id) values (?,?)",
                 class_id, weapon_id
  end
end

# 2nd pass for promotions
paths.each do |file|
  params = YAML.load_file(file)
  shortname = File.basename(file, '.yml')
  res = db.execute "select id from classes where shortname like ?", shortname
  class_id = res[0][0]
  next if params['promotions'].nil?
  params['promotions'].each do |promotion|
    res = db.execute "select id from classes where shortname like ?", promotion
    promotion_id = res[0][0]
    db.execute "insert into classes_to_promotions (class_id, promotion_id) values (?,?)",
                 class_id, promotion_id
  end
end
