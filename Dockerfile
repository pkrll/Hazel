FROM swift:latest

WORKDIR /tmp

COPY . ./

RUN mkdir -p /tmp/hazel
RUN cd .assets && cp -r templates /tmp/hazel
RUN swift package resolve
RUN swift package clean
CMD swift test --configuration debug -Xswiftc "-D" -Xswiftc "DEBUG"
