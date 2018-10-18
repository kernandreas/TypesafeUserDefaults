Pod::Spec.new do |spec|
  spec.name           = "TypesafeUserDefaults"
  spec.version        = "0.0.1"
  spec.summary        = "A type safe extension to UserDefaults"
  spec.description    = "TypesafeUserDefaults is a thin extension to UserDefaults that enables a type safe use. As a bonus, types that conform to Codable can be stored in the UserDefaults."
  spec.license        = { :type => "MIT", :file => "LICENSE" }
  spec.author         = { "Andreas Kern" => "code@andreaskern.de" }
  spec.homepage       = "https://github.com/kernandreas/TypesafeUserDefaults"
  spec.source         = { :git => "https://github.com/kernandreas/TypesafeUserDefaults.git", :tag => "#{spec.version}" }
  spec.source_files   = "Sources/TypesafeUserDefaults/"
  spec.swift_version  = '4.1'
  spec.ios.deployment_target  = '8.0'
  spec.osx.deployment_target  = '10.9'
end
