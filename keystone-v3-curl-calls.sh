export ENDPOINT="http://10.0.2.15:35357/v3"

export ADMIN_TOKEN="tokentoken"

export X_AUTH="X-Auth-Token: $ADMIN_TOKEN"

export CONTENT_TYPE="Content-Type: application/json"

WORKING_DIR=`pwd`
FUNCTIONS=$WORKING_DIR/functions.sh
source $FUNCTIONS

# unscoped token request
export REQUEST='{
    "auth": {
        "identity": {
            "methods": [
                "password"
            ],
            "password": {
            "user": {
            "domain": {
                "id": "default"
            },
            "password": "password",
            "name": "admin"
            }
            }
        }
    }
}'
export CALLPATH='/auth/tokens/'
export METHOD='POST'
authenticate_post_headers

# domain scoped token request
export REQUEST='{
    "auth": {
        "identity": {
            "methods": [
                "password"
            ],
            "password": {
            "user": {
            "domain": {
                "id": "default"
            },
            "password": "password",
            "name": "admin"
            }
            }
        },
        "scope": {
            "domain": {
                "id": "default"
            }
        }
    }
}'
export CALLPATH='/auth/tokens/'
export METHOD='POST'
authenticate_post_headers

# project scoped token request
export REQUEST='{
    "auth": {
        "identity": {
            "methods": [
                "password"
            ],
            "password": {
            "user": {
            "domain": {
                "id": "default"
            },
            "password": "password",
            "name": "admin"
            }
            }
        },
        "scope": {
            "project": {
                "domain": {
                    "id": "default"
                },
                "name": "admin"
            }
        }
    }
}'
export CALLPATH='/auth/tokens/'
export METHOD='POST'
authenticate_post_headers

# Validate a token
export SUBJECT_TOKEN="995b92a0c4374d13bcb15a1ff186f6de"

export SUBJECT_TOKEN="gAAAAABVEHWvh6gx48onD87OshMIX0y4XpsqD1t-c3YGJkCg6ES5FZCVKrYbfUGTW5oq6r5C94vrJeKsohfW3P_eUCyf1DLtd6cxLm6OiHJMlgiQMiR96Zi3NBuir5KU4osUTmw3dHebrDJlaS8esDMGzx8-hPw3KbWD3_JC5fHeMmg-ZJ0a6As%3D"

validate 'tokentoken' $SUBJECT_TOKEN | python -m json.tool

curl -H "$X_AUTH" -H "$X_SUBJECT" -H "$CONTENT_TYPE" -X GET \
    "$ENDPOINT/auth/tokens/" | python -m json.tool

# Validate and post response headers
time curl -si -H "$X_AUTH" -H "$X_SUBJECT" -H "$CONTENT_TYPE" -X GET \
    "$ENDPOINT/auth/tokens/"


# Get users
curl -H "$X_AUTH" -H "$CONTENT_TYPE" -X GET "$ENDPOINT/users/" | python -m json.tool


# Get projects
curl -H "$X_AUTH" -H "$CONTENT_TYPE" -X GET "$ENDPOINT/projects/" | python -m json.tool


# Create user
export CREATE_USER='{
        "user": {
            "description": "Joe Developer user space",
            "email": "jdoe@example.com",
            "enabled": true,
            "name": "James Doe",
            "password": "chang3me"
        }
       }'

curl -i -H "$X_AUTH" -H "$CONTENT_TYPE" -d "$CREATE_USER" -X POST \
    "$ENDPOINT/users/" | python -m json.tool


# Delete user
export USER_ID='f95529a2157942fb8bde458da9149854'

curl -i -H "$X_AUTH" -H "$CONTENT_TYPE" -X DELETE "$ENDPOINT/users/$USER_ID"


# Get roles
curl -H "$X_AUTH" -H "$CONTENT_TYPE" -X GET \
    "$ENDPOINT/roles" | python -m json.tool


# Grant user role on project
export PROJECT_ID='f95529a2157942fb8bde458da9149854'
export USER_ID='f95529a2157942fb8bde458da9149854'
export ROLE_ID='f95529a2157942fb8bde458da9149854'

curl -i -H "$X_AUTH" -H "$CONTENT_TYPE" -X PUT \
    "$ENDPOINT/projects/$PROJECT_ID/users/$USER_ID/roles/$ROLE_ID"


# List user roles on a project
export PROJECT_ID='6eb63b61f1f242be90eae56f70e65368'
export USER_ID='4aeaf2704868416aa66c2c96e36f1589'

curl -i -H "$X_AUTH" -H "$CONTENT_TYPE" -X GET \
    "$ENDPOINT/projects/$PROJECT_ID/users/$USER_ID/roles/" | python -m json.tool


# Get catalog
export TOKEN="570d1424d38f44ad91340ad645f2fb5c"

curl -H "X-Auth-Token: $TOKEN" -H "$CONTENT_TYPE" -X GET \
    "$ENDPOINT/auth/catalog" | python -m json.tool


# Auth token
curl -H "X-Auth-Token: tokentoken" \
     -H "X-Subject-Token: a343bdd3f6ef4be8b8a7a11b4311cf46" \
     -H "Content-Type: application/json" \
     http://localhost:5000/v3/auth/tokens/


# Check Token with HEAD
export TOKEN="570d1424d38f44ad91340ad645f2fb5c"
export X_SUBJECT="X-Subject-Token: $TOKEN"

curl -H "$X_AUTH" -H "$X_SUBJECT" -H "$CONTENT_TYPE" --head \
    "$ENDPOINT/auth/tokens/"

# List services
curl -H "$X_AUTH" -H "$X_SUBJECT" -H "$CONTENT_TYPE" -X GET \
    "$ENDPOINT/services/" | python -m json.tool

export REQUEST='{
        "endpoint": {
            "name": "metering",
            "interface": "admin",
            "region": "RegionOne",
            "url": "https://fd55:faaf:e1ab:3ea:9:114:251:134",
            "service_id": "1df766407ff345e0bdc0289454a4bba4"
        }
       }'

# Create endpoint
curl -H "$X_AUTH" -H "$X_SUBJECT" -H "$CONTENT_TYPE" -X POST \
     -d "$REQUEST" "$ENDPOINT/endpoints/" | python -m json.tool

export REQUEST='{
        "project": {
            "name": "my_project"
        }
       }'

# Create project
curl -H "$X_AUTH" -H "$CONTENT_TYPE" -X POST \
     -d "$REQUEST" "$ENDPOINT/projects/" | python -m json.tool

# List regions
curl -H "$X_AUTH" -H "$X_SUBJECT" -H "$CONTENT_TYPE" -X GET \
     "$ENDPOINT/regions/" | python -m json.tool

export REQUEST='{
        "region": {
        }
       }'

# Create a region
curl -H "$X_AUTH" -H "$X_SUBJECT" -H "$CONTENT_TYPE" -X POST \
     -d "$REQUEST" "$ENDPOINT/regions/" | python -m json.tool

# Update a region
export REGION_ID='f7d8b8466a96470b9913745d9e86e03b'
export REQUEST='{
        "region": {
            "description": null
        }
       }'

curl -H "$X_AUTH" -H "$X_SUBJECT" -H "$CONTENT_TYPE" -X PATCH \
    -d "$REQUEST" "$ENDPOINT/regions/$REGION_ID"

# Delete a region
export REGION_ID='3563489e2bad4dea80fed2dc77d8704f'

curl -H "$X_AUTH" -H "$X_SUBJECT" -H "$CONTENT_TYPE" -X DELETE \
    "$ENDPOINT/regions/$REGION_ID"

# Create role to user
export USER_ID='09c8433adf8d481690177a42caa5f6b0'
export PROJECT_ID='06d8c1860c8c4fe1a6a55aacefa21d77'
export ROLE_ID='20598b1f6dbe470792f641acf1fbd93e'


curl -H "$X_AUTH" -H "$X_SUBJECT" -H "$CONTENT_TYPE" -X POST \
     -d "$REQUEST" "$ENDPOINT/projects/$PROJECT_ID/users/$USER_ID/roles/$ROLE_ID"

# Authenticate and parse response in JSON
export REQUEST='{
            "auth": {
                "identity": {
                    "methods": [
                        "password"
                    ],
                    "password": {
                        "user": {
                            "id": "09c8433adf8d481690177a42caa5f6b0",
                            "password": "secrete"
                        }
                    }
                },
                "scope": {
                    "project": {
                        "id": "06d8c1860c8c4fe1a6a55aacefa21d77"
                    }
                }
            }
        }'

curl -H "$CONTENT_TYPE" -X POST \
    -d "$REQUEST" "$ENDPOINT/auth/tokens/" | python -m json.tool

# Authenticate and post response headers
curl -si -H "$CONTENT_TYPE" -X POST \
    -d "$REQUEST" "$ENDPOINT/auth/tokens/?nocatalog"

# List trusts
curl -H "$X_AUTH" -H "$X_SUBJECT" -H "$CONTENT_TYPE" -X GET \
     "$ENDPOINT/OS-TRUST/trusts" | python -m json.tool

# Create a trust
export TOKEN="KLWT00APg8xNeIdPvhg20KD2VfjRWxbwSDZc2Jog9yWKuArod9G893_Xv7SNuq-Bx9CWrS4ZvAAxhhRfy59ERVGTIrOuTa4F9ENASwO2sSVKax9J5D68BXVTE3k1R_CZFK8C-SLBmQ-91fR165IHXLz8yconz-VZwy3iTUBA"
export X_AUTH="X-Auth-Token: $TOKEN"
export REQUEST='{
    "trust": {
        "expires_at": "2016-02-27T18:30:59.999999Z",
        "impersonation": true,
        "allow_redelegation": true,
        "project_id": "72746f9ae6ff4474a6df4d62c9c77780",
        "roles": [
            {
                "name": "admin"
            }
        ],
        "trustee_user_id": "bdf7e8acb22c4b178fd9eec478860df7",
        "trustor_user_id": "2b751d08ef7e42f0a475a03720010a28"
    }
}'

curl -si -H "$CONTENT_TYPE" -H "$X_AUTH" -X POST \
    -d "$REQUEST" "$ENDPOINT/OS-TRUST/trusts/"

# Get unscoped token
export REQUEST='{
    "auth": {
        "identity": {
            "methods": [
                "password"
            ],
            "password": {
                "user": {
                    "password": "password",
                    "id": "bdf7e8acb22c4b178fd9eec478860df7"
                }
            }
        }
    }
}'
# Authenticate and post response headers
curl -si -H "$CONTENT_TYPE" -X POST \
    -d "$REQUEST" "$ENDPOINT/auth/tokens/"

# Rescope an unscoped token with a trust
export TRUST_ID='c27552c12a6e4710ab3c49f2fbdfdca0'
export UNSCOPED_TOKEN='KLWT00APg8xNcekXuTxKt6vr319o7HfjPGr3pjSXmgyOH-k75t5D6Nx5WOIsjyK-OLv3GkDwc6tGxH9gnsKs1pKvviSgAkGTT16tF9DJoF12aphbypiQoSjiSR5tLbokhQGgsGCh_oiqDDhtq_'
export REQUEST='{
    "auth": {
        "identity": {
            "methods": [
                "token"
            ],
            "token": {
                "id": "'$UNSCOPED_TOKEN'"
            }
        },
        "scope": {
            "OS-TRUST:trust": {
                "id": "'$TRUST_ID'"
            }
        }
    }
}'
curl -si -H "$CONTENT_TYPE" -X POST \
    -d "$REQUEST" "$ENDPOINT/auth/tokens/"

# Validate a trust scoped token

export ADMIN_TOKEN="KLWT00APg8xNctq4Y0t7vEXxFNdlzkmpWlfrj6bSkZ4rEexDd_qzlfcSsKJ256kqsEM_kAHuFM07EiuOhZ2OqvWcA4F-nZsQQ2cm46jX3Pz8DCn8xQwPifhmH1MxIhyeb9-K6dAwlL4m7Y55i3eKAgysav6bGwbcl4_FK2Cw"
export X_AUTH="X-Auth-Token: $ADMIN_TOKEN"
export TOKEN="KLWT01APg8xNdEkQF9cDWxGAC6drIbk_suZ_oiMKLV1gbPHMMhZNzqDysU_GUtoHCUa7AFFvmVdmgUaaQ3IN5mZRwygRaseRl5wFX8xYXHu-JwxKM_B8XkwMnCGLn8r7vCaM511QkgglSA9cbJYO00gyQO81ZjSVsZ0yYZ3UOhZ2QtGvmVKNvqUXAqb7A-jtPPF23JHKNT03nRJCsv"
export X_SUBJECT="X-Subject-Token: $TOKEN"
curl -si -H "$X_AUTH" -H "$X_SUBJECT" -H "$CONTENT_TYPE" -X GET \
    "$ENDPOINT/auth/tokens/"
