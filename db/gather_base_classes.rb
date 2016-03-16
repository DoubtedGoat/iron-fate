require 'yaml'

paths = Dir['characters/*.yml']

paths.each do |file|
  params = YAML.load_file(file)
  shortname = File.basename(file, '.yml')
  case shortname
    when 'avatar_male', 'avatar_female'
    when 'azura', 'mozu', 'kaden', 'keaton', 'selkie', 'velouria'
      puts "#{shortname}: #{params['heart_class']},"
    else
      puts "#{shortname}: #{params['base_class']},"
  end
end
