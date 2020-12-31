FROM google/dart-runtime:2.10 AS builder
# setting cacke folder
ENV PUB_CACHE=/tmp
# copy files from the host to the container
COPY . .
# run build sequence
RUN /usr/lib/dart/bin/pub get && /usr/lib/dart/bin/dart2native bin/main.dart -o main


FROM docker.io/amazon/aws-lambda-provided:al2
WORKDIR /app/
COPY --from=builder /app/main .

ENTRYPOINT ["/app/main"]
