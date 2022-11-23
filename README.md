# Steps to reproduce

- You will need a Heroku account with a linked credit card set up, and your credentials (`HEROKU_API_KEY` and `HEROKU_EMAIL`) available in your environment. Without these, terraform can't execute this config.

- You will also need Heroku CLI installed and authenticated.

At this project root:
1. Run `terraform init` 
2. Run `terraform apply` and confirm the plan. (If the plan fails because the app name isn't unique, rename the app in the plan)
3. Run `heroku scale -a my-magic-app-123456789`.
    - Expected output: `web=0:Hobby`
    - Actual output: `web=1:Hobby`

# Further detail, info

## An update/correction can be successfully forced
Having completed 1-4 above:

4. Run `terraform apply` **again** and confirm the plan.
5. Run `heroku scale -a my-magic-app-123456789`.
    - Output: `web=0:Hobby`. This time, Heroku listened.

## The debug logs have some awareness of the problem

For steps 1-3 above, the debug output (in this project: `debug.txt`) at line 979 shows:

```
{"app":{"id":"9d8fbed1-627b-401f-89f5-fb9c36ae5a1f","name":"my-magic-app-123456789"},"command":"npm start","created_at":"2022-11-23T09:52:44Z","id":"faa71e0a-4d17-4a77-aeac-42803581e13b","type":"web","quantity":1,"size":"Hobby","updated_at":"2022-11-23T09:52:56Z"}: timestamp=2022-11-23T20:52:56.634+1100
2022-11-23T20:52:56.636+1100 [WARN]  Provider "provider[\"registry.terraform.io/heroku/heroku\"]" produced an unexpected new value for heroku_formation.this, but we are tolerating it because it is using the legacy plugin SDK.
    The following problems may be the cause of any confusing errors from downstream operations:
      - .quantity: was cty.NumberIntVal(0), but now cty.NumberIntVal(1)
```


