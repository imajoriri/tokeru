.PHONY: build_macos

# macOS用のビルドを行うターゲット
build_macos:
	flutter build macos --dart-define-from-file=dart_defines/prod.json

open_macos: open build/macos/Build/Products/Release/Quick.app/

gen_code: flutter pub run build_runner build --delete-conflicting-outputs