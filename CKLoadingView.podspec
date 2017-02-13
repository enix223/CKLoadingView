Pod::Spec.new do |s|
  s.name         = "CKLoadingView"
  s.version      = "0.0.1"
  s.summary      = "Fully customized animatable iOS Loading view"
  s.description  = <<-DESC 
  CKLoadingView is an easy to use, fully customized animatable iOS Loading view.
  With CKLoadingView, you can create different kinds of loading animation. For more detail, please refer
  to https://github.com/enix223/CKLoadingView
                   DESC

  s.homepage     = "https://github.com/enix223/CKLoadingView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"

  s.author       = { "Enix Yu" => "enix223@163.com" }
  s.platform     = :ios
  s.platform     = :ios, "5.0"

  s.source       = { :git => "https://github.com/enix223/CKLoadingView.git", :commit => "a1c18bbf72809023d6a229d4d59326a6617c636e" }

  s.source_files  = "Source", "Source/**/*.{h,m}"
  s.exclude_files = "Source/Exclude"
end
