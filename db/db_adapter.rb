#require 'sqlite3'
require 'pg'

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
    dbname = ENV['DATABASE_URL'] || name
    puts dbname
    @db = PG.connect(dbname: dbname)
  end

  def execute(sql)
    return @db.exec(sql).to_a
  end

  def close
    @db.close
  end
end
