# RAGE Car Lock (ESX)

A simple and efficient car lock script for FiveM (ESX) that syncs across all players. This script requires **ox\_lib** as a dependency.

## Features

- **Fully Synchronized**: Car locking status updates for all players.
- **Temporary Locking**: Easily add or remove keys for temporary vehicles like job spawns.
- **Optimized & Lightweight**: Runs smoothly without performance issues.
- **ESX Compatible**: Designed specifically for ESX servers.

## Requirements

- **[ox\_lib](https://github.com/overextended/ox_lib)**

## Installation

1. Download and place the `RAGE_CarLock` script in your `resources` folder.
2. Add `ensure RAGE_CarLock` to your `server.cfg`.
3. Ensure **ox\_lib** is properly installed and running.

## Exports

You can easily manage temporary locks using these functions:

```lua
exports['RAGE_CarLock']:AddKey(plate)
exports['RAGE_CarLock']:RemoveKey(plate)
```

- **AddKey(plate)**: Grants temporary access to a vehicle.
- **RemoveKey(plate)**: Revokes access to a vehicle.

## Support

If you have any issues or need assistance, feel free to contact me on Discord: `chaos_rage`

## License

This project is open source. You are free to use, modify, and distribute it under the following conditions:

- **You may not resell this script in any form.**
- **You may not rename the project or claim it as your own.**

See the [LICENCE](https://github.com/Rage-Gaming/RAGE_CarLock/blob/main/LICENSE) file for more details.

## Copyright ©

<a href="//www.dmca.com/Protection/Status.aspx?ID=7b1b02ab-7031-4a8b-ad7e-78c3ae2fce62" title="DMCA.com Protection Status" class="dmca-badge"> <img src ="https://images.dmca.com/Badges/dmca_protected_sml_120m.png?ID=7b1b02ab-7031-4a8b-ad7e-78c3ae2fce62"  alt="DMCA.com Protection Status" /></a>