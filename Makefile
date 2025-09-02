config:
	@fvm install
	@fvm use

clean:
	@- find . -type f \( -name "*.g.dart" -o -name "*.freezed.dart" \) -exec rm {} +
	@fvm flutter clean

get:
	@fvm flutter pub get
	@fvm dart run build_runner build

build:
	@fvm dart run build_runner build

watch:
	@fvm dart run build_runner watch

run:
	@fvm flutter run


clean-run: clean get run


help:
	@echo "======================================================================================================="
	@echo "make config - Configures the project and installs the Flutter SDK version on FVM"
	@echo "make clean - Cleans the Flutter project"
	@echo "make get - Gets all the packages and generates all generative files"
	@echo "make build - Generates all .g and .freezed files"
	@echo "make watch - Starts build_runner in the terminal to generate needed files while developing"
	@echo "make help - Run this command to display all the available commands"
	@echo "======================================================================================================="
