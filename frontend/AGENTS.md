# Frontend Codebase Documentation

## Overview

The frontend is a production-quality Next.js Kanban board application. It implements a full-featured drag-and-drop interface with column and card management, built with modern React patterns and comprehensive test coverage.

**Status:** Complete and standalone (not yet integrated with backend)

## Architecture

### Component Structure

```
src/
├── components/
│   ├── KanbanBoard.tsx        # Main orchestrator component (state management)
│   ├── KanbanColumn.tsx       # Individual column with drag support
│   ├── KanbanCard.tsx         # Individual card (draggable)
│   ├── KanbanCardPreview.tsx  # Drag preview component
│   └── NewCardForm.tsx        # Form for adding new cards
├── lib/
│   └── kanban.ts             # Business logic and data structures
├── pages/
│   ├── _app.tsx              # App wrapper
│   └── index.tsx             # Main Kanban board page
└── tests/                    # All test files
```

### Data Structures (kanban.ts)

**Core Types:**
```typescript
interface Card {
  id: string
  columnId: string
  title: string
  details: string
}

interface Column {
  id: string
  name: string
  cards: Card[]
}

interface BoardData {
  columns: Column[]
}
```

**Helper Functions:**
- `moveCard(board, cardId, fromColumnId, toColumnId, fromIndex, toIndex)` - Move card between columns
- `createId()` - Generate unique IDs
- `initialData` - Sample board data with 5 columns and 8 cards

### State Management

**Current Approach:** React hooks (useState) for in-memory state
- No persistence (data lost on page refresh)
- Single board in memory
- No user context yet

**Future:** Will be replaced with backend API calls in Part 7

### UI Components

**KanbanBoard.tsx:**
- Main orchestrator managing board state
- Passes state and handlers to columns
- Uses `<DndContext>` from dnd-kit for drag-and-drop
- Renders 5 columns with card grid

**KanbanColumn.tsx:**
- Renders individual column with editable title
- Handles column name inline editing
- Displays card count
- Uses `<SortableContext>` for card drag-and-drop
- Renders NewCardForm for adding cards

**KanbanCard.tsx:**
- Displays individual card with title and details
- Uses `useSortable()` hook from dnd-kit
- Shows drag handles and delete button
- Styling with Tailwind and custom CSS

**NewCardForm.tsx:**
- Form with title and details inputs
- Validation (title required)
- Collapse/expand animation
- Send button submits new card

## Technology Stack

### Core Dependencies
- **Next.js 16.1.6** - React framework with app router
- **React 19.2.3** - UI library with latest hooks
- **TypeScript 5** - Strict type checking enabled
- **Tailwind CSS 4** - Utility-first styling with PostCSS 4

### Drag and Drop
- **dnd-kit 6.3.1** - Modern, headless drag-and-drop
- **@dnd-kit/sortable** - Sortable component abstraction
- **@dnd-kit/utilities** - Utility functions
- **@dnd-kit/core** - Core drag-and-drop logic

### Styling & Fonts
- **clsx** - Conditional class name utility
- **Google Fonts** - Space Grotesk (display), Manrope (body)
- **CSS Variables** - Custom color system in Tailwind config

### Testing
- **Vitest 3.2.4** - Fast unit test runner
- **React Testing Library 16.3.2** - Component testing utilities
- **jest-dom** - Custom matchers for DOM assertions
- **Playwright 1.58.0** - E2E testing

### Development Tools
- **npm** - Package manager (package-lock.json committed)
- **ESLint** - Code quality (Next.js + TypeScript rules)
- **Prettier** - Code formatting (auto-configured by Next.js)

## Color Scheme

Used consistently throughout the UI:
- **Accent Yellow:** #ecad0a - highlights, accents
- **Primary Blue:** #209dd7 - links, key UI elements
- **Secondary Purple:** #753991 - buttons, actions
- **Dark Navy:** #032147 - headings, dark text
- **Gray Text:** #888888 - labels, supporting text
- **Surface Colors:** light/dark variants for backgrounds

Defined as Tailwind CSS custom colors in `tailwind.config.js`

## Features

### Implemented
- ✅ 5-column Kanban board (Backlog, Discovery, In Progress, Review, Done)
- ✅ Drag-and-drop cards between columns
- ✅ Drag-and-drop to reorder within columns
- ✅ Column title inline editing (click to edit)
- ✅ Create new cards (title + details)
- ✅ Delete cards (with confirmation)
- ✅ Collision detection during drag
- ✅ Visual feedback (drag preview, hover states)
- ✅ Responsive layout
- ✅ Accessibility support (keyboard navigation in development)

### Not Yet Implemented
- ❌ Backend persistence (all state in-memory)
- ❌ Multi-user support
- ❌ User authentication
- ❌ Multiple boards per user
- ❌ Card editing after creation
- ❌ AI integration
- ❌ Real-time sync with other users
- ❌ Search/filtering

## Testing Infrastructure

### Unit Tests (Vitest)

**Location:** `src/**/*.test.ts` and `src/**/*.test.tsx`

**Test Files:**
- `KanbanBoard.test.tsx` - Board component rendering and state
- `kanban.test.ts` - Helper functions and utilities

**Coverage:** Run with `npm run test:unit:watch` for watch mode

**Config:**
- Environment: jsdom (browser-like)
- Globals enabled (describe, it, expect)
- Coverage enabled (v8)

### E2E Tests (Playwright)

**Location:** `e2e/kanban.spec.ts`

**Test Scenarios:**
1. Load page and verify Kanban board displays
2. Create a new card and verify it appears
3. Drag card between columns and verify it moves

**Run:** `npm run test:e2e` (requires dev server running at localhost:3000)

**Config:**
- Base URL: http://localhost:3000
- Browsers: chromium, firefox, webkit
- Headed mode available with `--headed` flag

### Test Commands

```bash
npm run test:unit          # Run all unit tests once
npm run test:unit:watch   # Watch mode for development
npm run test:e2e          # Run E2E tests (requires dev server)
npm run test:all          # Run unit + E2E tests
npm run test:coverage     # Generate coverage report (HTML + terminal)
```

## Build & Development Setup

### Development Server

```bash
npm install    # Install dependencies
npm run dev    # Start development server
# Open http://localhost:3000 in browser
```

Hot reload enabled by default. Changes reflect immediately in browser.

### Production Build

```bash
npm run build   # Build Next.js app (outputs to .next/)
npm run start   # Start production server
# Server listens on port 3000
```

### Build Artifacts

- **Development:** `.next/` directory with compiled code
- **Production Export:** `out/` directory with static HTML (when using `next export`)
- **ESLint:** Run with `npm run lint` to check code quality

## Project Structure

```
frontend/
├── public/               # Static assets (fonts, images)
├── src/
│   ├── app/
│   │   ├── globals.css   # Global styles
│   │   ├── layout.tsx    # Root layout
│   │   └── page.tsx      # Home page
│   ├── components/       # React components (see above)
│   ├── lib/              # Utilities and data logic
│   └── styles/           # Additional CSS
├── e2e/                  # Playwright tests
├── .next/               # Build output (gitignored)
├── node_modules/        # Dependencies (gitignored)
├── next.config.js       # Next.js configuration
├── tailwind.config.js   # Tailwind CSS configuration
├── tsconfig.json        # TypeScript configuration
├── package.json         # Dependencies and scripts
├── package-lock.json    # Locked dependency versions
├── vitest.config.ts     # Vitest configuration
├── playwright.config.ts # Playwright configuration
└── AGENTS.md            # This file
```

## Code Quality

### TypeScript
- Strict mode enabled
- No `any` types (except where necessary)
- Interfaces for all data structures
- Proper event type annotations

### Component Patterns
- Functional components with hooks (no class components)
- Proper prop typing with interfaces
- Custom hooks for reusable logic
- No unnecessary re-renders (optimized with proper dependencies)

### Styling
- Utility-first Tailwind CSS (no custom CSS where possible)
- CSS-in-JS only where necessary (e.g., animations)
- Consistent spacing scale from Tailwind
- Color scheme strictly adhered to

### Testing
- Components tested with React Testing Library (not implementation details)
- E2E tests focus on user workflows
- Good test coverage for critical paths
- Tests are maintainable and descriptive

## Known Limitations

1. **No Persistence:** All board state is lost on page refresh (will be fixed in Part 7)
2. **No Backend:** Entirely client-side (will be fixed in Part 2-3)
3. **No Authentication:** No user login (will be added in Part 4)
4. **Single Board:** Can't manage multiple projects (MVP constraint)
5. **No Search/Filter:** All cards always visible (could be added later)
6. **No Card Editing:** Can only create/delete cards, not edit them (could be added later)
7. **No Real-time Sync:** No WebSocket or polling (for future collaboration)

## Integration Points (Future)

### Part 3: Static Build Integration
- Frontend needs to build as static assets for serving from FastAPI backend
- Ensure no dynamic rendering or API routes are used
- Output must be compatible with `StaticFiles` middleware

### Part 4: Authentication
- Add login/logout pages
- Add context provider for authenticated user
- Add token storage and retrieval
- Protect Kanban route

### Part 7: Backend API Integration
- Replace `initialData` with API calls
- Replace state handlers with API calls
- Add error handling and retry logic
- Add loading states and skeletons

### Part 10: AI Chat Integration
- Add ChatSidebar component
- Integrate useChat hook
- Handle AI operations (create/move/delete cards)
- Add real-time board updates

## Development Guidelines

1. **Keep it simple** - No over-engineering, prefer inline code to abstractions
2. **Use Tailwind** - Don't write custom CSS unless absolutely necessary
3. **Type everything** - Leverage TypeScript for safety
4. **Test critical paths** - Focus on user workflows, not implementation details
5. **No defensive programming** - Trust the data and framework
6. **Follow conventions** - Component names PascalCase, files match component names
7. **Keep components focused** - Single responsibility principle

## Debugging

### Browser DevTools
- React Developer Tools extension recommended
- Console will show drag-and-drop collision info
- Network tab shows no API calls (all in-memory)

### Common Issues

**Drag-and-drop not working:**
- Check dnd-kit version matches package.json
- Verify DndContext is wrapping all draggable components
- Check browser console for errors

**Styling not applying:**
- Verify Tailwind class names are exact (no typos)
- Check color variables are defined in tailwind.config.js
- Rebuild CSS if needed: `npm run build`

**Tests failing:**
- Ensure dev server running for E2E tests: `npm run dev`
- Check node version matches engines in package.json
- Clear node_modules and reinstall: `rm -rf node_modules && npm install`

## Next Steps

See the comprehensive implementation plan in `/docs/PLAN.md` for the full 10-part roadmap. This frontend serves as the foundation for Parts 2-10.

**Immediate next steps:**
1. ✅ Part 1: Document frontend (this file)
2. Part 2: Create Docker and FastAPI backend boilerplate
3. Part 3: Build frontend statically and serve from backend
4. Part 4: Add user authentication
5. And so on...
