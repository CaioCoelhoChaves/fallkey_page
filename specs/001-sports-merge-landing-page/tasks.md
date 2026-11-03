# Tasks: Página de Divulgação do Sports Merge

**Input**: Design documents from `specs/001-sports-merge-landing-page/` (`spec.md`, `plan.md`, `data-model.md`, `contracts/sports-merge-ui-contract.md`, `research.md`, `quickstart.md`)  
**Prerequisites**: plan.md (required), spec.md (required), data-model.md, contracts/  
**Feature Branch**: `feat/FAL-67-sports-merge-landing-page`  
**Linear Card**: FAL-67  

## Format: `- [ ] [TaskID] [P?] [Story?] Description with file path`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., [US1], [US2], [US3], [US4])
- Clear, actionable description with exact file path

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization, asset registration, and shared configuration

- [X] T001 Register `url_launcher: ^6.3.0` dependency and `assets/sports_merge/` asset paths in `pubspec.yaml`
- [X] T002 [P] Sync and configure icon, poster, and store badge assets in `assets/sports_merge/`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core data models, bilingual profile catalogs, base page routing, and shared components that all user stories depend on

⚠️ **CRITICAL**: No user story work can begin until this foundational phase is complete

- [X] T003 [P] Create domain entities (`GamePresentation` with id non-null slug 'sports-merge' name non-empty 'Sports Merge' packageName reverse domain 'com.fallkey.sports_merge', `LocalizationProfile` with languageCode 'pt' or 'en' and 3 to 5 features, `StoreDestination` with platform StorePlatform url String? badgeAssetPath and isAvailable bool, `ShowcaseMedia` with posterAssetPath and screenshots, `FeatureHighlight`) and bilingual catalog in `lib/pages/sports_merge/models/sports_merge_content.dart`
- [X] T004 [P] Unit tests for bilingual content catalog integrity, fallback resolution, and store URLs in `test/pages/sports_merge/sports_merge_content_test.dart`
- [X] T005 Register `/sports-merge` route with query parameter `lang` handling and path URL strategy in `lib/main.dart`
- [X] T006 Create base stateful page structure and scaffold in `lib/pages/sports_merge/sports_merge_page.dart`
- [X] T007 [P] Implement reusable store badge button widget with semantics and focus feedback in `lib/pages/sports_merge/widgets/components/store_badge_button.dart`
- [X] T008 [P] Implement footer section with copyright and links to `/sports-merge/privacy` and `/sports-merge/support` in `lib/pages/sports_merge/widgets/sections/sports_merge_footer_section.dart`

**Checkpoint**: Foundation ready - data models, routing, and base shared components are fully functional and tested.

---

## Phase 3: User Story 1 - Descobrir o jogo e baixar na Google Play Store (Priority: P1) 🎯 MVP

**Goal**: Deliver a compelling marketing landing page with Hero branding, gameplay media showcase, feature highlights, and a functional Google Play Store download button.

**Independent Test**: Navigate to `/sports-merge`, verify that Hero title, gameplay poster, and Google Play Store badge are visible, and click the Google Play badge to confirm external redirect to `https://play.google.com/store/apps/details?id=com.fallkey.sports_merge`.

### Tests for User Story 1

- [X] T009 [P] [US1] Widget test verifying Hero section rendering and Google Play Store link redirection in `test/pages/sports_merge/sports_merge_page_test.dart`

### Implementation for User Story 1

- [X] T010 [P] [US1] Implement Hero section displaying game logo, title, slogan, and primary CTA buttons in `lib/pages/sports_merge/widgets/sections/sports_merge_hero_section.dart`
- [X] T011 [P] [US1] Implement Media Showcase section displaying static poster fallback image in < 1.5s and gameplay screenshots in `lib/pages/sports_merge/widgets/sections/sports_merge_media_section.dart`
- [X] T012 [P] [US1] Implement Features highlights section displaying gameplay selling points in `lib/pages/sports_merge/widgets/sections/sports_merge_features_section.dart`
- [X] T013 [US1] Implement Store Badges section invoking `url_launcher` for Google Play Store URL (`https://play.google.com/store/apps/details?id=com.fallkey.sports_merge`) in `lib/pages/sports_merge/widgets/sections/sports_merge_store_badges_section.dart`
- [X] T014 [US1] Integrate Hero, Media, Features, and Store Badges sections into `lib/pages/sports_merge/sports_merge_page.dart`

**Checkpoint**: User Story 1 is completely testable and functional as the standalone MVP.

---

## Phase 4: User Story 2 - Alternar idioma entre Português e Inglês (Priority: P2)

**Goal**: Provide instantaneous bilingual support (PT/EN) across all page copy, with interactive language toggle and deep linking via `?lang=pt` or `?lang=en`.

**Independent Test**: Click language toggle between PT and EN to verify immediate text updates (< 100ms) without page reloading; access `/sports-merge?lang=en` and verify initial render in English.

### Tests for User Story 2

- [X] T015 [P] [US2] Widget test for language selector toggle and deep link query param resolution in `test/pages/sports_merge/sports_merge_page_test.dart`

### Implementation for User Story 2

- [X] T016 [P] [US2] Implement language toggle `SegmentedButton` (`PT` / `EN`) in `lib/pages/sports_merge/widgets/components/language_selector.dart`
- [X] T017 [US2] Integrate language toggle and URL query synchronization with `GoRouter` in `lib/pages/sports_merge/sports_merge_page.dart`

**Checkpoint**: User Stories 1 and 2 work independently with full bilingual support.

---

## Phase 5: User Story 3 - Visualizar a página com experiência adaptada em dispositivos móveis e computadores (Priority: P3)

**Goal**: Ensure responsive layout adaptation across mobile (< 600px), tablet (600px - 1024px), and desktop (>= 1024px, max-width 1200px) viewports with zero horizontal scrolling.

**Independent Test**: Resize browser viewport between 360px and 2560px, verifying single-column stacked elements on mobile and two-column balanced layout on desktop without horizontal overflow.

### Tests for User Story 3

- [X] T018 [P] [US3] Responsive layout widget tests simulating mobile (360x640) and desktop (1920x1080) viewports in `test/pages/sports_merge/sports_merge_page_test.dart`

### Implementation for User Story 3

- [X] T019 [US3] Implement responsive container structure with `LayoutBuilder` and `ConstrainedBox` (`maxWidth: 1200px`) in `lib/pages/sports_merge/sports_merge_page.dart`
- [X] T020 [P] [US3] Adapt touch targets (min 48px height) and full-width stacked buttons for mobile viewports in `lib/pages/sports_merge/widgets/sections/sports_merge_hero_section.dart` and `lib/pages/sports_merge/widgets/sections/sports_merge_store_badges_section.dart`

**Checkpoint**: User Stories 1, 2, and 3 are fully responsive and visually validated.

---

## Phase 6: User Story 4 - Visualizar disponibilidade e redirecionamento para Apple App Store (Priority: P4)

**Goal**: Support Apple App Store badge presentation with clear "Coming soon" informational feedback and future external link readiness.

**Independent Test**: Click Apple App Store button to verify dark-themed floating SnackBar informing "Disponível em breve na App Store / Coming soon to App Store" without 404 or broken page.

### Tests for User Story 4

- [X] T021 [P] [US4] Widget test verifying Apple App Store button interaction and "Coming soon" notice in `test/pages/sports_merge/sports_merge_page_test.dart`

### Implementation for User Story 4

- [X] T022 [US4] Implement Apple App Store badge handling with SnackBar feedback and configurable URL readiness in `lib/pages/sports_merge/widgets/sections/sports_merge_store_badges_section.dart`

**Checkpoint**: All user stories (US1 through US4) are fully functional and integrated.

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Accessibility verification, end-to-end suite validation, and execution against the quickstart guide

- [X] T023 [P] Audit WCAG 2.1 AA accessibility (Semantics, contrast ratio, keyboard focus rings) in `lib/pages/sports_merge/sports_merge_page.dart`
- [X] T024 Run complete test suite via `flutter test test/pages/sports_merge/`
- [X] T025 Execute end-to-end quickstart validation scenarios according to `specs/001-sports-merge-landing-page/quickstart.md`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - Phase 3 (US1 - MVP): First deliverable increment
  - Phase 4 (US2): Can proceed after Foundational
  - Phase 5 (US3): Can proceed after Foundational
  - Phase 6 (US4): Can proceed after Foundational
- **Polish (Final Phase)**: Depends on all user stories being implemented

### User Story Dependencies

- **User Story 1 (P1)**: Foundational phase complete. Delivers core MVP.
- **User Story 2 (P2)**: Integrates language toggle with existing sections.
- **User Story 3 (P3)**: Enhances responsive containers of sections created in US1.
- **User Story 4 (P4)**: Adds Apple Store state handling to the Store Badges section created in US1.

### Parallel Opportunities

- **Setup**: T001 and T002 can run in parallel.
- **Foundational**: T003, T004, T007, and T008 can be developed in parallel.
- **User Story 1**: T009 (test), T010 (Hero), T011 (Media), and T012 (Features) can be developed in parallel.
- **User Story 2**: T015 (test) and T016 (Language selector component) can run in parallel.
- **User Story 3**: T018 (test) and T020 (touch targets) can run in parallel.
- **User Story 4**: T021 (test) can run in parallel with earlier preparations.
- **Polish**: T023 can run in parallel with test suite verification.

---

## Parallel Example: User Story 1

```bash
# Launch test and individual section components in parallel:
Task: "Widget test verifying Hero section rendering in test/pages/sports_merge/sports_merge_page_test.dart"
Task: "Implement Hero section in lib/pages/sports_merge/widgets/sections/sports_merge_hero_section.dart"
Task: "Implement Media Showcase section in lib/pages/sports_merge/widgets/sections/sports_merge_media_section.dart"
Task: "Implement Features highlights section in lib/pages/sports_merge/widgets/sections/sports_merge_features_section.dart"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup (`pubspec.yaml`, assets)
2. Complete Phase 2: Foundational (`sports_merge_content.dart`, routing, base page, store badge button, footer)
3. Complete Phase 3: User Story 1 (Hero, Media showcase, Features, Google Play Store badge)
4. **STOP and VALIDATE**: Run `flutter test test/pages/sports_merge/` and verify `/sports-merge` in Chrome
5. Deliver/demonstrate MVP increment

### Incremental Delivery

1. Setup + Foundational -> Foundation ready and verified
2. User Story 1 (MVP) -> Play Store conversion functional
3. User Story 2 -> Instantaneous bilingual toggle (PT/EN)
4. User Story 3 -> Mobile, tablet, desktop responsive layout
5. User Story 4 -> Apple App Store presence and "Coming soon" notice
6. Polish -> WCAG accessibility audit, full test suite pass, quickstart verification
