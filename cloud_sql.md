# Cloud SQL how-tos

## Setting a password, including setting it to empty

Set root password:

```
gcloud sql users set-password root --project=triton-dev --instance=development-01  --host=% --prompt-for-password 
```

To make it empty, just press return at the password prompt.

