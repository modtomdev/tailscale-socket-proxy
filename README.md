# Tailscale Socket Proxy

Minimal HAProxy image that exposes the local Tailscale Unix socket over TCP.

## Disclaimer

This is a personal project intended for experimentation. It is not a production-hardened security product.

- Do **not** publish this proxy port to the public internet.
- Keep binding scoped to localhost or an internal private network.
- Grant only the minimum LocalAPI sections your service needs.
- Treat access to this proxy as privileged access.

## Usage

```sh
docker container run -d \
  --name tailscale-socket-proxy \
  --publish 127.0.0.1:2375:2375 \
  --volume /var/run/tailscale/tailscaled.sock:/var/run/tailscale/tailscaled.sock \
  <your-image>
```

Then call the proxy:

```sh
curl http://localhost:2375/localapi/v0/status
```

## Environment variables

- `SOCKET_PATH` (default: `/var/run/tailscale/tailscaled.sock`)
- `DISABLE_IPV6` (default: `0`)
- `LOG_LEVEL` (default: `info`)
- `POST` (default: `0`)
- `ALL` (default: `0`)

### Grant/revoke LocalAPI sections

Access is controlled with `0`/`1` env vars.
These are denied by default unless explicitly enabled:

- `CHECK_PREFS`
- `CHECK_SO_MARK_IN_USE`
- `DERPMAP`
- `DNS_CONFIG`
- `GOROUTINES`
- `LOGIN_INTERACTIVE`
- `LOGOUT`
- `PEER_BY_ID`
- `PREFS`
- `PROFILES` (`/localapi/v0/profiles/*`)
- `RELOAD_CONFIG`
- `RESET_AUTH`
- `SERVICES`
- `SET_EXPIRY_SOONER`
- `SHUTDOWN`
- `START`
- `USER_PROFILE`
- `WHOIS`

Enabled by default:

- `ROOT` (`/`)
- `PING`
- `STATUS`
- `CERT` (`/localapi/v0/cert*` and `/localapi/v0/cert-domains`)
