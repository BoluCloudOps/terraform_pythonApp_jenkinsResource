provider "aws" {
  region                   = "eu-central-1"
  shared_credentials_files = ["/Users/bolu/.aws/credentials"]
}

# provider "vault" {
#   address = "http://18.153.93.76:8200"
#   skip_child_token = true

#   auth_login {
#     path = "auth/approle/login"

#     parameters = {
#       role_id = "95a8e38f-5018-236a-3d33-0f6c5af8c479"
#       secret_id = "e921806e-bad0-36c2-1edf-8613cba6cc8f"
#     }
#   }
# }



