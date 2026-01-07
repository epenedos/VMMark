# VMMark

**An iOS application for viewing and comparing VMware benchmark results.**

> **Note:** This is an archived repository preserved for historical purposes. The project is no longer actively maintained.

## Overview

VMMark was an iOS application (iPhone/iPad) that fetched VMware benchmark data from VMware's servers and presented it in a browsable, searchable interface. Users could compare OEM benchmark results and view paired system comparisons.

## Project Details

| Attribute | Value |
|-----------|-------|
| Platform | iOS (Universal - iPhone + iPad) |
| Language | Objective-C |
| Architecture | MVC (Model-View-Controller) |
| Created | March 2013 |
| Author | Eduardo Penedos |
| Deployment Target | iOS 4.3+ |

## Features

- Browse benchmark results by OEM brand
- Search and filter results
- View detailed benchmark specifications
- Compare paired system configurations
- Offline caching of benchmark data

## Project Structure

```
VMMark/
├── VMMark/                 # Main iOS application source
│   ├── *.h/*.m             # Objective-C source files
│   ├── VMMark-Info.plist   # App configuration
│   └── en.lproj/           # Storyboards and localization
├── VMBenchMark/            # Secondary app variant
├── vmbench.xcodeproj/      # Xcode project
└── *.png                   # App icons and launch screens
```

## Building

1. Open `vmbench.xcodeproj` in Xcode
2. Select target (iPhone/iPad Simulator or Device)
3. Build and Run

## Technical Notes

- Uses `NSURLConnection` for networking (deprecated in modern iOS)
- Data source: VMware CSV endpoint
- Local caching via `NSKeyedArchiver`
- No external dependencies - pure iOS frameworks (UIKit, Foundation, QuartzCore)

## License

This project is archived for historical reference.
