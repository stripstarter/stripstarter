SS_CONFIG = if File.exists?("./config/site_production.yml")
    ConfigReader::EnvConfigReader.new("site_production.yml")
  else
    ConfigReader::EnvConfigReader.new("site.yml")
  end