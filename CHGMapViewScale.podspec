Pod::Spec.new do |s|
  s.name             = "CHGMapViewScale"
  s.version          = "0.1.0"
  s.summary          = "Add a graphical scale to a GMSMapView."
  s.description      = <<-DESC
Add a graphical scale directly on top of a GMSMapView.
                       DESC

  s.homepage         = "https://github.com/grethi/CHGMapViewScale"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Christian" => "greth.christian@googlemail.com" }
  s.source           = { :git => "https://github.com/grethi/CHGMapViewScale.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.frameworks = 'UIKit', 'MapKit', 'GoogleMaps'
  s.dependency 'BlocksKit'
  s.dependency 'GoogleMaps'
end
