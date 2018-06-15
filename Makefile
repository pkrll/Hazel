.PHONY: build test before_test install clean
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
	mkdir -p /tmp/hazel
	cd .assets && cp -r templates /tmp/hazel

test: before_test
	$(SC) test --configuration debug -Xswiftc "-D" -Xswiftc "DEBUG"
	rm -rf /tmp/hazel

codecov: before_test
	xcodebuild test -scheme Hazel-Package -enableCodeCoverage YES -configuration Debug "OTHER_SWIFT_FLAGS=-DDEBUG"
	rm -rf /tmp/hazel

docker:
	docker build --tag hazel .
	docker run --rm hazel

install:
	$(SC) build --configuration release -Xswiftc -static-stdlib
	mkdir -p $(CONFIGDIR)
	cd .assets && cp -r templates $(CONFIGDIR)
	cd .assets && cp -r scripts/completion $(CONFIGDIR)/scripts
	cp -f $(RELEASEDIR)/Hazel $(BINARYDIR)/hazel
	which hazel > /dev/null && . "$( hazel initpath )"

uninstall:
	rm -r $(CONFIGDIR)
	rm $(BINARYDIR)/hazel

completion:
	which hazel > /dev/null && . "$( hazel initpath )"

clean:
	rm -rf .build/
	rm -rf xcov_report
	rm -f hazel_debug
