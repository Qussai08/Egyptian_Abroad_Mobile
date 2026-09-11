# Android signing setup

Release signing material is local-only and must be obtained from the team's approved secret store.

1. Copy `key.properties.example` to `key.properties`.
2. Fill in the required values locally.
3. Confirm `key.properties` and any `.jks` file are ignored before committing.

Do not paste signing values into source code, issues, pull requests, CI logs, or documentation.
