\ProvidesClass{arzg}
\NeedsTeXFormat{LaTeX2e}

\RequirePackage{xkeyval}
\RequirePackage{xifthen}
\newboolean{@arzg@twocolumn}\setboolean{@arzg@twocolumn}{false}
\DeclareOptionX[arzg]<common>{twocolumn}{\setboolean{@arzg@twocolumn}{true}}
\newboolean{@arzg@doublespace}\setboolean{@arzg@doublespace}{false}
\DeclareOptionX[arzg]<common>{doublespace}{\setboolean{@arzg@doublespace}{true}}
\newboolean{@arzg@bibliography}\setboolean{@arzg@bibliography}{false}
\DeclareOptionX[arzg]<common>{bibliography}{\setboolean{@arzg@bibliography}{true}}
\newboolean{@arzg@darkmode}\setboolean{@arzg@darkmode}{false}
\DeclareOptionX[arzg]<common>{darkmode}{\setboolean{@arzg@darkmode}{true}}
\ProcessOptionsX*[arzg]<common>

\ifthenelse{\boolean{@arzg@twocolumn}}{
      \PassOptionsToClass{twocolumn}{memoir}
}{}

\LoadClass[a4paper, oneside]{memoir}

\RequirePackage{amsmath}
\allowdisplaybreaks % allow page breaks in display math

\RequirePackage[version=4]{mhchem}
\RequirePackage[final]{graphicx}

\RequirePackage[
    % use math font when typesetting in math
    % and use text font when in text
    mode=match,
    % appear as italic when in an italic context
    reset-text-shape=false,
    % separate digit groups with comma
    group-separator={,},
    % show digit group separator with four digits (e.g. 1,000)
    group-minimum-digits=4,
    % J/kg/°C instead of J kg⁻¹ °C⁻¹
    per-mode=repeated-symbol,
]{siunitx}
\DeclareSIUnit{\atm}{atm}

\RequirePackage[final, tracking=true, letterspace=100]{microtype}
\frenchspacing

\ifthenelse{\boolean{@arzg@twocolumn}}{
    \renewcommand{\Large}{\@setfontsize\Large{15bp}{19bp}}
    \renewcommand{\large}{\@setfontsize\large{12bp}{15bp}}
    \newcommand{\slightlylarger}{\@setfontsize\slightlylarger{11bp}{13bp}}
    \renewcommand{\normalsize}{\@setfontsize\normalsize{10bp}{13bp}}
    \renewcommand{\small}{\@setfontsize\small{8bp}{10bp}}
}{
    \ifthenelse{\boolean{@arzg@doublespace}}{
        \renewcommand{\Large}{\@setfontsize\Large{18bp}{36bp}}
        \renewcommand{\large}{\@setfontsize\large{14bp}{28bp}}
        \newcommand{\slightlylarger}{\@setfontsize\slightlylarger{13bp}{26bp}}
        \renewcommand{\normalsize}{\@setfontsize\normalsize{12bp}{24bp}}
        \renewcommand{\small}{\@setfontsize\small{10bp}{20bp}}
    }{
        \renewcommand{\Large}{\@setfontsize\Large{18bp}{22bp}}
        \renewcommand{\large}{\@setfontsize\large{14bp}{18bp}}
        \newcommand{\slightlylarger}{\@setfontsize\slightlylarger{13bp}{16bp}}
        \renewcommand{\normalsize}{\@setfontsize\normalsize{12bp}{16bp}}
        \renewcommand{\small}{\@setfontsize\small{10bp}{13bp}}
    }
}

\normalsize

\newlength{\spaceinc}
\ifthenelse{\boolean{@arzg@doublespace}}{
    \setlength{\spaceinc}{16bp}
}{
    \setlength{\spaceinc}{\baselineskip}
}

\newcommand{\bls}[3]{#1\spaceinc plus #2\spaceinc minus #3\spaceinc}

\setlength{\parindent}{\baselineskip}
\abnormalparskip{0bp}

\RequirePackage[osf, largesc]{newpxtext}
\RequirePackage[osf]{AlegreyaSans}
\RequirePackage[euler-digits]{eulervm}

\RequirePackage{calc}
\newcommand{\optimalline}{Cras dignissim nisi nec dolor blandit, ut varius ex pellentesque. Vestib-}
\newcommand{\optimallinewidth}{\widthof{\optimalline}}

\ifthenelse{\boolean{@arzg@twocolumn}}{
    \settypeblocksize{52\baselineskip}{\optimallinewidth * \real{1.618}}{*}
    \setlength\columnsep{1.5\baselineskip}
}{
    \ifthenelse{\boolean{@arzg@doublespace}}{
        \settypeblocksize{28\baselineskip}{\optimallinewidth}{*}
    }{
        \settypeblocksize{42\baselineskip}{\optimallinewidth}{*}
    }
}
\setlrmargins{*}{*}{1}
\setulmargins{*}{*}{2}

\setheadfoot{\baselineskip}{3\spaceinc}
\makepagestyle{arzg}
\makeevenfoot{arzg}{\normalfont\thepage}{}{}
\makeoddfoot{arzg}{}{}{\normalfont\thepage}
\pagestyle{arzg}

\checkandfixthelayout

\RequirePackage{cuted}
\setlength{\stripsep}{0bp}
\renewcommand{\maketitle}{
    \ifthenelse{\boolean{@arzg@twocolumn}}{
        \begin{strip}
    }{}
        \normalfont\normalsize\noindent
        \vspace{\bls{2}{1}{0.5}}
        {
            \begin{center}
                {\Large\thetitle}\\
                \vspace{\bls{1}{0.5}{0}}
                \theauthor\\
                \thedate
            \end{center}
        }
        \vspace{\bls{2}{1}{0.5}}
        \@afterindentfalse\@afterheading
    \ifthenelse{\boolean{@arzg@twocolumn}}{
        \end{strip}
    }{}
}

\RequirePackage{environ}
\RenewEnviron{abstract}{
    \ifthenelse{\boolean{@arzg@twocolumn}}{
        \section*{Abstract}
        \BODY
    }{
        {
            \small
            \begin{center}
                \begin{minipage}[c]{\optimallinewidth}
                    {
                        \centering
                        \textsc{abstract}\par
                    }
                    \vspace{\bls{0.5}{0.5}{0.5}}
                    \BODY
                \end{minipage}
            \end{center}
        }
        \vspace{\bls{1}{0.5}{0.5}}
        \@afterindentfalse\@afterheading
    }
}

% remove chapter numbers from
% footnotes, sections, tables and figures
\counterwithout{footnote}{chapter}
\counterwithout{section}{chapter}
\counterwithout{table}{chapter}
\counterwithout{figure}{chapter}

% number all document divisions
% up to and including subsubsections
\setsecnumdepth{subsubsection}

\setsecheadstyle{\large}
\setbeforesecskip{\bls{-4}{-1}{0}}
\setaftersecskip{\bls{2}{0.5}{0}}

\setsubsecheadstyle{\slightlylarger\itshape}
\setbeforesecskip{\bls{-3}{-0.5}{0}}
\setaftersecskip{\bls{1.5}{0.5}{0}}

\setsubsubsecheadstyle{\scshape\lowercase}
\setbeforesubsecskip{\bls{-2}{-0.5}{0}}
\setaftersubsecskip{\bls{1}{0.5}{0}}

\captionstyle{\small\itshape}
\captionnamefont{\small\scshape}
\ifthenelse{\NOT \boolean{@arzg@twocolumn}}{
    \newlength{\cw}
    \settowidth{\cw}{\small\itshape\optimalline}
    \captionwidth{\cw}
    \changecaptionwidth
}{}

\RequirePackage[british]{babel}
\RequirePackage{csquotes}

\ifthenelse{\boolean{@arzg@bibliography}}{
    \RequirePackage[
        giveninits=true,
        backref,
        maxcitenames=2,
        maxbibnames=10,
        %
        % still truncate authors
        % even if this would make two sources
        % appear to have the same author
        % when they do not
        uniquelist=false,
        %
        % sort author, year, title
        sorting=nyt,
        sortcites=true,
    ]{biblatex}

    % always put given name before family name
    \DeclareNameAlias{sortname}{given-family}
    \DeclareNameAlias{default}{given-family}

    \addbibresource{References.bib}
    \defbibheading{bibliography}[\bibname]{\section{#1}}
}{}

\RequirePackage{xcolor}
\ifthenelse{\boolean{@arzg@darkmode}}{
    \definecolor{blue}{HTML}{7cc3e8}
    \colorlet{links}{blue}
    \colorlet{computed}{blue}

    \definecolor{bg}{HTML}{222222}
    \definecolor{fg}{HTML}{dddddd}
    \pagecolor{bg}
    \color{fg}
}{
    \definecolor{red}{HTML}{972f00}
    \colorlet{links}{red}
    \colorlet{computed}{red}
}

\RequirePackage[
    final,
    colorlinks=true,
    allcolors=links,
    breaklinks,
]{hyperref}

% sans serif URLs
\urlstyle{sf}

\RequirePackage[noabbrev]{cleveref}

% custom quote environment that allows microtype protrusion
% (quotes often start with an opening quote character,
% which can now be hung in the margin)
\renewenvironment{quote}{
    \par
    \begingroup
    \vspace{\bls{1}{0.25}{0.25}}
    \leftskip=\spaceinc
    \rightskip=\spaceinc
    \noindent
    \ignorespaces
}{
    \vspace{\bls{1}{0.25}{0.25}}
    \par
    \endgroup
    \noindent
    \ignorespacesafterend
}
