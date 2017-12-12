Pod::Spec.new do |s|
  s.name         = "JsenSegment"
  s.version      = "1.0.2"
  s.summary      = "A custom segment that can custom normal & selected text and image or backgroundColor.Support Swift4.0 and later"
  s.homepage     = "https://github.com/imwangxuesen/JsenSegment"
  s.license      = "MIT"
  s.author       = { "WangXuesen" => "imwangxuesen@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/imwangxuesen/JsenSegment.git", :tag => s.version.to_s }
  s.source_files = 'JsenSegment/*.{swift,bundle}'
  s.requires_arc = true
  s.resources    = "JsenSegment/JsenSegment.bundle"
  s.ios.deployment_target = '8.0'

end