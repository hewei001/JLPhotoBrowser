
Pod::Spec.new do |s|


  s.name         = "JLPhotoBrowser"
  s.version      = "1.0.0"
  s.summary      = "An easy way to use see imageview."
  s.description  = <<-DESC
                   DESC
  s.homepage     = "https://github.com/hewei001/JLPhotoBrowser"
  s.license      = "MIT"
  s.author             = { "wang" => "729901489@qq.com" }
  s.source       = { :git => "https://github.com/hewei001/JLPhotoBrowser.git", :tag => "s.version }

  s.source_files  = "JLPhotoBrowser/class.{h,m}"
  s.exclude_files = "Classes/Exclude"
end
