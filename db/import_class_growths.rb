require './db_adapter'


db = PGAdapter.new
db.connect('fedb')


File.open('class_growths').each do |line|
data = line.split(',')
db.execute("update classes set hp=#{data[1]}, str=#{data[2]}, mag=#{data[3]}, skl=#{data[4]}, spd=#{data[5]}, lck=#{data[6]}, def=#{data[7]}, res=#{data[8]} where shortname='#{data[0]}'")
end
