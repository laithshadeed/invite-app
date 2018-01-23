# Invite APP

[![Linux Build status](https://travis-ci.org/laithshadeed/invite-test.svg?branch=master)](https://travis-ci.org/laithshadeed/invite-test)

Invite your customers within certain range in KM

## Installation

```
# Install Crystal via https://crystal-lang.org/docs/installation
shards build --release --no-debug
```

## Usage

```
./bin/invite -f path/to/your/data -d distance_in_km
```

## Test

```
crystal spec
crystal spec --release --no-debug
```

### Docker
```
docker pull laithshadeed/invite-app
```

## Man pages
```
 man 1 ./man/invite.1
```

### Download
```
wget https://github.com/laithshadeed/invite-test/releases/download/v0.1.0/invite
./invite --help
```
