# Rollback

## V3 installed pilot

Run `powershell -NoProfile -File scripts/Dwb-Pilot.ps1 -Action Stop` to stop only the pilot's recorded Tunnel and drain/stop its broker. Local test shutdown was verified with broker state stopped; credentialed Tunnel shutdown/revocation is NOT TESTED. Close the pilot Dashboard after stopping. No startup entry or service was installed, and no credentials were provisioned.

Keep the old Remote Desktop Commander unchanged as the rollback route. If removing DWB, first preserve any future pilot data/work, then review and manually remove only `%LOCALAPPDATA%\ChatHand\DWB-beta16` and `%LOCALAPPDATA%\DWB-MCP-Studio-ChatHand`. Do not delete the Chat_Hand sandbox or old Remote data. Complete uninstall/data deletion was not executed or claimed tested.

If a key/tunnel is added later, owner must revoke that dedicated key in Platform and remove the pilot plugin/tunnel associations, then verify a fresh call fails. Stopping alone does not revoke a key. Never paste key.dpapi or raw auth files into Git. No production rollback is needed for this setup.

## Historical V1/V2 rollback

No installed runtime, tunnel, credential, service, scheduled task or firewall rule was created by this work. No production repository rollback is needed.

The local probe removes its own unique output file in finally. Successful cleanup is recorded in `evidence/local-probe.json`. If interrupted outside finally, inspect `sandbox/test-output` and remove only the matching synthetic `probe-*.txt` file after reviewing it. Do not recursively delete project folders.

Keep the repository as evidence, or remove it manually after preserving any future work. Removing documentation from disk does not remove the GitHub history. No remote deletion performed or recommended as part of this setup.

Future remote tests: disconnect the specific device/connector in its UI and verify a fresh file call fails. For any future custom tunnel, stop its client, remove its startup entry if one was explicitly added, revoke the dedicated runtime credential in Platform, remove the custom plugin/tunnel associations, and test access failure. These future revocation steps were NOT exercised in this run.
