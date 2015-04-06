# Be sure to set this
export ENDPOINT=""

export CONTENT_TYPE="Content-Type: application/json"

WORKING_DIR=`pwd`
FUNCTIONS=$WORKING_DIR/functions.sh
source $FUNCTIONS

# Unscoped token request. This user is the one created from keystone-deploy's
# corresponding bootstrap.py script. We're using the admin name and domain name
# here becuase is allows us to not be dependent on knowing the user ID, which
# will different between deployments.
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
authenticate_post_headers

# Validate a token
export SUBJECT_TOKEN=''
export ADMIN_TOKEN='ADMIN'
validate $ADMIN_TOKEN $SUBJECT_TOKEN

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
create_user 'ADMIN' $CREATE_USER

# Delete user
export USER_ID=''
delete_user 'ADMIN' $USER_ID

get_roles 'ADMIN'

# Grant user role on project
export PROJECT_ID=''
export USER_ID=''
export ROLE_ID=''
grant_user_role_on_project 'ADMIN' $PROJECT_ID $USER_ID $ROLE_ID

# Get catalog
get_catalog 'ADMIN'

