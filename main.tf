terraform {
  backend "local" {}
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 5.0"
    }
  }
}
resource "heroku_app" "this" {
  name       = "my-magic-app-123456789" # <--- Replace with any unique app name if required
  region     = "us"
  buildpacks = ["heroku/nodejs"]
}
resource "heroku_build" "this" {
  app_id = heroku_app.this.id
  depends_on = [
    heroku_app.this
  ]
  source { path = "src" }
}
resource "heroku_formation" "this" {
  app_id   = heroku_app.this.id
  type     = "web"
  quantity = 0 # <---- Heroku replaces 0 with 1 when the formation is first created.
  size     = "hobby"
  depends_on = [
    heroku_build.this
  ]
}

