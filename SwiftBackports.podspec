Pod::Spec.new do |spec|
  spec.name         = "SwiftBackports"
  spec.version      = "1.0.3"
  spec.summary      = "Introducing a collection of SwiftUI backports to make your iOS development easier."
  spec.description  = <<-DESC
  Backports attempts to bring features back to the earliest possible versions of iOS to enable greater support for modern API.
                   DESC
  spec.homepage     = "https://github.com/shaps80/SwiftBackports"
  spec.license      = "MIT"
  spec.author             = { "Shaps (Mohsenin) Benkau" => "shapsuk@me.com" }
  spec.ios.deployment_target = "11.0"
  spec.osx.deployment_target = "10.15"
  spec.tvos.deployment_target = "11"
  spec.source       = { :git => "https://github.com/shaps80/SwiftBackports.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/SwiftBackports/**/*.swift"
  spec.frameworks = "Foundation", "Combine", "SwiftUI", "AppIntents"
  spec.swift_version = "5.0"
end
