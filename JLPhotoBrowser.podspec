#
#  Be sure to run `pod spec lint JLPhotoBrowser.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = 'JLPhotoBrowser'
  s.version      = '1.0.0'
  s.summary      = 'JLPhotoBrowser'
  s.frameworks = "Foundation", "UIKit","UIKit/UIKit.h"
  s.description  = <<-DESC
一个简单的图片浏览JLPhotoBrowser
                   DESC

s.homepage     = 'https://github.com/hewei001/JLPhotoBrowser'

  s.license      = 'MIT'

  s.author             = { "wang" => "729901489@qq.com" }
  s.source       = { :git => 'https://github.com/hewei001/JLPhotoBrowser.git', :tag => "#{s.version}" }
  s.source_files  ="JLPhotoBrowser" "JLPhotoBrowser/down/*.{h,m}"
  s.requires_arc = true

end
