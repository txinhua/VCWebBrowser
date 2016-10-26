Pod::Spec.new do |s|

s.name         = "VCWebBrowser"
s.version      = "1.0"
s.summary      = "UIWebView | WKWebView used with progressBar"

s.description  = <<-DESC
1. Show Url simply.
2. Loading progress view.
DESC

s.homepage     = "https://github.com/txinhua/VCWebBrowser"

s.license      = { :type => "Apache License", :file => "LICENSE" }


s.author             = { "gftang" => "gftang@vcainfo.com" }

s.platform     = :ios, "7.0"

s.requires_arc = true

s.source       = { :git => "https://github.com/txinhua/VCWebBrowser.git", :tag => s.version }

s.source_files  = "VCWebBrowser/VCWebB/*.{h,m}"

s.frameworks = "UIKit"

s.dependency 'NJKWebViewProgress', '~> 0.2.3'

end
