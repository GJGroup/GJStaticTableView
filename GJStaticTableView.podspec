Pod::Spec.new do |s|
  s.name         = 'GJStaticTableView'
  s.summary      = 'A static TableView, like TableView in StoryBoard'
  s.version      = '0.0.1'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'wangyutao' => 'wangyutao0424@163.com' }
  s.homepage     = 'https://github.com/GJGroup/GJStaticTableView'

  s.ios.deployment_target = '7.0'

  s.source       = { :git => 'https://github.com/GJGroup/GJStaticTableView.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'GJStaticTableView/*.{h,m}'
  s.public_header_files = 'GJStaticTableView/*.{h}'
  
  s.frameworks = 'UIKit'
  s.dependency   "UITableView+FDTemplateLayoutCell"

end
