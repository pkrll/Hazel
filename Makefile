.PHONY: build test before_test install clean
SC=swift

CONFIGDIR=~/.hazel
BINARYDIR=/usr/local/bin
RELEASEDIR=.build/release
DEBUGDIR=.build/debug

build:
	$(SC) build --configuration debug -Xswiftc "-D" -Xswiftc "DEBUG"

before_test:
	mkdir -p /tmp/hazel
	cd .assets && cp -r templates /tmp/hazel

test: before_test
	$(SC) test --configuration debug -Xswiftc "-D" -Xswiftc "DEBUG"

codecov: before_test
	xcodebuild test -scheme Hazel-Package -enableCodeCoverage YES -configuration debug

install:
	$(SC) build --configuration release -Xswiftc -static-stdlib
	mkdir -p $(CONFIGDIR)
	cd .assets && cp -r templates $(CONFIGDIR)
	cp -f $(RELEASEDIR)/Hazel $(BINARYDIR)/hazel

clean:
	rm -rf bin/*
	rm -rf .build/
