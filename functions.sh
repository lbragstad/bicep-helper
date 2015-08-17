# Authenticate and post response in json
authenticate () {
curl -H "$CONTENT_TYPE" -X POST \
     -d "$REQUEST" \
     "$ENDPOINT/auth/tokens/" | python -m json.tool
}

# Authenticate and post response headers
authenticate_post_headers () {
curl -si -H "$CONTENT_TYPE" -X POST \
     -d "$REQUEST" \
     "$ENDPOINT/auth/tokens/"
}

# Validate a token and post response in json
validate () {
curl -H "$CONTENT_TYPE" -X GET \
     -H "X-Auth-Token: $1" \
     -H "X-Subject-Token: $2" \
     "$ENDPOINT/auth/tokens/" | python -m json.tool
}

# Validate a token and post response headers
validate_post_headers () {
curl -si -H "$CONTENT_TYPE" -X GET \
     -H "X-Auth-Token: $1" \
     -H "X-Subject-Token: $2" \
     "$ENDPOINT/auth/tokens/"
}

create_user () {
curl -i -H "$CONTENT_TYPE" -X POST \
     -H "X-Auth-Token: $1" \
     -d $2 \
    "$ENDPOINT/users/" | python -m json.tool
}

delete_user () {
curl -i -H "$CONTENT_TYPE" -X DELETE \
     -H "X-Auth-Token: $1" \
     -d "$CREATE_USER" \
    "$ENDPOINT/users/$2" | python -m json.tool
curl -i -H "$X_AUTH" -H "$CONTENT_TYPE" -X DELETE "$ENDPOINT/users/$USER_ID"
}

get_roles () {
curl -H "$CONTENT_TYPE" -X GET \
     -H "X-Auth-Token: $1" \
    "$ENDPOINT/roles" | python -m json.tool
}

grant_user_role_on_project () {
curl -H "$CONTENT_TYPE" -X PUT \
     -H "X-Auth-Token: $1" \
    "$ENDPOINT/projects/$2/users/$3/roles/$4" | python -m json.tool
}

get_catalog () {
curl -H "$CONTENT_TYPE" -X GET \
     -H "X-Auth-Token: $1" \
    "$ENDPOINT/auth/catalog" | python -m json.tool
}
