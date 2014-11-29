Gem::Specification.new do |s|
  s.name              = "net-driller"
  s.version           = '1.0.0'
  s.summary           = "Drill is a vRack builder for boxes with single ifaces (like OVH)."
  s.homepage          = "https://github.com/diegok/net-driller"
  s.email             = ["diego@freekeylabs.com", "ivan@sysdivision.com"]
  s.authors           = ["Diego Kuperman", "Ivan Belmonte"]

  s.files         = `git ls-files`.split($/).reject{ |f| f =~ /^examples/ }
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
  s.required_ruby_version     = '>= 1.9.3'

  s.rdoc_options      = ["--charset=UTF-8"]

  s.add_dependency "thor",            "~> 0.17"
  s.add_dependency "yaml"
  s.add_dependency "net-ssh"

  s.description = %s{
    Drill is a system to manage a tunnel based virtual rack for several boxes
    without private interfaces (kinda OVH)}
end
