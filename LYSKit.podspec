
Pod::Spec.new do |s|

  s.name         = "LYSKit"
  s.version      = "0.0.5"

  s.summary      = "A very useful base framework that integrates some of the common code blocks in development with apis."

  s.description  = <<-DESC
A very useful base framework that integrates some of the common code blocks in development with apis
A very useful base framework that integrates some of the common code blocks in development with apis
                   DESC

  s.platform     = :ios, "8.0"
  s.license      = "MIT"
  s.author       = { "LIYANGSHUAI" => "liyangshuai163@163.com" }

  s.homepage     = "https://github.com/LIYANGSHUAI/LYSKit"
  s.source       = { :git => "https://github.com/LIYANGSHUAI/LYSKit.git", :tag => s.version }

  s.source_files  = "LYSKit/*.{h,m}"

end
