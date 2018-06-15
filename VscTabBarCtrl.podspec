Pod::Spec.new do |spec|
  spec.name             = 'VscTabBarCtrl'
  spec.ios.deployment_target = '8.0'
  spec.version          = '1.0.3'
  spec.summary          = '可以自定义Tabbar样式'
  spec.description      = <<-DESC
                       利用hittest实现了超出边距的可点击效果,同时又增加了选中非选中状态的文字颜色的更改
各家具体的内容可以参考Demo
                       DESC
  spec.homepage         = 'https://github.com/vcsatanial/VscTabBarCtrl'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'VincentSatanial' => '116359398@qq.com' }
  spec.source           = { :git => 'https://github.com/vcsatanial/VscTabBarCtrl.git', :tag => spec.version }
  
  spec.source_files = 'VscTabBarCtrl/*.{h,m}'
  spec.requires_arc = true
end
