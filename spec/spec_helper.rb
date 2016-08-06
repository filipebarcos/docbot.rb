FIXTURES = Dir[File.join(File.dirname(__FILE__), "fixtures/*.md")].reduce({}) do |fixtures, file|
  basename = File.basename(file, ".md")
  fixtures[basename.to_sym] = File.read(file).to_s
  fixtures
end
