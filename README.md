# Smart Home 21 – Home Assistant Dashboard

A drop-in, version-controlled Lovelace dashboard for fresh Home Assistant
installs. Sections-based layout with a "My Home" landing page that navigates
into Rooms / Lights / Scenes / Aircons / Garage / Timers / TV subviews.
Styled with Mushroom + button-card + card-mod.

---

## Repo layout

```
smarthome21-ha/
├── dashboards/
│   └── smarthome21.yaml          # the dashboard (this is the file HA loads)
├── www/
│   └── smarthome21/
│       └── rooms/                # room photos for the Rooms page (drop JPGs here)
├── scripts/
│   └── update.sh                 # one-command clone/pull/copy helper
├── configuration.snippet.yaml    # the lovelace: block to merge into configuration.yaml
└── README.md
```

The `dashboards/` and `www/` folders mirror where the files live under
`/config` on the Home Assistant box, so deployment is a straight copy.

---

## Dependencies (install BEFORE loading)

If these aren't installed you get "Custom element doesn't exist" errors
instead of a dashboard.

**HACS frontend cards:** button-card, Mushroom, card-mod, calendar-card-pro,
fold-entity-row

**Themes:** ios-light-mode-red-alternative, Frosted Glass (Light / Lite /
Dark Lite / Light Lite), Google Theme

HACS itself must be installed first.

---

## Install (per site)

1. **Get the repo onto the HA box.** Use the Advanced SSH & Web Terminal
   add-on, then run the helper (see `scripts/update.sh`) or do it manually:

   ```bash
   cd /config
   mkdir -p dashboards www/smarthome21/rooms
   git clone https://github.com/marsh4200/smarthome21-ha.git /config/smarthome21-ha
   cp /config/smarthome21-ha/dashboards/smarthome21.yaml /config/dashboards/
   cp -r /config/smarthome21-ha/www/smarthome21/* /config/www/smarthome21/
   ```

2. **Register the dashboard.** Merge `configuration.snippet.yaml` into your
   `configuration.yaml` (don't add a second `lovelace:` key — merge into the
   existing one if present).

3. **Add room photos.** Drop JPGs into `/config/www/smarthome21/rooms/`
   named to match the dashboard: `master-bedroom.jpg`, `bedroom1.jpg`,
   `bedroom2.jpg`, `bedroom3.jpg`, `pj-lounge.jpg`, `lounge.jpg`,
   `entertainment.jpg`, `kitchen.jpg`.

4. **Load it.** Restart HA, or Developer Tools → YAML → Reload Dashboards.
   "Smart Home 21" appears in the sidebar.

---

## Per-site entity IDs

Every card points at device-specific IDs (`switch.m5_2g_2_switch_1`,
`climate.gree_12d4`, `switch.nspanel1_relay`, etc.). These come out
differently on each house. Recommended workflow: on each new build, rename
the device entities to match the IDs in `smarthome21.yaml`
(Settings → Devices & Services → Entities → rename) and the whole dashboard
works unchanged. Also repoint or remove the `calendar.polor_mail_com` card.

---

## Updating

YAML-mode dashboards can't be edited in the browser — that's the trade-off
for version control. To push an update:

```bash
bash /config/smarthome21-ha/scripts/update.sh
```

Then Developer Tools → YAML → Reload Dashboards.

Or symlink instead of copy so `git pull` updates in place:

```bash
ln -sf /config/smarthome21-ha/dashboards/smarthome21.yaml /config/dashboards/smarthome21.yaml
```
