Pod::Spec.new do |s|
  s.name         = "TDFBatchOperation"
  s.version      = "0.0.1"
  s.summary      = "basic TDFBatchOperation"

  s.description  = <<-DESC
  批量操作集，方便对集合类型进行操作
                   DESC

  s.homepage     = "https://github.com/ny8080/TDFBatchOperation"

  s.license      = "LICENSE.md"
  s.author             = { "tripleCC" => "qingmu@2dfire.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "git@github.com:ny8080/TDFBatchOperation.git", tag: s.version }


  s.source_files = 'TDFBatchOperation/Classes/*'
  s.public_header_files = 'TDFBatchOperation/Classes/*.h'

  s.dependency 'TDFCoreProtocol'

end
