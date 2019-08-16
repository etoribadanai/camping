FROM bitwalker/alpine-elixir-phoenix:1.8.1

# Exposes this port from the docker container to the host machine
EXPOSE 80
ENV MIX_ENV=prod
ENV HOST_VARS inject_here

RUN \
  apk update && apk upgrade \
  && apk add --no-cache postgresql-client postgresql-dev \
  && mkdir /app

WORKDIR /app

# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

ADD assets/package.json assets/
RUN cd assets && \
  npm install

ADD . .

# Run frontend build, compile, and digest assets
RUN cd assets/ && \
  npm run deploy && \
  cd - && \
  mix do compile, phx.digest

ADD . .

RUN mix do compile, ecto.create, ecto.migrate

# The command to run when this image starts up
CMD ["mix", "phx.server"]