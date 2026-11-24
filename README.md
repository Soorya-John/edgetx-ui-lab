# EdgeUI

An alpha interface study for EdgeTX radios with a 128 × 64 monochrome screen. The first target is the RadioMaster Pocket. It runs as an EdgeTX Tools Lua script and reads the active model, link signal and firmware details.

## Try it

Copy `SCRIPTS/TOOLS/EdgeUI.lua` to the same path on an EdgeTX SD card. Safely eject the card, then open **Radio Settings → Tools → EdgeUI**. Use the roller to choose a page, **ENT** to open it and **RTN** to return. Exit from the page list with **RTN**.

Use a simulator model with RF modules off when exploring the interface. The tool does not alter models, mixes, radio settings or files.

## Alpha scope

The four pages are Home, Model, Telemetry and Radio. Home and Model show the active model name. Telemetry shows the RSSI value exposed by EdgeTX or a no-signal state. Radio shows the EdgeTX version and radio identifier.

This is a foundation for discussing hierarchy, typography and navigation. It does not replace the EdgeTX firmware interface.
