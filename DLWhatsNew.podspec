
Pod::Spec.new do |s|

  s.name         = "DLWhatsNew"
  s.version      = "0.1.1"
  s.summary      = "WhatsNew is a way for apps to display a detailed notification alert when new versions are launched."


# perhaps include sample project information and xcodeproj link here later.
  s.license      = { :type => 'MIT', :file =>'LICENSE' }
  s.author             = { "David Levy" => "davestrand242@gmail.com" }
  s.social_media_url   = "http://twitter.com/davestrand"
  s.platform     = :ios, '8.0'
  s.homepage = 'https://github.com/davestrand/'
  s.source       = { :git => "https://github.com/davestrand/WhatsNew.git", :tag => "0.1.1" }
  s.source_files  = "Source/*.{swift}"
  s.resource  = "Source/WhatsNew.storyboard"
  s.framework  = "UIKit"
  s.requires_arc = true


end
