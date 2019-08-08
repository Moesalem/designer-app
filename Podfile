# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'


def shared_pods 
pod 'Firebase/Analytics'
pod 'Firebase/Auth'
pod 'Firebase/Core'
pod 'Firebase/Firestore'
pod 'Kingfisher', '~> 5.0'
pod 'IQKeyboardManagerSwift'


end
target 'DesignerApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DesignerApp
shared_pods

end

target 'DesignerAppAdmin' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DesignerAppAdmin
pod 'Firebase/Storage'
shared_pods
end
