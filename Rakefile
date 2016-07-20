require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "tests"
  t.test_files = FileList['tests/test*.rb']
  t.verbose = true
end

task :build do
  system "gem build jsonrehasher.gemspec"
end

# unpacks it all
task :unpack do
  system "find ./ -name '*.gem' -maxdepth 1 -exec rm {} +"
  system "[ -e ./temp ] && rm -R ./temp"
  system "[ ! -e ./temp ] && mkdir ./temp"
  Rake::Task["build"].invoke
  system "cp *.gem temp/"
  system "cd temp; gem unpack *.gem"
  system "cd temp; find ./"
end

# cleans up this project's directories
task :clean do
  system "find ./ -name '*.gem' -maxdepth 1 -exec rm {} +"
  system "[ -e ./temp ] && rm -R ./temp"
end
