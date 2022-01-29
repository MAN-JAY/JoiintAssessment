#===========
#Build Stage
#===========
FROM elixir:1.12-alpine as build

#Copy the source folder into the Docker image
COPY . .

#Install dependencies and build Release
RUN export MIX_ENV=prod && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix compile && \
    mix escript.build

#Extract Release archive to /rel for copying in next stage
RUN APP_NAME=assessment && \
    mkdir runtime && \
    cp advantage_map.json runtime/ && \
    cp assessment runtime/

#================
#Deployment Stage
#================
FROM erlang:24-alpine

ENV REPLACE_OS_VARS=true \
    LANG=C.UTF-8

WORKDIR /opt/app

#Copy runtime file from the previous stage
COPY --from=build /runtime/ .

RUN chmod +x -R advantage_map.json && \
  chmod +x -R assessment

CMD trap 'exit' INT; /opt/app/assessment -c coupons.json
