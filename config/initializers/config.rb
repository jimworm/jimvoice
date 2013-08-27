CONFIG = HashWithIndifferentAccess.new (if File.exists?(filename = "#{Rails.root.to_s}/config/config.yml")
  YAML.load_file(filename)[Rails.env]
elsif ENV['CONFIG']
  YAML.load(ENV['CONFIG'])[Rails.env]
else
  fail 'Config missing, check that config/config.yml exists or CONFIG environment variable is set.'
end)
