# KindleForge 🔠

> [!IMPORTANT]
> This edition of KindleForge (2) is now **discontinued** in favour of a KPM (Kindle Package Manager)-Based one to be bundled with UJ (The next jailbreak). Feel free to use this, as it should work, but this repository may be moved to my personal account (polish-penguin-dev) at any time in favour of the new project. Thanks for the help!

## What’s this?

KindleForge is a persistent app store for Kindles based on IllusionUtild.

It is inspired by KPM.

![KindleForge UI example](https://github.com/user-attachments/assets/9cce14c7-6f16-49d6-aafc-7dbc4b685bb3)

## How does it work?

- KindleForge is based on Illusion – it’s a WAF (essentially, a web app).  
- Apps are grabbed from `REGISTRY.JSON` and loaded.  
- Uninstall/install is determined from a local `PACKAGES.LIST`.  
- When you add or remove a package, the relevant script is run (through [Utild](https://github.com/KindleModding/utild)).  
- Installation success is determined by polling – checking every 500 ms if the app was added or removed from `PACKAGES.LIST`.  
- If nothing changes within 30 s, the operation fails (assumed premature exit).  
- (This is because there is no Mesquite `lipc-get-prop` equivalent; only events, which Utild doesn’t implement.)

## Can I get it?

Yes, although expect styling, scaling, or UI issues. The functionality of the app should be complete; only registry entries may be missing.

1. Ensure you are on the latest Universal Hotfix (scriptlets). Jailbreak support out of WinterBreak for Illusion is not guaranteed.  
2. Get the `KindleForge/` folder and the `KindleForge.sh` script.  
3. Put them into your `documents/` folder.  
4. Run the scriptlet! (You may have to tap or double-tap.)

## Contributions

- Please contribute to the registry! It would be *greatly* appreciated.  
- CSS and scaling help is also needed—these remain significant issues on Mesquite.

## Contributors

- Kurizu ([Crizmo](https://github.com/crizmo/))  
- Gingr ([Gingrspacecadet](https://github.com/gingrspacecadet))

## Notes

- Tested fully and working on a PW3 and PW6.  
- Made by Penguins184.  
- Big thanks to KPM!
