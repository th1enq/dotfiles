# NixOS Config

## Layout

```text
.
├── flake.nix
├── flake.lock
├── hosts/
│   ├── laptop/
│   ├── workstation/
│   └── server/
├── modules/
│   ├── common/
│   ├── desktop/
│   ├── services/
│   └── security/
├── home/
│   └── th1enq/
└── overlays/
    ├── default.nix
    └── packages/
```

`hosts/laptop` is the current machine. `workstation` and `server` are placeholders
until their hardware configs exist.

`modules/common` contains shared system basics, `modules/desktop` contains GUI
and desktop-session modules, `modules/services` contains service and
virtualisation modules, and `modules/security` contains security defaults.

`home/th1enq` contains the Home Manager profile. `overlays/default.nix` exposes
custom packages from `overlays/packages`.

## Review Without Applying

```sh
nix flake check --no-build path:/etc/nixos
nixos-rebuild build --flake /etc/nixos#laptop
```

Only run `sudo nixos-rebuild switch --flake /etc/nixos#laptop` after review.
