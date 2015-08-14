
Pod::Spec.new do |s|

  s.name         = "DLWhatsNew"
  s.version      = "0.1.0"
  s.summary      = "The What's New version notification system is a simple way for apps to add brief notification alerts when a new version of their app is installed."


# perhaps include sample project information and xcodeproj link here later.
  s.license      = "MIT"
  s.author             = { "David Levy" => "davestrand242@gmail.com" }
  s.social_media_url   = "http://twitter.com/davestrand"
  s.platform     = :ios, “8.0”

  s.source       = { :git => "https://github.com/davestrand/WhatsNew.git", :tag => "0.1.0" }
  s.source_files  = "Source/*.{swift}"
  s.resource  = "Source/WhatsNew.storyboard"
  s.framework  = "UIKit"
  s.requires_arc = true


end
