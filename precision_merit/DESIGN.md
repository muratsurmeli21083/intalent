---
name: Precision Merit
colors:
  surface: '#f7f9fb'
  surface-dim: '#d8dadc'
  surface-bright: '#f7f9fb'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f4f6'
  surface-container: '#eceef0'
  surface-container-high: '#e6e8ea'
  surface-container-highest: '#e0e3e5'
  on-surface: '#191c1e'
  on-surface-variant: '#434656'
  inverse-surface: '#2d3133'
  inverse-on-surface: '#eff1f3'
  outline: '#737688'
  outline-variant: '#c3c5d9'
  surface-tint: '#004ced'
  primary: '#003ec7'
  on-primary: '#ffffff'
  primary-container: '#0052ff'
  on-primary-container: '#dfe3ff'
  inverse-primary: '#b7c4ff'
  secondary: '#515f78'
  on-secondary: '#ffffff'
  secondary-container: '#d2e0fe'
  on-secondary-container: '#55637d'
  tertiary: '#005949'
  on-tertiary: '#ffffff'
  tertiary-container: '#00745f'
  on-tertiary-container: '#62fed9'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#dde1ff'
  primary-fixed-dim: '#b7c4ff'
  on-primary-fixed: '#001452'
  on-primary-fixed-variant: '#0038b6'
  secondary-fixed: '#d6e3ff'
  secondary-fixed-dim: '#b9c7e4'
  on-secondary-fixed: '#0d1c32'
  on-secondary-fixed-variant: '#39475f'
  tertiary-fixed: '#5ffbd6'
  tertiary-fixed-dim: '#38debb'
  on-tertiary-fixed: '#002019'
  on-tertiary-fixed-variant: '#005142'
  background: '#f7f9fb'
  on-background: '#191c1e'
  surface-variant: '#e0e3e5'
typography:
  display-xl:
    fontFamily: Inter
    fontSize: 48px
    fontWeight: '700'
    lineHeight: '1.1'
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: '1.2'
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: '1.3'
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: '1.6'
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.5'
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: '1.5'
  label-bold:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: '1.0'
    letterSpacing: 0.05em
  numeric-data:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '500'
    lineHeight: '1.0'
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  base: 8px
  xs: 4px
  sm: 12px
  md: 24px
  lg: 48px
  xl: 80px
  gutter: 24px
  margin-mobile: 16px
  margin-desktop: 40px
---

## Brand & Style

This design system is built on the core principle of "Merit through Precision." The brand personality is authoritative yet innovative—acting as a bridge between high-level human talent and data-driven verification. The visual direction follows a **Corporate Modern** aesthetic infused with subtle **Glassmorphism** to reflect a "tech-forward" transparency.

The UI should evoke a sense of absolute reliability and intelligence. It moves away from generic recruitment tropes, opting instead for a high-utility, sophisticated interface that treats candidate data as high-value assets. Users should feel they are entering a "lab" environment where skills are quantified and matched with surgical accuracy.

## Colors

The palette is anchored by **Deep Navy (#0A192F)** to establish institutional trust and "Liyakat" (merit-based authority). This is contrasted by **Vibrant Electric Blue (#0052FF)**, used exclusively for primary actions and technical highlights, signaling a tech-first approach.

Subtle grey accents (Slate 50-200) are utilized to create the "Bento Grid" structures without cluttering the visual field. For the 'Merit Lab' data visualizations, a tertiary teal/cyan is used sparingly to represent successful data correlations. Clean whites provide the necessary breathing room for high-density dashboards.

## Typography

The typography system utilizes **Inter** for its exceptional legibility in data-heavy environments. The hierarchy is strictly enforced to ensure the HR dashboard remains scannable. 

Headline styles use tighter letter-spacing and heavier weights to feel "engineered" and impactful. For the 'Merit Lab' and data components, tabular numbers (`tnum`) must be enabled to ensure that vertical alignment in lists and charts remains perfectly consistent. Labels use a slightly tracked-out, uppercase style to differentiate metadata from primary content.

## Layout & Spacing

This design system employs a **12-column fluid grid** for the HR dashboard and a **flexible column-drop system** for mobile. The rhythmic spacing is based on an 8px square grid to maintain mathematical harmony across dense data sets.

The 'Merit Lab' utilizes a **Bento Grid** layout model, where various data "widgets" (Radar Charts, Skill Distributions, Career Velocity) are grouped into distinct, card-like containers with consistent 24px gutters. This allows high-density information to be parsed quickly by recruiters without causing cognitive overload.

## Elevation & Depth

Depth is used sparingly and purposefully to indicate hierarchy. The system moves away from heavy shadows in favor of **Tonal Layers** and **Low-contrast Outlines**.

1.  **Surface Level (Canvas):** Pure white or ultra-light grey (#F8FAFC).
2.  **Container Level (Bento Cards):** White background with a 1px border (#E2E8F0) and a very soft, ambient shadow (y: 2, blur: 4, 2% opacity).
3.  **Active/Hover State:** Elements elevate slightly with a subtle Electric Blue glow or a semi-transparent "glass" overlay when positioned over data visualizations.
4.  **Floating Elements (Modals/Popovers):** Use a medium-diffusion shadow with a 4% Navy tint to create a sense of being physically above the dashboard.

## Shapes

The shape language is **Soft (0.25rem - 0.75rem)**. This provides a professional balance; it is modern and approachable without being overly "bubbly" or consumer-grade.

- **Standard UI elements (Buttons, Inputs):** 4px (0.25rem) for a crisp, technical feel.
- **Data Cards & Bento Blocks:** 8px (0.5rem) to provide a soft container for complex data.
- **Avatars & Status Indicators:** Circular (Full) to contrast against the predominantly rectangular grid.
- **Charts:** Radar charts and line graphs should use slightly rounded nodes to maintain the tech-forward aesthetic.

## Components

### Buttons & Inputs
Buttons utilize a solid Electric Blue for primary actions, while secondary actions use a ghost-style navy outline. Input fields are minimalist—using a 1px bottom border or a very subtle background fill—turning into a crisp Electric Blue focus ring when active.

### Merit Lab & Charts
The 'Merit Lab' components are the system's centerpiece. Radar charts use thin-stroke lines with semi-transparent area fills in Electric Blue. These should be interactive, allowing recruiters to hover over specific "merit points" for detailed metric breakdowns.

### Lists & Tables
HR dashboards feature high-density tables with "sticky" headers. Row heights are optimized at 48px with clear divider lines. Every list item includes a "Merit Score" badge—a small, pill-shaped component with a subtle gradient background.

### Mobile Experience
The mobile interface transitions to an **Action-Oriented** view. Long tables are converted into swipeable "Candidate Cards." Navigation is handled via a thin-stroke bottom bar, prioritizing "Search," "Matches," and "Messages."

### Icons
Icons must be **2px thin-stroke**, modern, and geometric. They should never be filled unless in an "active" state. Use a specialized set for "Merit Categories" (e.g., a compass for Leadership, a microchip for Technical Skill).