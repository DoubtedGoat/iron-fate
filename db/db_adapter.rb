require 'pg'
require 'uri'

class SQLiteAdapter
  def connect(name)
    @db = SQLite3::Database.open name
  end
  
  def execute(sql)
    @db.results_as_hash = true
    # Clean Hash
    return @db.execute(sql)
  end

  def close
    @db.close
  end
end


class PGAdapter
  def connect(name)
    if ENV['DATABASE_URL'] then
      uri = URI(ENV['DATABASE_URL'])
      @db = PG.connect(host: uri.host,
                       dbname: uri.path[1..-1],
                       user: uri.user,
                       password: uri.password)
                       
    else
      dbname = name
      puts dbname
      @db = PG.connect(dbname: dbname)
    end
  end

  def execute(sql)
    return @db.exec(sql).to_a
  end

  def close
    @db.close
  end
end
