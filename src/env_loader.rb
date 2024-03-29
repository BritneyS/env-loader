module EnvLoader
  def self.load_key(key, path = '.env')
    return ENV[key] if loaded?(key)

    EnvLoader.load(path)
    ENV[key]
  end

  private

  def self.loaded?(key)
    ENV.key?(key)
  end

  def self.load(env_file_path)
    dotenv_path = File.expand_path(env_file_path)

    if File.exist?(dotenv_path)
      File.readlines(dotenv_path).each do |line|
        key, value = line.strip.split('=', 2)
        ENV[key] = value if key && value
      end
    else
      raise "Warning: No env file found"
    end
  end
end