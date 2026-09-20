---
name: resume-guide
description: How to use the SimpleResume template and all configurable parameters
user_invocable: true
---

# SimpleResume Template Guide

## Configurable Parameters

### 1. Contact / Header Fields (personal.tex)

All defined with `\def`. Comment out any line to hide that field from the header.

| Field             | Example                              | Notes                                      |
|-------------------|--------------------------------------|--------------------------------------------|
| `\firstname`      | `{John}`                             | Required                                   |
| `\lastname`       | `{Doe}`                              | Required                                   |
| `\preferredname`  | `{John}`                             | Optional; shown in parentheses after first name |
| `\position`       | `{Software Development Engineer}`    | Optional; renders as "Applying For: ..." by default. The label can be changed in resume.cls (e.g. to show availability dates instead) |
| `\phone`          | `{+1 (xxx) xxx-xxxx}`               | Optional                                   |
| `\email`          | `{you@example.com}`                  | Optional; rendered as mailto link          |
| `\linkedin`       | `{linkedin.com/in/username}`         | Optional; do NOT include `https://`        |
| `\github`         | `{github.com/username}`              | Optional; do NOT include `https://`        |
| `\address`        | `{City, State, ZIP}`                 | Optional; links to Google Maps             |

### 2. Profile Summary (personal.tex + main.tex)

Define in personal.tex:
```latex
\def\profileSummary{
    \section{Career Summary}
    Your summary text here.
}
```

Toggle in main.tex by commenting/uncommenting `\profileSummary`.

### 3. Footer (main.tex)

Two mutually exclusive options (use one or neither):

- `\updated{\today}` displays "Last updated: YYYY-MM-DD" in bottom-right
- `\latestversion` displays "Latest version: wsun.io/resume.pdf" in bottom-right (edit URL in resume.cls)

Comment out both lines to hide the footer.

### 4. Education Entries (personal.tex)

```latex
\Education{Key}
{Start}{End}{University}{Location}
{Degree}
{Concentration}{GPA}
{Highlights}
```

- **Key**: unique identifier, referenced by `\renderEducation{Key}` in main.tex
- **Concentration, GPA, Highlights**: pass `{}` to omit; Highlights renders as a third row when non-empty

### 5. Experience Entries (personal.tex)

```latex
\Experience{Key}
{Start}
{End}
{Company}
{Position}
{Location}
{
    \begin{highlights}
        \resumeItem{Bullet point here.}
    \end{highlights}
}
```

- **Key**: unique identifier, referenced by `\renderExperience{Key}` or `\renderProject{Key}` in main.tex
- **Start/End**: free-form text (e.g. "May 2026", "Present", "2024")
- **Highlights**: a `highlights` environment containing `\resumeItem{}` entries

Two rendering modes share the same `\Experience` data definition:

| Renderer            | Layout                                                                          |
|---------------------|---------------------------------------------------------------------------------|
| `\renderExperience` | Two-line header: **Company** (right: Location) / Position (right: Start -- End), then bullets |
| `\renderProject`    | One-line header: **Company** (Start -- End) (right: Position), then bullets. No location row |

### 6. Sections (main.tex)

Sections are plain `\section{Title}` blocks. Reorder, rename, add, or remove freely. Wrap entries in `\begin{resumeSection}...\end{resumeSection}`.

Comment out a `\renderExperience{Key}` or `\renderEducation{Key}` line to hide that entry without deleting its data.

### 7. Publications (personal.tex + main.tex + references.bib)

Requires the `publications` class option. Entries come from a `.bib` file processed by biblatex + biber.

**Enable publications** in main.tex:
```latex
\documentclass[default,publications,apa]{resume}
```

**Citation style** is set via a class option. Available styles:

| Option        | Style                          |
|---------------|--------------------------------|
| `apa`         | APA 7th edition (default)      |
| `ieee`        | IEEE                           |
| `mla`         | MLA                            |
| `chicago`     | Chicago author-date            |
| `numeric`     | Numbered `[1], [2], ...`       |
| `alphabetic`  | Label-based `[Doe24], ...`     |

**Add your .bib file** in personal.tex (inside the `\makeatletter` / `\makeatother` block):
```latex
\makeatletter
\if@publications
  \boldname{John}{Doe}              % bolds your name in all entries
  \addbibresource{references.bib}   % path to your .bib file
\fi
\makeatother
```

**`\boldname{Firstname}{Lastname}`** patches biblatex name formatting to auto-bold all name parts (given, family, prefix, suffix) for any author whose family name matches. Matching is on family name only, so `J. Doe` and `John Doe` both bold correctly.

**Render in main.tex:**
```latex
\section{Publications}
\begin{resumeSection}
    \item
    \renderPublications              % all entries
\end{resumeSection}
```

**Filter by keyword** using the optional argument and `keywords` field in bib entries:
```latex
\section{Publications}
\begin{resumeSection}
    \item
    \subsection*{\normalsize Journal Articles}\renderPublications[journal]
    \subsection*{\normalsize Conference Papers}\renderPublications[conference]
    \subsection*{\normalsize Preprints}\renderPublications[preprint]
\end{resumeSection}
```

Corresponding bib entry:
```bibtex
@article{doe2024,
  author   = {Doe, John and Smith, Alice},
  title    = {Paper Title},
  journal  = {Journal Name},
  year     = {2024},
  keywords = {journal},
}
```

Entries are sorted newest-first (`sorting=ydnt`). All entries from the `.bib` file are included automatically (via `\nocite{*}`); you do not need to `\cite` them.

**Disable publications** by removing the `publications` option from `\documentclass`. The `\if@publications` guards in personal.tex and main.tex ensure nothing breaks.

### 8. Skills Section (main.tex)

Not a special command; use a plain itemize:
```latex
\section{Skills}
\begin{itemize}[itemsep=2pt, parsep=0pt, topsep=2pt, partopsep=0pt, leftmargin=0.0in, label={}]
    \item \textbf{Category}: item1, item2, item3
\end{itemize}
```

### 9. Hyperlinks

```latex
\link{https://example.com}{Display Text}   % underlined text with external-link icon
```

### 10. Font (resume.cls)

Default: `libertinus` (serif). Switch by commenting/uncommenting in the "Font Options" block:

**Serif**: CormorantGaramond, charter, mathptmx, libertinus

**Sans-serif**: FiraSans, roboto, noto-sans, sourcesanspro

## Build

Requires LuaLaTeX and Inkscape (for SVG rendering). If `publications` option is enabled, also requires biber (biblatex backend). `latexmk` runs biber automatically when needed.

```bash
make          # produces resume.pdf (configured via OUT variable in Makefile)
make clean    # remove all build artifacts
```

## Fitting to One Page

If the resume overflows to a second page:

1. **Trim content**: keep only the entries most relevant to the target role; comment out the rest in main.tex.
2. **Switch fonts**: some fonts are more compact than others. Libertinus is already one of the more space-efficient serif options.
3. **Adjust margins**: tighten the page geometry in resume.cls:
   ```latex
   \RequirePackage[left=0.3in,right=0.3in,top=0.3in,bottom=0.3in,footskip=13.6pt]{geometry}
   ```
