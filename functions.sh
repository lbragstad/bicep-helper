authenticate () {
# Authenticate and post response in json
curl -H "$CONTENT_TYPE" -X $METHOD\
     -d "$REQUEST" "$ENDPOINT$CALLPATH" | python -m json.tool
}

time_authenticate () {
# Authenticate and post response headers
time curl -si -w \\n%{time_total}\\n -H "$CONTENT_TYPE" -X $METHOD\
          -d "$REQUEST" "$ENDPOINT$CALLPATH"
}

authenticate_post_headers () {
# Authenticate and post response headers
curl -si -H "$CONTENT_TYPE"\
     -X $METHOD -d "$REQUEST" "$ENDPOINT$CALLPATH"
}

validate () {
curl -H "X-Auth-Token: $1" -H "X-Subject-Token: $2" -H "$CONTENT_TYPE" \
     -X GET "$ENDPOINT/auth/tokens/"
}

make_call_post_headers () {
curl -si -H "X-Auth-Token: $1" -H "X-Subject-Token: $2" -H "$CONTENT_TYPE" \
     -X $3 "$ENDPOINT$4"
}
