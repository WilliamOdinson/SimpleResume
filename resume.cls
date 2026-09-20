\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[Simple Resume]

% -------------------------------------
% Define options
% -------------------------------------
\newif\if@defaultstyle
\@defaultstyletrue

% Publications support (loads biblatex when enabled)
\newif\if@publications
\def\@bibstyle{apa}

\DeclareOption{default}{\@defaultstyletrue}
\DeclareOption{publications}{\@publicationstrue}
\DeclareOption{apa}{\def\@bibstyle{apa}}
\DeclareOption{ieee}{\def\@bibstyle{ieee}}
\DeclareOption{mla}{\def\@bibstyle{mla}}
\DeclareOption{chicago}{\def\@bibstyle{chicago-authordate}}
\DeclareOption{numeric}{\def\@bibstyle{numeric}}
\DeclareOption{alphabetic}{\def\@bibstyle{alphabetic}}
\DeclareOption*{}

\ProcessOptions\relax

% Load base class
\LoadClass[letterpaper,11pt]{article}

% -------------------------------------
% Required Packages
% -------------------------------------
\RequirePackage[english]{babel}
\RequirePackage[empty]{fullpage}
\RequirePackage{enumitem}
\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}
\RequirePackage{fontawesome5}
\RequirePackage{fontspec}
\RequirePackage{forarray}
\RequirePackage[left=0.3in,right=0.3in,top=0.3in,bottom=0.3in,footskip=13.6pt]{geometry}
\RequirePackage{hyperref}
\RequirePackage{multicol}
\RequirePackage{svg}
\RequirePackage{tabularx}
\RequirePackage{titlesec}
\RequirePackage{xcolor}
\RequirePackage{graphicx}

% -------------------------------------
% Publications (biblatex, conditional)
% -------------------------------------
\if@publications
  % Expand \@bibstyle into the options string before loading
  \begingroup\edef\x{\endgroup
    \noexpand\RequirePackage[%
      style=\@bibstyle,
      backend=biber,
      sorting=ydnt,
      defernumbers=true,
      maxbibnames=99%
    ]{biblatex}%
  }\x

  % -- Name bolding --------------------------------------------------
  \def\@boldfirst{}
  \def\@boldlast{}

  % \boldname{Firstname}{Lastname}
  \newcommand{\boldname}[2]{%
    \def\@boldfirst{#1}%
    \def\@boldlast{#2}%
  }

  % Patch family-name formatting: bold when last name matches
  \renewcommand*{\mkbibnamefamily}[1]{%
    \ifdefempty{\@boldlast}{#1}{%
      \ifdefstrequal{\namepartfamily}{\@boldlast}{\textbf{#1}}{#1}%
    }%
  }

  % Patch given-name formatting: bold when last name matches (same entry)
  \renewcommand*{\mkbibnamegiven}[1]{%
    \ifdefempty{\@boldlast}{#1}{%
      \ifdefstrequal{\namepartfamily}{\@boldlast}{\textbf{#1}}{#1}%
    }%
  }

  % Patch prefix/suffix similarly
  \renewcommand*{\mkbibnameprefix}[1]{%
    \ifdefempty{\@boldlast}{#1}{%
      \ifdefstrequal{\namepartfamily}{\@boldlast}{\textbf{#1}}{#1}%
    }%
  }
  \renewcommand*{\mkbibnamesuffix}[1]{%
    \ifdefempty{\@boldlast}{#1}{%
      \ifdefstrequal{\namepartfamily}{\@boldlast}{\textbf{#1}}{#1}%
    }%
  }

  % -- Bibliography environment matching resume style -----------------
  \defbibenvironment{resume}{%
    \list{}{%
      \setlength{\leftmargin}{0pt}%
      \setlength{\rightmargin}{0pt}%
      \setlength{\itemindent}{0pt}%
      \setlength{\itemsep}{4pt}%
      \setlength{\parsep}{0pt}%
      \setlength{\topsep}{0pt}%
    }%
  }{\endlist}{\item\small}

  % -- Render commands ------------------------------------------------
  % \renderPublications          -> all bib entries
  % \renderPublications[journal] -> entries with keywords = {journal}
  \newcommand{\renderPublications}[1][]{%
    \nocite{*}%
    \ifblank{#1}{%
      \printbibliography[heading=none,env=resume]%
    }{%
      \printbibliography[heading=none,env=resume,keyword={#1}]%
    }%
  }
\fi

% -------------------------------------
% Font Options
% -------------------------------------
% sans-serif (fontspec)
% \setmainfont{Fira Sans}
% \setmainfont{Roboto}
% \setmainfont{Noto Sans}

% serif (fontspec)
% \setmainfont{XCharter}
% \setmainfont{TeX Gyre Termes}
\setmainfont{Libertinus Serif}

% -------------------------------------
% Hyperlink Global Setup
% -------------------------------------

\hypersetup{
    colorlinks=false,
    pdfborder={0 0 0},
}

% -------------------------------------
% Page Setup
% -------------------------------------
\pagestyle{fancy}
\fancyhf{}
\fancyfoot{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\setlength{\tabcolsep}{0in}
\setlength{\multicolsep}{-3.0pt}
\setlength{\columnsep}{-1pt}
\urlstyle{same}

\titleformat{\section}{
  \vspace{-4pt}\raggedright\large\bfseries
}{}{0em}{}[\color{black}\titlerule \vspace{-5pt}]

\RequirePackage{iftex}
\ifpdftex
  \input{glyphtounicode}
  \pdfgentounicode=1
\fi
\raggedbottom
\raggedright

\renewcommand\labelitemi{$\vcenter{\hbox{\tiny$\bullet$}}$}
\renewcommand\labelitemii{$\vcenter{\hbox{\tiny$\bullet$}}$}

% -------------------------------------
% Environments
% -------------------------------------
\newenvironment{resumeSection}{
  \begin{itemize}[leftmargin=0.0in, label={}]
}{
  \end{itemize}
}

\newenvironment{highlights}{
  \begin{itemize}[leftmargin=10pt, itemsep=4pt, parsep=0pt, topsep=4pt, partopsep=0pt, label=\raisebox{0.5ex}{\scalebox{0.5}{$\bullet$}}]
}{
  \end{itemize}\vspace{-5pt}
}

\newcommand{\resumeItem}[1]{
  \item\small{{#1 \vspace{-2pt}}}
}

% -------------------------------------
% Title Section Block
% -------------------------------------
\newif\if@firstcontact

\newcommand{\addcontact}[1]{%
  \if@firstcontact
    \def\@contactitems{#1}%
    \@firstcontactfalse
  \else
    \appto\@contactitems{\hfill #1}%
  \fi
}

\newcommand{\titlesection}{
\begingroup
\begin{center}
    {\Huge \firstname\
    \ifdefined\preferredname
    {(\preferredname)}
    \fi
    \lastname
    }\\
    \vspace{2pt}
    \ifdefined\position
        {\small\textit{Applying For: \position}}\\
    \fi
    \vspace{2pt}
    \small
    \@firstcontacttrue
    \def\@contactitems{}%
    \ifdefined\phone
      \addcontact{\raisebox{-0.1\height}\faPhone\ \phone}%
    \fi
    \ifdefined\email
      \addcontact{\href{mailto:\email}{\raisebox{-0.1\height}\faEnvelope\ \email}}%
    \fi
    \ifdefined\linkedin
      \addcontact{\href{https://\linkedin}{\raisebox{-0.1\height}\faLinkedin\ \linkedin}}%
    \fi
    \ifdefined\github
      \addcontact{\href{https://\github}{\raisebox{-0\height}\faGithub\ \github}}%
    \fi
    \makebox[0.95\textwidth][s]{\@contactitems}\\
    \ifdefined\address
        \href{https://www.google.com/maps/search/?api=1&query=\address}{\raisebox{-0\height}\faMapMarker\ \address}
    \fi
    \vspace{-8pt}
\end{center}
\endgroup
}

% -------------------------------------
% Data Definitions
% -------------------------------------
\newcommand{\Education}[9]{
  \DefineArrayVar{#1}{@}
  {|}{Start|End|University|Location|Degree|Concentration|GPA|Highlights}
  {|}{{#2}|{#3}|{#4}|{#5}|{#6}|{#7}|{#8}|{#9}}
}

\newcommand{\Experience}[7]{
  \DefineArrayVar{#1}{@}
  {|}{Start|End|Company|Position|Location|Highlights}
  {|}{{#2}|{#3}|{#4}|{#5}|{#6}|{#7}}
}

% -------------------------------------
% Content Renderers
% -------------------------------------
\newif\if@hasHighlights
\def\@emptyfield{{}}

\newcommand{\renderEducation}[1]{%
  \expandafter\let\expandafter\@tempa\csname #1@Highlights\endcsname%
  \ifx\@tempa\@emptyfield\@hasHighlightsfalse\else\@hasHighlightstrue\fi%
  \vspace{-2pt}\item
    \begin{tabular*}{1.0\textwidth}[t]{l@{\extracolsep{\fill}}r}
      \textbf{\csname #1@University\endcsname} & {\small \csname #1@Location\endcsname} \\
      {\small\csname #1@Degree\endcsname, \csname #1@Concentration\endcsname. \csname #1@GPA\endcsname} & {\small \csname #1@Start\endcsname~--~\csname #1@End\endcsname}
      \if@hasHighlights
        \\ {\small\csname #1@Highlights\endcsname}
      \fi
    \end{tabular*}\vspace{-7pt}
}

\newcommand{\renderExperience}[1]{
  \vspace{-2pt}\item
    \begin{tabular*}{1.0\textwidth}[t]{l@{\extracolsep{\fill}}r}
      \textbf{\csname #1@Company\endcsname} & {\small \csname #1@Location\endcsname} \\
      {\small\csname #1@Position\endcsname} & {\small \csname #1@Start\endcsname~--~\csname #1@End\endcsname} \\
    \end{tabular*}\vspace{-10pt}
  \csname #1@Highlights\endcsname
}

\newcommand{\renderProject}[1]{
  \vspace{-2pt}\item
    \begin{tabular*}{1.0\textwidth}[t]{l@{\extracolsep{\fill}}r}
      \textbf{\csname #1@Company\endcsname} {\small(\csname #1@Start\endcsname~--~\csname #1@End\endcsname)} & {\small\csname #1@Position\endcsname}
    \end{tabular*}\vspace{-20pt}
  \csname #1@Highlights\endcsname
}

% -------------------------------------
% Utility
% -------------------------------------
\newcommand{\describe}[2]{
  \csname #1@#2\endcsname
}

\newcommand{\link}[2]{%
  \ifblank{#1}{%
    \underline{\vphantom{p}#2}%
  }{%
    \href{#1}{%
      \textcolor[RGB]{0, 0, 0}{%
        \underline{\vphantom{p}#2%
        ~{\includesvg[height=0.7em,inkscapelatex=false]{assets/link}}
        }%
      }%
    }%
  }%
}

\newcommand{\updated}[1]{%
  \fancyfoot{}
  \fancyfoot[R]{
    \hspace*{-0.1cm}
    \raisebox{0.1cm}{\textcolor{gray}{\scriptsize\itshape Last updated: #1}}
  }
}

\newcommand{\latestversion}{%
  \fancyfoot{}
  \fancyfoot[R]{
    \hspace*{-0.1cm}
    \raisebox{0.1cm}{\textcolor{gray}{\scriptsize\itshape Latest version:
      \href{https://wsun.io/resume.pdf}{\underline{wsun.io/resume.pdf}}}}
  }
}

\def\sett#1#2#3{\expandafter\def\csname#1#2\endcsname{#3}}
