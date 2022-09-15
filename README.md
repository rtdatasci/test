# test
list of tests to test

## .Renviron
Copy the following and paste into a terminal from the project root to set this up

```bash
# cd to project root
cat <<EOT >> .Renviron
EMAIL=<your_email_here>
KEYRING_PSW=Automated
KR_NAME=automated
LOG_LVL=INFO
TMP_DIR=./tmp
EOT
```
Open the '.Renviron' file, update the first key value as appropriate, and save the file. Restart R session

