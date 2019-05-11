#!/usr/bin/env bash

server() {
    python -m http.server --directory src/
}

deploy() {
    local bucket=${1}
    local distribution=${2}
    aws s3 sync --acl public-read src/ s3://${bucket}/
    aws cloudfront create-invalidation --distribution-id ${distribution} --paths '/*' > /dev/null
}


"$@"
