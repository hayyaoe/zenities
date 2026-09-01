# Zenities

It's time for a fresh start with Quickshell. This update focuses on migrating and refining the existing visual identity while stripping away unnecessary dependencies. The goal is to build a truly scalable, easy-to-update desktop framework that remains highly customizable and beginner-friendly.

---

## System Architecture

Zenities strictly follows the XDG Base Directory specification to keep engine updates isolated from user configurations:

* **Rice Space (`~/.local/share/zenities`)**: Core QML engine, system rules, and color generation templates. Managed entirely by upstream releases.
* **User Space (`~/.config/zenities`)**: User layout preferences, dynamic color palettes, and auto-generated application themes.


## Dependencies

Zenities relies purely on standard system services and native Wayland protocols.
* **Core Shell Runtime**: `quickshell`, `hyprland`
* **Color Pipeline**: `matugen`
* **Hardware & Audio Daemons**: `pipewire`, `wireplumber`, `networkmanager`, `bluez`, `upower`, `brightnessctl`
* **Typography**: `Iosevka Mono`


## Session Management

Zenities is designed around modern Wayland standards and leverages **UWSM (Universal Wayland Session Manager)** for proper systemd cgroup management, clean environment variable binding, and robust process lifetimes.

> **Note:** A standard non-UWSM fallback is supported, but UWSM is highly recommended for optimal daemon lifecycle management.

---

## Migration Roadmap

### Phase 1: Core Architecture & Scaffolding
- [ ] Establish repository skeleton and CLI development tool
- [ ] Build reactive JSON configuration & theme loading engine
- [ ] Implement integrated background & wallpaper rendering
- [ ] Define baseline Hyprland layer-shell rules & window behaviors

### Phase 2: Bar & Interactive Modules
- [ ] Port primary status bar (Vertical & Horizontal layouts)
- [ ] Implement reactive workspace and active window tracking
- [ ] Build hardware-accelerated interactive sliders for audio and brightness
- [ ] Connect event-driven system telemetry (Battery, Network, MPRIS)

### Phase 3: Unified Overlays & Color Pipeline
- [ ] Build Unified Control Panel (Side Drawer & Dropdown modes)
- [ ] Implement keyboard-driven wallpaper selector dialog
- [ ] Integrate dynamic color generation pipeline with live reloading

### Phase 4: Integrations & Distribution
- [ ] Add decoupled color export templates for popular terminals and prompts
- [ ] Build an idempotent one-liner installation script
- [ ] Implement CLI health checks and automated update mechanisms

## Details

- OS: **[Arch Linux](https://github.com/archlinux)**
- Compositor: **[Hyprland](https://github.com/hyprwm/Hyprland)**
- Widget: **[Quickshell](https://github.com/outfoxxed/quickshell)**


## Credits
- **[Rxyhn](https://github.com/rxyhn/tokyo)**
- **[saimoomedits](https://github.com/saimoomedits/eww-widgets/tree/main)**
