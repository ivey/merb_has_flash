require 'rubygems'
require 'rake/gempackagetask'
 
spec = eval(File.read('merb_has_flash.gemspec'))
Rake::GemPackageTask.new(spec) { |pkg| pkg.gem_spec = spec }

# Checks to see if Windows platform or if "SUDOLESS" environment variable is set
sudo = ((RUBY_PLATFORM =~ /win32|mingw|bccwin|cygwin/) rescue nil) ? '' : ('sudo' unless ENV['SUDOLESS'])

task :install => [:package] do
  sh %{#{sudo} gem install pkg/#{spec.name}-#{spec.version}}
end

task :release => :package do
  sh %{rubyforge add_release merb-plugins #{spec.name} #{spec.version} pkg/#{spec.name}-#{spec.version}.gem}
end
