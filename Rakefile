require "rake/testtask"

Bundler::GemHelper.install_tasks name: ENV.fetch("GEM_NAME", "break")

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task default: :test
