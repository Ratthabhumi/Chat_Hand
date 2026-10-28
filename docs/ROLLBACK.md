# Rollback

No installed runtime, tunnel, credential, service, scheduled task or firewall rule was created by this work. No production repository rollback is needed.

The local probe removes its own unique output file in finally. Successful cleanup is recorded in `evidence/local-probe.json`. If interrupted outside finally, inspect `sandbox/test-output` and remove only the matching synthetic `probe-*.txt` file after reviewing it. Do not recursively delete project folders.

Keep the repository as evidence, or remove it manually after preserving any future work. Removing documentation from disk does not remove the GitHub history. No remote deletion performed or recommended as part of this setup.

Future remote tests: disconnect the specific device/connector in its UI and verify a fresh file call fails. For any future custom tunnel, stop its client, remove its startup entry if one was explicitly added, revoke the dedicated runtime credential in Platform, remove the custom plugin/tunnel associations, and test access failure. These future revocation steps were NOT exercised in this run.
