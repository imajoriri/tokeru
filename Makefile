.PHONY: build_macos

# macOS用のビルドを行うターゲット
build_macos:
	flutter build macos --dart-define-from-file=dart_defines/prod.json \
    && git co macos/Runner.xcodeproj/project.pbxproj \
	&& git co macos/Runner.xcodeproj/xcshareddata/xcschemes/Production.xcscheme \
	&& git co macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme

open_macos: open build/macos/Build/Products/Release/Quick.app/

gen_code: flutter pub run build_runner build --delete-conflicting-outputs
