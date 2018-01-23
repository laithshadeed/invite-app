test:
	crystal spec

run:
	crystal src/cli.cr

bin: clean
	mkdir -p bin
	time crystal build -s --release --no-debug -o bin/invite src/cli.cr

clean:
	rm -rf ./bin/invite

tag:
	git tag `crystal eval 'require "./src/invite/version.cr"; puts "v#{Invite::VERSION}"'`

release: test bin tag

all: test bin

.PHONY: test run all bin clean
