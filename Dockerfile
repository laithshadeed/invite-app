FROM crystallang/crystal:0.24.1

# Install Dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && apt-get install -y --no-install-recommends libpq-dev libsqlite3-dev libmysqlclient-dev libreadline-dev git curl vim netcat

WORKDIR /opt/invite

# Build Invite
ENV PATH /opt/invite/bin:$PATH
ADD . /opt/invite
RUN shards build invite --release --no-debug

CMD ["crystal", "spec"]
