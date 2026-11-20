# Eddie's portfolio site

## What this is
A one-page portfolio for Eddie Kuoha IV, a mechanical engineering student at UH Manoa going for space robotics internships (JPL, space robotics startups). People land here from a cold email or an application. They give it about 30 seconds, so projects come first.

## Design (keep it consistent)
- Concept: an engineering drawing set. Each project is a "sheet" with a title block (Role / Date / Tools), like a real mechanical drawing.
- Colors are defined as CSS variables at the top of index.html. Only one accent: --kapton (flight-hardware gold). Don't add new colors.
- Font: Archivo only. Wide width (wdth 118-125) for headings, normal for body. Don't add a second font.
- Left aligned. No ALL-CAPS labels, no numbered 01/02/03 markers, no fade-in on every section, no emoji.
- Writing: plain, first person, sounds like Eddie. No em dashes. No buzzwords.

## Honesty rules (important)
- PETAL had THREE subsystems: Deployment, Power, Sustainability. Never write "11 subsystems" (that was an error; 11 is the number of NASA/industry judges at Cocoa Beach).
- RASC-AL: "finalist" / "1 of 14 teams from 150+". Never "semifinalist".
- UW REU LabVIEW-to-Python port was AI-assisted (Claude Code). Never claim he wrote it all himself.
- Machine shop: manual tools only (mills, bandsaws, drill presses, sanders). No CNC.
- Python is basic.
- ME 213: Eddie was lead systems engineer and designed the tri-spoke wheels + FEA. He did NOT own the build; he assisted across every subsystem, mostly guiding less-experienced teammates. The pneumatic grabber was a teammate's, not his.

## Media
- Each project has a folder: assets/projects/<id>/ (folder name must match the project id exactly, no spaces). Drop RAW photos/videos in there (any size, any format, HEIC is fine). Claude compresses them into assets/projects/<id>/web/ and wires them into the detail page.
- Self-serve specs if doing it by hand: JPG/PNG ~1500px long edge, under ~450 KB; convert HEIC to JPG; video as H.264 .mp4 under ~2 MB (or YouTube unlisted).
- Projects live in the PROJECTS array at the bottom of index.html. To add media to a project, add entries to its `media:[]` (type img or video, src, cap).
- VIDEO SIZING: always give a video item `w` and `h` (its real display pixel dimensions). The player box is sized from that aspect ratio, so there are no black bars. Portrait clips (h>w) render in one grid column; landscape clips span full width. Check rotation metadata before trusting ffprobe: `ffprobe -show_streams | grep -E "^(width|height)=|rotation"`. A phone video can report 1920x1080 with rotation=-90, which displays as portrait. Re-encoding with ffmpeg bakes the rotation in, so read w/h from the ENCODED file.
- VIDEO QUALITY: encode quality-first, not fixed low bitrate. Current recipe: scale to 720 on the long edge, libx264 -crf 23 preset medium, +faststart, aac 96k. For long clips add -maxrate/-bufsize to cap size (quackhacks demo used -crf 25 -maxrate 2600k). This is a big step up from the old ~230-620k fixed-bitrate encodes that looked soft. Clips land 4-16 MB; fine since videos use preload=none + a poster. To add a cover thumbnail, set `cover:{src,alt}`.
- To add a whole new project: append an object to PROJECTS (id, title, role, date, team, tools, over, lede, body, cover, media) and make assets/projects/<id>/ .
- Resume: assets/Kuoha_Edward_Resume.pdf (hero button links there). 2-page PDF, gs-compressed /ebook from 2.5 MB to ~310 KB with no visible quality loss. Compress new versions the same way.

## Run it
- `node serve.mjs` then open http://localhost:3000
- Deploy: push to GitHub, import the repo in Vercel (Hobby plan, free). No build step needed; it's static.

## Documents and 3D models (per project)
- PDFs (papers, PDR, proposal, a slide deck exported to PDF) are NOT embedded inline. They go in the project's `docs:[]` array in index.html and render as a "Documents" block of download links. Host the file in assets/projects/<id>/web/ (so git tracks it). Keep each under ~10 MB; compress big ones with ghostscript (-dPDFSETTINGS=/ebook) or link Google Drive instead.
- Slideshows: convert .pptx to PDF (soffice --headless --convert-to pdf), compress, link in docs. Don't ship the .pptx.
- 3D models: drop a .glb (preferred) or .stl of the part in the project folder. A `{type:"model", src, cap}` item in that project's media renders a draggable model-viewer. STL converts to GLB on the Linux side; export GLB straight from SolidWorks if it offers it.

## Update 2026-11-20 (live site)
- LIVE at eddiekuoha.com (GitHub -> Vercel, auto-deploys on git push). Repo root = eddie-portfolio. Workflow: edit, `git add .`, `git commit`, `git push`.
- WARNING: around 2026-11-19 a OneDrive sync rolled back files written into this folder (the About-photo removal and these notes both got undone). After writing files here, check `git status` / grep that the change actually stuck before telling Eddie it's done.
- Page order is now hero -> Projects -> About (with the Seattle action shot, about-eddie.jpg, which Eddie wants kept but LOW on the page) -> Contact. Projects must stay as high as possible.
- Nav: About, Contact, and a dark 'Projects' button (.nav-cta) top right.
- Mobile: header name nowrap; under 880px the hero photo becomes a small 132px square above the name so projects come up fast; section heads stack under 560px.
- URC project card removed (paused until Eddie does real work on it; his role is mostly manufacturing). Experience line kept.
- uw-reu has a Documents block (poster.pdf, litreview.pdf) plus presenting.jpg and uw-building.jpg. WRITEUP-PROMPTS.txt files sit in each project folder (gitignored).
- /connect (connect/index.html): NFC-card landing page. Portfolio button, 'Save my contact' (eddie-kuoha.vcf, no phone number unless Eddie asks), LinkedIn, Instagram + TikTok (@eddiestinksatengineering), email, resume. Duolingo row is commented out until he gives the profile URL. vercel.json sets text/vcard on the .vcf. NFC card should point to https://eddiekuoha.com/connect.
- Analytics: Vercel Web Analytics script tag in index.html and connect/index.html. Eddie must click Enable in the Vercel dashboard (Analytics tab). Free on Hobby (50k events/mo, 1-month window). /connect page views ~= card taps. No public visitor counter or map on the site (decided against).
- Copy now matches resume v40: hero lede 'building robot hardware for extreme-terrain mobility and planetary exploration'; PETAL adds 15 kWe reactor, MIT/Texas A&M/Michigan, 11 judges; QuackHacks team = AlphaTuring; UW adds gas-handling line + the failed-run diagnosis (not enough carbon -> raised methane ratio).
- PENDING XRD (Eddie to add to uw-reu/): photo of sample in the XRD, raw XRD data (to plot), software peak-match figures.
- FUTURE CARDS (from resume v40, add when Eddie says):
  - Drew Research Lab, UH Manoa, undergrad researcher, Oct 2026-present: designing and fabricating mounts that integrate a Trossen WidowX AI arm, Lighthouse IR positioning hardware, and Crazyflie 2.1 Brushless drones onto a Unitree Go2 quadruped. Helped get a drone flying alongside the Go2 while it walks; the arm will stow and redeploy the drones, working toward arm-assisted launch and in-flight recapture (marsupial robot system).
  - URC AstroBio payload mechanical engineer, Team RoSE, Sep 2026-present: manufacturing and design for a rover payload that collects field samples and runs basic tests for signs of microbial life; cleared internal PDR, moving into fabrication.

## Update 2026-11-15
- Hero now has a photo: assets/hero.jpg (from eddiek.jpg headshot), in a bordered 4:5 frame with gold corner ticks (.ph-frame). Placeholder removed. Second candidate (givingaspeechatanairport.jpg, landscape action shot at a forum) is unused, could go in a gallery later.
- uw-reu is fully built: cover = furnace-rig.jpg; gallery = synthesis.mp4 (3-min reel, him weighing precursors, 720x1280, 33MB), sample-boat.jpg, powder.jpg, furnace-rig.jpg, gas-manifold.jpg, poster.jpg (span, from magnumopus.JPG), lab-forum.jpg. Body gained an honest bullet about the LabVIEW->Python port (discloses heavy AI assistance, per honesty rule).
- me213: added grabber.mp4 (competition run, robot climbs + grabber gets the egg). Native 360x640 phone footage (source 1000051241.mp4/.mov), can't go higher res. Caption describes the robot's action, not authorship (grabber was a teammate's).
- PETAL docs: 'Proposal' renamed to 'Proposal paper'.
- PENDING for uw-reu docs: Eddie mentioned a lit-review presentation and a poster PDF (Eddie-finalfinalfinal) but neither is in the uw-reu folder yet (OneDrive not synced). When they land, compress and add to a docs:[] block (poster PDF + presentation), like PETAL.

## Current status (2026-11-11, updated evening)
Site = data-driven single page (index.html, PROJECTS array at bottom). Home shows overview cards that lift on hover; each opens a detail view at #p/<id> with a gallery, lightbox, Documents block, prev/next nav. Deploy: push to GitHub, import in Vercel (static, no build). Raw media is gitignored; only assets/projects/<id>/web/ ships.
- DONE: ME213, PETAL, QuackHacks, and gold-charm.
- gold-charm: title is "Valorant Gold Rank Keychain" (clearer than "charm"; copy still calls it a charm later, which Eddie is fine with). Printed on a Prusa MK4 (NOT a Prusa MMU), and the Area 01 FabLab mention was dropped per Eddie. Cover is final-charm.jpg, the clear finished-keychain shot (small 481px source but reads fine at card size).
- PETAL gallery now opens with berm-diagram.png (labeled reactor-under-berm cross-section) paired next to the thermal sim figure.jpg.
- ME213 cover is wheel-in-hand.jpg (the team-working/repairs photo), not the stair-climb video frame.
- About/mini-resume: dropped the machine-shop certified line; added "Undergraduate researcher, Dr. Drew's lab at UH Manoa" and "Payload engineer, University Rover Challenge (Team RoSE)".
- All gallery videos re-encoded at higher quality (see VIDEO QUALITY above). New resume installed and compressed.
- 3D: wheel.glb and charm.glb embedded via model-viewer (jsdelivr CDN, loaded only when a project has a model item). IMPORTANT: style a WRAPPER div (`.mv-box`), not the model-viewer element itself. Once the library loads, model-viewer overrides borders/sizing set directly on it, so the border vanishes. Current setup: figure `fig-model span` (full width), inner `.mv-box` carries the 1.5px ink border + white bg + explicit height (500px desktop, 380px mobile), model-viewer fills it at width/height 100%. Needs the explicit height; aspect-ratio alone does not give model-viewer a height.
- Folders renamed to match ids: "gold charm" -> gold-charm, "uw research fellowship" -> uw-reu.
- PENDING media: urc-astrobio and uw-reu both show the "Photos coming" placeholder.
  - urc-astrobio needs CAD screenshots, parts list, or hardware photos.
  - uw-reu copy is written and live; Eddie said he has the conference poster, lab/sample photos, and XRD figures to drop in assets/projects/uw-reu/. Poster goes to docs:[] as a PDF plus a poster image; XRD figures work well as tall:true.
- QuackHacks demo video keeps its burned-in captions. Eddie's call, decided 2026-11-11.
- Videos are self-hosted small mp4 (no YouTube/Drive needed).
- About copy + hero are still placeholder-ish; Eddie to rewrite About in his voice.
