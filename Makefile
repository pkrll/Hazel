.PHONY: build test before_test install clean completion
SC=swift

CONFIGDIR=~/.hazel
BINARYDIR=/usr/local/bin
RELEASEDIR=.build/release
DEBUGDIR=.build/debug

build:
	$(SC) build --configuration debug -Xswiftc "-D" -Xswiftc "DEBUG"

run: build
	ln -sf .build/x86_64-apple-macosx10.10/debug/Hazel hazel_debug
	@echo "Symlink created. To run Hazel:"
	@echo "hazel_debug <command> <argument>"

before_test:
	@echo "\033[0;32mCreating folder /tmp/hazel"
	mkdir -p /tmp/hazel
	@echo "Copying templates file to /tmp/hazel"
	cd .assets && cp -r templates /tmp/hazel
	@echo "\033[0;0m"

test: before_test
	$(SC) test --configuration debug -Xswiftc "-D" -Xswiftc "DEBUG"
	rm -rf /tmp/hazel

codecov: before_test
	xcodebuild test -scheme Hazel-Package -enableCodeCoverage YES -configuration Debug "OTHER_SWIFT_FLAGS=-DDEBUG"
	rm -rf /tmp/hazel

docker:
	docker build --tag hazel .
	docker run --rm hazel

install: build_release
	mkdir -p $(CONFIGDIR)
	cd .assets && cp -r templates $(CONFIGDIR)
	cd .assets/scripts && cp -r completion $(CONFIGDIR)
	cp -f $(RELEASEDIR)/Hazel $(BINARYDIR)/hazel

build_release:
	$(SC) build --configuration release -Xswiftc -static-stdlib

uninstall:
	rm -r $(CONFIGDIR)
	rm $(BINARYDIR)/hazel

clean:
	rm -rf .build/
	rm -rf xcov_report
	rm -f hazel_debug
