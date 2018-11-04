Pod::s.new do |s|
  s.name         = "RealmSwiftService"
  s.version      = "0.0.1"
  s.summary      = "RealmSwiftService Supports Realm standard CRUD functions"
  s.description  = <<-DESC
                        RealmService Supports Realm standard CRUD functions.
                        You can do actions(find, save, delete) to Realm Object.
                        DESC
  s.homepage     = "https://github.com/yokurin/RealmSwiftService"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Tsubasa Hayashi" => "yoku.rin.99@gmail.com" }
  s.social_media_url   = "https://twitter.com/_yokurin"
  s.platform      = :ios
  s.source        = { :git => "http://github.com/yokurin/RealmSwiftService.git", :tag => "#{s.version}" }
  s.source_files  = "RealmSwiftService", "RealmSwiftService/**/*.{h,swift}"
  # s.exclude_files = "RealmSwiftService/Exclude"
  s.dependency "RealmSwift", "~> 3.11"
  # s.ios.deployment_target = '8.0'
  # s.osx.deployment_target = '10.10'
end
