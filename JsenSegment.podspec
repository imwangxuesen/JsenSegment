Pod::Spec.new do |s|
  s.name         = "JsenSegment"
  s.version      = "1.0"
  s.summary      = "A custom segment that can custom normal & selected text and image or backgroundColor.Support Swift4.0 and later"
  s.homepage     = "https://github.com/xeroxmx/CBWAlertView"
  s.license      = "MIT"
  s.author       = { "Jsen" => "imwangxuesen@icloud.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/imwangxuesen/JsenSegment.git", :tag => "1.0" }
  s.source_files  = 'CBWAlertView/**/*.{h,m}'
  s.requires_arc = true

end