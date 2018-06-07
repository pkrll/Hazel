SC=swift

CONFIGDIR=~/.hazel
BINARYDIR=/usr/local/bin
RELEASEDIR=.build/release
DEBUGDIR=.build/debug

build:
	$(SC) build --configuration debug -Xswiftc "-D" -Xswiftc "DEBUG"

test:
	$(SC) test --configuration debug -Xswiftc "-D" -Xswiftc "DEBUG"

install:
	$(SC) build --configuration release -Xswiftc -static-stdlib
	mkdir -p $(CONFIGDIR)
	cp -r templates $(CONFIGDIR)
	cp -f $(RELEASEDIR)/Hazel $(BINARYDIR)/hazel

clean:
	rm -rf bin/*
	rm -rf .build/
