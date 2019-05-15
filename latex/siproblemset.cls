% Introduction
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{siproblemset}[2019/05/19 Class for typesetting SI math problem worksheets]

% Setup

% Options

% Load the primary class
\LoadClass[letter,11pt]{article}

% Load required packages
\RequirePackage[left=1in,right=1in,bottom=1in,top=0.75in]{geometry}
\RequirePackage[absolute]{textpos}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{ifthen}
\RequirePackage{amsmath}
\RequirePackage{zalwaysdisplaystyle}
\RequirePackage{zmathshortcuts}
\RequirePackage{zquestions}

% Page number setup
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\AtBeginDocument{\ifthenelse{\pageref{LastPage}>1}{\cfoot{Page \thepage\ of \pageref{LastPage}}}{}}

% Declarations
%% Session Box
\newcommand{\course}[1]{%
    \providecommand{\@displaysessionbox}{}%
    \@ifundefined{@course}%
    {\newcommand{\@course}{#1}}%
    {\ClassError{siproblemset}{Only one course can be specified.}{Remove the extra course definition(s).}}%
}
\newcommand{\sessionnum}[1]{%
    \providecommand{\@displaysessionbox}{}%
    \@ifundefined{@sessionnum}%
    {\newcommand{\@sessionnum}{#1}}%
    {\ClassError{siproblemset}{Only one session number can be specified.}{Remove the extra session number definitions.}}%
}
\newcommand{\sessiondate}[1]{%
    \providecommand{\@displaysessionbox}{}%
    \@ifundefined{@sessiondate}%
    {\newcommand{\@sessiondate}{#1}}%
    {\ClassError{siproblemset}{Only one session date can be specified.}{Remove the extra session date definition(s).}}%
}
\newcommand{\@makesessionbox}{%
    \@ifundefined{@course}{\ClassError{siproblemset}{Please specify a course.}{Use \\course{<course>} to specify a course.}}{}%
    \@ifundefined{@sessionnum}{\ClassError{siproblemset}{Please specify a session number.}{Use \\sessionnum{<num>} to specify a session number.}}{}%
    \@ifundefined{@sessiondate}{\ClassError{siproblemset}{Please specify a session date.}{Use \\sessiondate{<date>} to specify a session date.}}{}%
    \begin{textblock*}{1in}(1in,0.75in)
        \mbox{\parbox{1in}{%
            \@course\ SI\par%
            Session \#\@sessionnum\par%
            \@sessiondate
        }}
    \end{textblock*}
}

%% Topics Box
\newcommand{\@topics}{}
\newcounter{topic}
\newcommand{\warmup}[1]{\providecommand{\@displaytopics}{}\edef\@topics{\@topics\hangindent=0.5cm Warmup: #1\par}}
\newcommand{\cooldown}[1]{\providecommand{\@displaytopics}{}\edef\@topics{\@topics\hangindent=0.5cm Cooldown: #1\par}}
\newcommand{\topic}[1]{\stepcounter{topic}\providecommand{\@displaytopics}{}\edef\@topics{\@topics\hangindent=0.5cm Topic \#\thetopic: #1\par}}
\newcommand{\@maketopicsbox}{%
    \footnotesize
    \begin{textblock*}{2.1in}(6in,0.25in)
        \fbox{\parbox{2.1in}{%
            \centering\textbf{Topics Covered Today}\par%
            \raggedright\@topics
        }}
    \end{textblock*}\normalsize
}

%% Title
\newcommand{\@withnamespace}{}
\newcommand{\withnamespace}[1][5cm]{\expandafter\def\expandafter\@withnamespace\expandafter{\@withnamespace \vspace{2mm}Name: \underline{\hspace{#1}}\par}}
\newcommand{\sections}[1]{%
    \@ifundefined{@reviewsection}%
    {\newcommand{\@reviewsection}{#1}}%
    {\ClassError{siproblemset}{Only one review section set can be specified.}{Remove the extra review section sets.}}%
}
\renewcommand{\maketitle}{%
    \begin{center}
        {\LARGE\@title}\par%
        \@ifundefined{@reviewsection}{\ \par}{(\@reviewsection)\par}%
        \@withnamespace
    \end{center}%
    \@ifundefined{@displaysessionbox}{}{\@makesessionbox}%
    \@ifundefined{@displaytopics}{}{\@maketopicsbox}%
    \TPoptions{absolute=false}
}