# KindleForge 🔠

> [!NOTE]
> Do Not Attempt To Use KindleForge At This Point! It Is Under Development.

## What's This?

KindleForge Is A Persistent Appstore For Kindles Based On IllusionUtild.

It Is Inspired By KPM.

## How Does It Work?

- KindleForge Is Based On Illusion - It's A WAF (Essentially, A Web App)
- Apps Grabbed From `REGISTRY.JSON` And Loaded
- Uninstall/Install Determined From A Local `PACKAGES.LIST`
- When You Add/Remove A Package, The Relevant Script Is Run (Through [UTILD](https://github.com/KindleModding/utild))
- Installation Success Is Determined By Polling - Checking Every 500Ms If The App Was Added/Removed From `PACKAGES.LIST`.
- Nothing? Fail After 30s - Assumed Premature Exit
- (This Is Because There Is No Mesquite `lipc-get-prop` Equivalent. Only Events - Which Utild Doesn't Implement).

## Can I Get It?

Yes, Although Expect Styling/Scaling or UI Issues. The Functionality Of The App Should Be Complete, Only Maybe Registry Issues.

1. Ensure You Are On The Latest Universal Hotfix (Scriptlets). JB Support Out Of WinterBreak For Illusion Is Not Guaranteed.
2. Get `KindleForge/` And KindleForge.sh
3. Put Them Into Your `documents/` Folder
4. Run The Scriptlet! (You May Have To Tap/Double Tap)


## Contributions

- PLEASE Contribute To The Registry! It Would Be *Greatly* Appreciated.
- Also, CSS & Scaling. It Is, In Fact, A Big Issue In Mesquite.

## Notes

- Tested Fully & Working On A PW3
- Made By Penguins184
- Big Thanks To KPM!
