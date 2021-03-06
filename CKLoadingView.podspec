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

  s.license      = "MIT"

  s.author       = { "Enix Yu" => "enix223@163.com" }
  s.platform     = :ios
  s.platform     = :ios, "7.0"
  s.requires_arc = true

  s.source       = { :git => "https://github.com/enix223/CKLoadingView.git", :tag => s.version.to_s }

  s.source_files  = "Source", "Source/**/*.{h,m}"
  s.exclude_files = "Source/Exclude"
end
