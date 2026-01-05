# CLAUDE.md - AI Assistant Guide for VMMark

## Project Overview

**VMMark** is an iOS application (iPhone/iPad) that displays and compares VMware benchmark results. It fetches benchmark data from VMware's servers and presents it in a browsable, searchable interface with OEM comparisons and pair matching features.

- **Platform:** iOS (Universal - iPhone + iPad)
- **Language:** Objective-C
- **Architecture:** MVC (Model-View-Controller)
- **Storyboard-based UI:** MainStoryboard (iPhone), StoryboardIpad (iPad)
- **Original Creation:** March 2013
- **Author:** Eduardo Penedos

## Directory Structure

```
VMMark/
├── VMMark/                     # Main iOS application source
│   ├── *.h/*.m                 # Objective-C headers and implementations
│   ├── VMMark-Info.plist       # App configuration
│   ├── en.lproj/               # Localization files
│   └── [images]                # UI assets (PNG files)
├── VMBenchMark/                # Secondary app variant (minimal)
├── vmbench.xcodeproj.zip       # Archived Xcode project
├── Default*.png                # Launch screen images
└── VMBenchMark@*.png           # App icons
```

## Key Source Files

### Entry Points
| File | Purpose |
|------|---------|
| `VMMark/main.m` | iOS application entry point |
| `VMMark/VMAppDelegate.h/m` | App lifecycle, UI customization |

### Data Model
| File | Purpose |
|------|---------|
| `VMMark/VMMarksResults.h/m` | Benchmark result data model (NSCoding compliant) |
| `VMMark/VMMarksResultsDataController.h/m` | Data management and persistence |

### Utilities
| File | Purpose |
|------|---------|
| `VMMark/WebRequest.h/m` | Async HTTP requests with completion blocks |
| `VMMark/utl_csvParser.h/m` | CSV file parser for benchmark data |

### View Controllers
| File | Purpose |
|------|---------|
| `VMMark/VMTabBarController.h/m` | Root tab bar container |
| `VMMark/VMListOEMViewController.h/m` | OEM brand list view |
| `VMMark/VMListOEMCompleteViewController.h/m` | OEM results list with search |
| `VMMark/VMListOEMDetailsViewController.h/m` | Detailed benchmark specs |
| `VMListPairViewController.h/m` | Paired system comparisons (root level) |
| `VMMark/VMVMMarkHelpViewController.h/m` | Help/info screen |

### Custom Cells
| File | Purpose |
|------|---------|
| `VMMark/VMListOEMCell.h/m` | OEM table cell |
| `VMMark/VMListOEMCompleteCell.h/m` | Detailed result cell |
| `VMListPairCell.h/m` | Pair comparison cell (root level) |

## Code Conventions

### Naming Patterns
- **Class Prefix:** `VM` (VMware Mark)
- **Controllers:** `*ViewController` suffix
- **Cells:** `*Cell` suffix
- **Utilities:** `utl_` prefix
- **Properties:** camelCase

### Objective-C Style
```objc
// Property declarations use strong/weak
@property (strong, nonatomic) NSMutableArray *resultsList;

// IBOutlet for Interface Builder connections
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;

// Block-based callbacks for async operations
+ (void)requestPath:(NSString *)path onCompletion:(RequestBlock)callback;
```

### Design Patterns Used
1. **MVC** - Clear model/view/controller separation
2. **Data Controller** - Centralized data management (`VMMarksResultsDataController`)
3. **Completion Blocks** - Async network requests use block callbacks
4. **Delegation** - UITableView and UISearchBar delegates
5. **NSCoding** - Model serialization for local caching

## Build & Configuration

### Xcode Project
- **Project File:** `vmbench.xcodeproj.zip` (extract before use)
- **Bundle ID:** `com.penwaretech.${PRODUCT_NAME:rfc1034identifier}`
- **Deployment Target:** iOS 4.3+
- **Architecture:** armv7

### Configuration Files
- `VMMark/VMMark-Info.plist` - Main app configuration
- `VMBenchMark/VMBenchMark-Info.plist` - Alternative variant config

### Build Steps
1. Extract `vmbench.xcodeproj.zip`
2. Open in Xcode
3. Select target (iPhone/iPad Simulator or Device)
4. Build and Run

## Data Flow

```
Remote Data Source (VMware CSV)
         ↓
   WebRequest (async HTTP)
         ↓
   utl_csvParser (parse CSV)
         ↓
VMMarksResultsDataController (populate models)
         ↓
   VMMarksResults objects
         ↓
   Local Cache (NSKeyedArchiver)
         ↓
   UITableView Display
```

### Data Sources
- **Remote:** `http://www.vmware.com/a/vmmark/1/?csv=1`
- **Local Cache:** `~/Documents/results.dat`

### Data Model Properties (VMMarksResults)
```objc
@property NSString *brandName;       // OEM brand name
@property NSString *brandModel;      // Model name
@property NSNumber *brandResultBench; // Benchmark score
@property NSNumber *brandResultTiles; // Tiles score
@property NSString *brandVMware;     // VMware version
@property NSString *vmmarkVersion;   // VMmark version
@property NSNumber *totalHosts;      // Number of hosts
@property NSNumber *totalSockets;    // CPU sockets
@property NSNumber *totalCores;      // CPU cores
@property NSNumber *totalThreads;    // CPU threads
@property NSNumber *matchedPair;     // Matched pair flag
@property NSNumber *uniformHosts;    // Uniform hosts flag
@property NSString *date;            // Benchmark date
```

## Application Flow

1. **Launch** → `VMAppDelegate` customizes navigation/tab bar appearance
2. **Storyboard loads** → `VMTabBarController` as root
3. **Tab 1 (OEM):**
   - `VMListOEMViewController` → Lists unique OEM brands
   - Tap brand → `VMListOEMCompleteViewController` → All results for that OEM
   - Tap result → `VMListOEMDetailsViewController` → Full specifications
4. **Tab 2 (Pairs):**
   - `VMListPairViewController` → Paired system comparisons
5. **Help Tab:**
   - `VMVMMarkHelpViewController` → App information

## Framework Dependencies

| Framework | Usage |
|-----------|-------|
| UIKit | UI components (views, controllers, tables) |
| Foundation | Core data types, networking, serialization |
| QuartzCore | Layer manipulation, UI effects |

**No external libraries** - Pure iOS framework usage.

## Common Tasks

### Adding a New View Controller
1. Create `VM<Name>ViewController.h/m` files
2. Add to appropriate storyboard
3. Connect segues and IBOutlets
4. Implement `UITableViewDataSource`/`UITableViewDelegate` if table-based

### Modifying Data Model
1. Edit `VMMarksResults.h` - add property
2. Edit `VMMarksResults.m` - add to `initWithCoder:` and `encodeWithCoder:`
3. Update data controller and CSV parser if needed

### Adding Network Requests
```objc
[WebRequest requestPath:@"http://example.com/data"
           onCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
    if (!error && data) {
        // Process data
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update UI on main thread
        });
    }
}];
```

## Known Considerations

### Legacy Code Notes
- Uses `NSURLConnection` (deprecated - modern iOS uses `NSURLSession`)
- HTTP URL (not HTTPS)
- Minimal error handling
- iOS 4.3 deployment target is very old

### Potential Improvements
- Migrate to `NSURLSession` for networking
- Add HTTPS support
- Implement proper error handling and user feedback
- Add unit tests
- Update deployment target to modern iOS
- Consider Swift migration for new features

## Image Assets

The project includes 40+ PNG images:
- **UI Chrome:** Navigation bar, tab bar, buttons, backgrounds
- **Brand Logos:** Intel, Dell, Fujitsu, Huawei, etc.
- **Icons:** Performance indicators, refresh, grouping
- **Launch Screens:** Default.png, Default@2x.png, Default-568h@2x.png

## Git Workflow

### Current Branch
Development should occur on feature branches. The initial commit is `90fdd3f`.

### Commit Messages
Use clear, descriptive commit messages:
```
feat: Add new benchmark comparison feature
fix: Correct CSV parsing for special characters
docs: Update CLAUDE.md with new endpoints
```

## Quick Reference

### File Locations
- **App Delegate:** `VMMark/VMAppDelegate.m`
- **Data Models:** `VMMark/VMMarksResults*.m`
- **Network Layer:** `VMMark/WebRequest.m`
- **CSV Parser:** `VMMark/utl_csvParser.m`
- **Main Views:** `VMMark/VMList*ViewController.m`

### Key URLs
- Data endpoint: `http://www.vmware.com/a/vmmark/1/?csv=1`

### Cache Location
- `~/Documents/results.dat` (NSKeyedArchiver format)
