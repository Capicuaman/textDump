# Remotion Mastery: Project Plan

**Goal:** To refine our programmatic video generation process, producing high-quality, polished videos for TikTok and other platforms, and to document the process for learning and future reference.

---

## 📋 To-Do

- [ ] **Aesthetics & Design:**
    - [ ] Add custom fonts for brand consistency.
    - [ ] Implement smoother animations using Remotion's `spring()` and `interpolate()` easing functions.
    - [ ] Integrate background images or subtle video loops for more dynamic visuals.
    - [ ] Add a subtle watermark or logo overlay to all videos for branding.

- [ ] **Performance & Workflow:**
    - [ ] Analyze and optimize render performance (investigate component memoization, concurrency settings).
    - [ ] Refactor templates for better reusability and easier customization.
    - [ ] Create a "preview" script that renders a single frame for faster iteration.

- [ ] **Advanced Features:**
    - [ ] Integrate programmatic audio (background music, SFX) based on video type.
    - [ ] Implement dynamic durations based on text length for better pacing.
    - [ ] Explore advanced Remotion features like shaders or `<Composition>` transitions.

- [ ] **Documentation:**
    - [ ] Document all changes and new features in the project's `README.md`.

---

## 🚧 Blocked / Archived

- [ ] **Task:** Fix font loading via CSS import. *(Archived: Switched to `useFont()` hook)*
- [ ] **Task:** Fix `useFont` import and placement. *(Archived: This did not resolve the core bundler issue.)*
- [ ] **Task:** Original project deemed unstable. *(Archived: Rebuilding in new location.)*

---

## ⏳ Doing

- [x] **Project Relocation & Rebuild:** Move the Remotion project to a dedicated location and rebuild from scratch to resolve persistent bundler errors.
    - [ ] Create new parent directory for Remotion projects (e.g., `/home/capicuaman/remotion-projects`). *(Archived: Project will be in Documents)*
    - [x] Move current `video-generation` to `/home/capicuaman/remotion-projects/bilan-videos-old` for archive/reference. *(Completed)*
    - [x] Initialize new `bilan-video` Remotion project in `/home/capicuaman/Documents/bilan-video` *(Manually completed by Ofo using Vite)*
    - [ ] Copy fonts and CSV data to the new project.
    - [ ] Re-implement the styled `QuickTipVideo.tsx` component.
    - [ ] Test render from the new project.

---

## ✅ Done

- [x] **Initial Setup:** Created this Kanban board to track our progress.
- [x] **Analysis:** Analyzed initial `remotion.config.ts` and identified quality gaps.
- [x] **First Batch:** Rendered the initial 10 videos as a baseline.
- [x] **Project Management:** Established `BILAN_STATUS.md` for high-level project tracking.
- [x] **Initial Scaffolding:** Created the core Remotion project structure and templates.
