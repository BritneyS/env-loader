require 'minitest/autorun'

require_relative '../src/env_loader'

class EnvLoaderTest < Minitest::Test
  def test_env_vars_are_loaded_from_default_env_path_at_app_root
    # This test will pass if .env file is in the root of the project,
    # with at least the named test key.
    assert(EnvLoader.load_key 'TEST_KEY')
  end

  def test_env_vars_are_loaded_from_custom_env_path
    test_env_path = 'test/.env'
    File.delete(test_env_path) if File.exist?(test_env_path)

    # Create a file
    File.open(test_env_path, 'w') do |file|
      # Write a line to the file
      file.puts 'TEST_KEY=2'
    end

    # Assert that the file exists
    assert(File.exist?(File.expand_path(test_env_path)), "File '.env' doesn't exist in 'test' directory.")

    assert(EnvLoader.load_key('TEST_KEY', test_env_path))
    # Delete the file
    File.delete(test_env_path)
  end
end
