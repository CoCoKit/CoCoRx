Pod::Spec.new do |s|
  s.name = "CoCoRx"
  s.version = "1.0.0"
  s.summary = "CoCoRx 是基于RAC框架开发的工具模块!"
  s.license = "MIT"
  s.authors = {"iScarlett"=>"iScarlett@qq.com"}
  s.homepage = "https://github.com/CoCoKit"
  s.description = "CoCoRx 基于RAC框架,进行iOS中常用业务的封装,使其能使各个业务模块方便得进入信号流模式."
  s.requires_arc = true
  s.source = {"git"=>"https://github.com/CoCoKit/CoCoRx.git", "branch"=>"v1.0.0"}
  s.source_files = "CoCoRx/**/*.{h,m,mm,cpp}"
  s.platform    = :ios, "9.0"
  s.framework = 'AVFoundation','Photos','CoreLocation'
  s.resource_bundle = { 'CoCoRx' => ['Resources/*'] }
  s.dependency 'ReactiveObjC'
end
