#!/bin/bash

host=10.10.11.65:7871
curl -X POST -H 'Content-Type: application/json' -d '{"client_id":"600065751"}' -d '{"client_secret":"PNhpiyJjWxE9+iGd1kRpa4BqAD/yjB3ReDU0FZZV9+4="}' http://${host}/token