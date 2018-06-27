.PHONY: build_release build run before_test after_test test xcodeproj codecov docker install uninstall clean
SC=swift

CONFIGDIR=~/.hazel
BINARYDIR=/usr/local/bin
RELEASEDIR=.build/release
DEBUGDIR=.build/debug
SWIFT_FLAGS=--configuration debug -Xswiftc "-D" -Xswiftc "DEBUG"

build:
	$(SC) build $(SWIFT_FLAGS)

build_release: SWIFT_FLAGS=--configuration release -Xswiftc -static-stdlib
build_release: build

run: build before_test
	ln -sf $(DEBUGDIR)/Hazel hazel_debug
	@echo ""
	@echo "Symbolic link created."
	@echo "Usage: \033[0;31m./hazel_debug\033[0;0m <\033[0;33mcommand\033[0;0m> <\033[0;33margument\033[0;0m>"
	@echo ""

debug: build before_test
	cp -i $(DEBUGDIR)/Hazel /usr/local/bin/hazel_debug
	cp -i .assets/scripts/completion/zsh/_hazel /usr/local/share/zsh/site-functions/_hazel_debug
	@echo ""
	@echo "Symbolic link created in /usr/local/bin."
	@echo "Usage: \033[0;31mhazel_debug\033[0;0m <\033[0;33mcommand\033[0;0m> <\033[0;33margument\033[0;0m>"
	@echo ""

before_test:
	@echo "\033[0;32mCreating folder /tmp/hazel\033[0;0m"
	@mkdir -p /tmp/hazel
	@echo "\033[0;32mCopying templates file to /tmp/hazel\033[0;0m"
	@cd .assets && cp -r templates /tmp/hazel
	@echo "\033[0;32mCopying other settings to /tmp/hazel\033[0;0m"
	@cd .assets && cp -f placeholders.json /tmp/hazel/

after_test:
	@echo "\033[0;32m"
	@echo "Deleting folder /tmp/hazel"
	@rm -rf /tmp/hazel
	@echo "\033[0;0m"

test: before_test
	@echo "\033[0;33m======================== RUNNING TESTS ========================\033[0;0m"
	$(SC) test $(SWIFT_FLAGS)
	@echo "\033[0;33m===============================================================\033[0;0m"
	@$(MAKE) after_test

xcodeproj:
	swift package generate-xcodeproj

codecov: before_test
	xcodebuild test -scheme Hazel-Package -enableCodeCoverage YES -configuration Debug "OTHER_SWIFT_FLAGS=-DDEBUG"
	@$(MAKE) after_test

docker:
	docker build --tag hazel .
	docker run --rm hazel

install: build_release
	mkdir -p $(CONFIGDIR)
	cd .assets && cp -r templates $(CONFIGDIR)
	cd .assets/scripts && cp -r completion $(CONFIGDIR)
	cp -f $(RELEASEDIR)/Hazel $(BINARYDIR)/hazel

uninstall:
	rm -r $(CONFIGDIR)
	rm $(BINARYDIR)/hazel

clean:
	rm -rf .build/
	rm -rf xcov_report
	rm -f hazel_debug
	rm -rf /tmp/hazel
	rm -f /usr/local/bin/hazel_debug
	rm -f /usr/local/share/zsh/site-functions/_hazel_debug

compress:
	cd ../ && tar czf hazel-1.0.3.tar.gz Hazel
	mv ../hazel-1.0.3.tar.gz .
	shasum -a 256 hazel-1.0.3.tar.gz
