require 'rubygems'
require 'rake/gempackagetask'

task :install => [:package] do
  sh %{sudo gem install pkg/#{NAME}-#{VERSION}}
end

task :release => :package do
  sh %{rubyforge add_release merb-plugins merb_has_flash #{VERSION} pkg/#{NAME}-#{VERSION}.gem}
end
