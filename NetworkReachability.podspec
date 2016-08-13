Pod::Spec.new do |spec|
  spec.name = 'NetworkReachability'
  spec.version = '0.2.0'
  spec.summary = 'Swift network reachability'
  spec.description = <<-DESCRIPTION.gsub(/\s+/, ' ').chomp
  NetworkReachability framework provides Swift wrappers for the network
  reachability API found in Apple's System Configuration framework.
  DESCRIPTION
  spec.homepage = 'https://github.com/royratcliffe/NetworkReachability'
  spec.license = { type: 'MIT', file: 'MIT-LICENSE.txt' }
  spec.author = { 'Roy Ratcliffe' => 'roy@pioneeringsoftware.co.uk' }
  spec.source = {
    git: 'https://github.com/royratcliffe/NetworkReachability.git',
    tag: spec.version.to_s }
  spec.source_files = 'Sources/**/*.{swift,h}'
  spec.platform = :ios, '9.0'
  spec.requires_arc = true
  spec.framework = 'SystemConfiguration'
end
