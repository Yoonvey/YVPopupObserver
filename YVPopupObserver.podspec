Pod::Spec.new do |s|
    s.name         = "YVPopupObserver"
    s.version      = "1.0.4"
    s.ios.deployment_target = '8.0'
    s.summary      = "A practical setting interface framework."
    s.homepage     = "https://github.com/Yoonvey/YVPopupObserver"
    s.license              = { :type => "MIT", :file => "LICENSE" }
    s.author             = { "Yoonvey" => "3084882664@qq.com" }
    s.source       = { :git => "https://github.com/Yoonvey/YVPopupObserver.git", :tag => s.version }
    s.source_files  = "YVPopupObserver/YVPopupObserver/*.{h,m}"
    s.requires_arc = true
end