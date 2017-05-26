Pod::Spec.new do |s|
  s.name             = "CHGMapViewScale"
  s.version          = "1.0.2"
  s.summary          = "Add a graphical scale to a GMSMapView."
  s.description      = <<-DESC
Add a graphical scale directly to a GMSMapView.
                       DESC

  s.homepage         = "https://github.com/grethi/CHGMapViewScale"
  s.license          = 'MIT'
  s.author           = { "Christian Greth" => "greth.christian@googlemail.com" }
  s.source           = { :git => "https://github.com/grethi/CHGMapViewScale.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.frameworks = 'UIKit', 'GoogleMaps'
  s.dependency 'BlocksKit'
  s.dependency 'GoogleMaps', '<2.0.0'
end
