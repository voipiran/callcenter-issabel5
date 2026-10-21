  ___               _          _ 
 |_ _|___ ___  __ _| |__   ___| |
  | |/ __/ __|/ _` | '_ \ / _ \ |
  | |\__ \__ \ (_| | |_) |  __/ |
 |___|___/___/\__,_|_.__/ \___|_|

# Issabel Call Center 5 — VOIPIRAN

Issabel is an open source distribution and GUI for Unified Communications systems forked from Elastix&copy;.

It uses [Asterisk](https://www.asterisk.org/) open-source PBX software as its core.

## About

Call Center Module for Issabel 5, updated by the Issabel community for installation on Rocky Linux 8, with PHP compatibility from 7.4 up to 8.0, supporting callback and agent modes.

Esta versión puede ser instalada en Asterisk 13, 16, 18 o 20 en IssabelPBX.

This repository is tested with Issabel 5 and Asterisk 13, 16, 18, or 20, and is no longer backward compatible with Issabel 4.

This repository is maintained by the Issabel community.

For questions and support, visit the [IssabelPBX Telegram community](https://t.me/IssabelPBXip).

Thanks to Nicolás Gudiño, Hamza, Julio Pacheco, and the Issabel Telegram community for their contributions.

## Installation

### Quick Installation — VOIPIRAN

Run the following command as `root` to start the VOIPIRAN installer:

```bash
bash <(curl -fsSL "https://raw.githubusercontent.com/voipiran/callcenter-issabel5/master/install-voipiran.sh?nocache=$(date +%s)")
```

The installer downloads the repository, runs the Issabel 5 installer in local
mode, enables the `issabeldialer` service, and reports the service status.

## Requirements

- Issabel 5 on Rocky Linux 8
- Asterisk 13, 16, 18, or 20
- Root access
- Internet access from the Issabel server

Create a backup of the Issabel configuration and databases before installing.
The installer is not intended for Issabel 4.

## Local installation and development

To install the checkout currently on the server instead of cloning from
GitHub, run:

```bash
cd /path/to/callcenter-issabel5
bash build/5.0/install-issabel-callcenter.sh --local
```

The repository's VOIPIRAN wrapper is `install-voipiran.sh`. It clones the
repository into `/usr/src/callcenter-issabel5` and invokes the official
installer with `--local`.

## Logs and service checks

```bash
systemctl status issabeldialer
journalctl -u issabeldialer -n 100 --no-pager
```

The dialer uses ECCP over TLS on port `20005`. Its certificate is managed by:

```bash
/opt/issabel/dialer/eccp-cert.sh
```

For installation, update, and removal details, see the scripts under
`build/5.0/`.
