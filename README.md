A simple, clean LaTeX résumé template.

## Overview

<p align="center">
  <picture>
    <img src="https://github.com/WilliamOdinson/SimpleResume/releases/latest/download/default.png"
         alt="Preview of the default template">
  </picture>
</p>

> Download <a href="https://github.com/WilliamOdinson/SimpleResume/releases/latest">PDF</a> from latest release

- **main.tex**
  The primary file where sections such as *Education*, *Experience*, *Leadership & Activities*, and *Notable GitHub Projects* are orchestrated.

- **personal.tex**
  This file holds most of the user-specific details (name, contact info, summary, and definitions for each education/work experience). **You will edit this file the most** to tailor the résumé to your information.

- **resume.cls**
  A custom LaTeX class that styles the résumé. It handles margins, fonts, spacing, and other layout configurations.

## How to Use

1. **Clone or Download** the repository.
2. Open the project in [Overleaf](https://www.overleaf.com/) or another LaTeX environment of your choice.
3. Update the following files to customize your résumé:
   - **personal.tex**: Change `\firstname`, `\lastname`, `\email`, `\linkedin`, and `\github` to your details. Update the `\Education`, `\Experience`, and `\Project` blocks with your own information.
   - **main.tex**: Organize, add, or remove résumé sections as needed.
4. Compile `main.tex` to generate your PDF résumé.
