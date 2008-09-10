Gem::Specification.new do |s|
  s.name = "merb_has_flash"
  s.version = "0.9.2"
  s.date = "2008-09-10"
  s.summary = "Rails' 'flash' session notification system ported to Merb"
  s.email = "jnicoll@gnexp.com"
  s.homepage = "http://github.com/eltiare/merb_has_flash"
  s.description = s.summary
  s.has_rdoc = false
  s.authors = ["Michael D. Ivey", "Jeremy Nicoll"]
  s.files = ["LICENSE", "Rakefile", "README", "TODO", "lib/merb_has_flash.rb",
    "lib/merb_has_flash/controller_extension.rb",
    "lib/merb_has_flash/flash_hash.rb",
    "lib/merb_has_flash/helper.rb",
    "spec/merb_has_flash/controller_extension_spec.rb",
    "spec/merb_has_flash/flash_hash_spec.rb",
    "spec/spec_helper.rb"]
  s.test_files = [  "spec/merb_has_flash/controller_extension_spec.rb",
    "spec/merb_has_flash/flash_hash_spec.rb",
    "spec/spec_helper.rb"]
  s.add_dependency("merb-core", ["> 0.9.0"])
end
