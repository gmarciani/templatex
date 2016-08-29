%-----------------------------------------------------------------------------
%
%               LaTeX Class/Style File
%
% Name:         MCP-ACM
%
% Purpose:      A LaTeX 2e class file for the Morgan & Claypool Publishers
%               ACM book design. The goal is to have authors' manuscripts
%               look something like the final design.
%
% Author:       Paul C. Anagnostopoulos
%               Windfall Software
%               978 371-2316
%               paul [at] windfall.com
%
% Created:      paul@windfall.com
%
% Revisions:    See end of file.
%
% Copyright (c) 2014 by Morgan & Claypool Publishers
%
%-----------------------------------------------------------------------------


\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{mcp-acm}[2014/03/25 v1.2 M&CP ACM book design]

\usepackage{url}
\urlstyle{rm}

% The following few pages contain LaTeX programming extensions adapted
% from the ZzTeX macro package.

%                       Token Hackery
%                       ----- -------


\def \@expandaftertwice {\expandafter\expandafter\expandafter}
\def \@expandafterthrice {\expandafter\expandafter\expandafter\expandafter
                          \expandafter\expandafter\expandafter}

% This macro discards the next token.

\def \@discardtok #1{}%                                  token

% This macro removes the `pt' following a dimension.

{\catcode `\p = 12 \catcode `\t = 12

\gdef \@remover #1pt{#1}

} % \catcode

% This macro extracts the contents of a macro and returns it as plain text.
% Usage: \expandafter\@defof \meaning\macro\@mark

\def \@defof #1:->#2\@mark{#2}

%                       Control Sequence Names
%                       ------- -------- -----


\def \@name #1{%                                        {\tokens}
  \csname \expandafter\@discardtok \string#1\endcsname}

\def \@withname #1#2{%                                  {\command}{\tokens}
  \expandafter#1\csname \expandafter\@discardtok \string#2\endcsname}

%                       Flags (Booleans)
%                       ----- ----------

% The boolean literals \@true and \@false are appropriate for use with
% the \if command, which tests the codes of the next two characters.

\def \@true {TT}
\def \@false {FL}

\def \@setflag #1=#2{\edef #1{#2}}%              \flag = boolean

%                       IF and Predicates
%                       -- --- ----------

% A "predicate" is a macro that returns \@true or \@false as its value.
% Such values are suitable for use with the \if conditional.  For example:
%
%   \if \@oddp{\x} <then-clause> \else <else-clause> \fi

% A predicate can be used with \@setflag as follows:
%
%   \@setflag \flag = {<predicate>}

% Here are the predicates for TeX's repertoire of conditional
% commands.  These might be more appropriately interspersed with
% other definitions in this module, but what the heck.
% Some additional "obvious" predicates are defined.

\def \@eqlp   #1#2{\ifnum #1 = #2\@true \else \@false \fi}
\def \@neqlp  #1#2{\ifnum #1 = #2\@false \else \@true \fi}
\def \@lssp   #1#2{\ifnum #1 < #2\@true \else \@false \fi}
\def \@gtrp   #1#2{\ifnum #1 > #2\@true \else \@false \fi}
\def \@zerop  #1{\ifnum #1 = 0\@true \else \@false \fi}
\def \@onep   #1{\ifnum #1 = 1\@true \else \@false \fi}
\def \@posp   #1{\ifnum #1 > 0\@true \else \@false \fi}
\def \@negp   #1{\ifnum #1 < 0\@true \else \@false \fi}
\def \@oddp   #1{\ifodd #1\@true \else \@false \fi}
\def \@evenp  #1{\ifodd #1\@false \else \@true \fi}
\def \@rangep #1#2#3{\if \@orp{\@lssp{#1}{#2}}{\@gtrp{#1}{#3}}\@false \else
                                                          \@true \fi}
\def \@tensp  #1{\@rangep{#1}{10}{19}}

\def \@dimeqlp   #1#2{\ifdim #1 = #2\@true \else \@false \fi}
\def \@dimneqlp  #1#2{\ifdim #1 = #2\@false \else \@true \fi}
\def \@dimlssp   #1#2{\ifdim #1 < #2\@true \else \@false \fi}
\def \@dimgtrp   #1#2{\ifdim #1 > #2\@true \else \@false \fi}
\def \@dimzerop  #1{\ifdim #1 = 0pt\@true \else \@false \fi}
\def \@dimposp   #1{\ifdim #1 > 0pt\@true \else \@false \fi}
\def \@dimnegp   #1{\ifdim #1 < 0pt\@true \else \@false \fi}

\def \@vmodep     {\ifvmode \@true \else \@false \fi}
\def \@hmodep     {\ifhmode \@true \else \@false \fi}
\def \@mathmodep  {\ifmmode \@true \else \@false \fi}
\def \@textmodep  {\ifmmode \@false \else \@true \fi}
\def \@innermodep {\ifinner \@true \else \@false \fi}

\long\def \@codeeqlp #1#2{\if #1#2\@true \else \@false \fi}

\long\def \@cateqlp #1#2{\ifcat #1#2\@true \else \@false \fi}

\long\def \@tokeqlp  #1#2{\ifx #1#2\@true \else \@false \fi}
\long\def \@xtokeqlp #1#2{\expandafter\ifx #1#2\@true \else \@false \fi}

\long\def \@definedp #1{%
  \expandafter\ifx \csname \expandafter\@discardtok \string#1\endcsname
                   \relax \@false \else \@true \fi}

\long\def \@undefinedp #1{%
  \expandafter\ifx \csname \expandafter\@discardtok \string#1\endcsname
                   \relax \@true \else \@false \fi}

\def \@emptydefp #1{\ifx #1\@empty \@true \else \@false \fi}%       {\name}

\let \@emptylistp = \@emptydefp

\long\def \@emptyargp #1{%                               {#n}
  \@empargp #1\@empargq\@mark}
\long\def \@empargp #1#2\@mark{%
  \ifx #1\@empargq \@true \else \@false \fi}
\def \@empargq {\@empargq}

\def \@emptytoksp #1{%                                   {\tokenreg}
  \expandafter\@emptoksp \the#1\@mark}

\long\def \@emptoksp #1\@mark{\@emptyargp{#1}}

\def \@voidboxp #1{\ifvoid #1\@true \else \@false \fi}
\def \@hboxp #1{\ifhbox #1\@true \else \@false \fi}
\def \@vboxp #1{\ifvbox #1\@true \else \@false \fi}

\def \@eofp #1{\ifeof #1\@true \else \@false \fi}


% Flags can also be used as predicates, as in:
%
%   \if \flaga <then-clause> \else <else-clause> \fi


% Now here we have predicates for the common logical operators.

\def \@notp #1{\if #1\@false \else \@true \fi}

\def \@andp #1#2{\if #1%
                  \if #2\@true \else \@false \fi
                \else
                  \@false
                \fi}

\def \@orp #1#2{\if #1%
                 \@true
               \else
                 \if #2\@true \else \@false \fi
               \fi}

\def \@xorp #1#2{\if #1%
                  \if #2\@false \else \@true \fi
                \else
                  \if #2\@true \else \@false \fi
                \fi}

\def \stringeql #1#2#3{%                {\return-flag}{string1}{string2}
  \edef \@zstra {#2}%
  \edef \@zstrb {#3}%
  \edef #1{\ifx \@zstra\@zstrb \@true \else \@false \fi}}

%                       Arithmetic
%                       ----------

\def \@increment #1{\advance #1 by 1\relax}%             {\count}

\def \@decrement #1{\advance #1 by -1\relax}%            {\count}

%                       New Expression Evaluation
%                       --- ---------- ----------


% These macros provide a rudimentary expression evaluation facility.
% The accumulator can be a count, dimen, or skip register. The expression
% is in the form {operand0,op1,operand1,op2,operand2,...}.
%
% WARNING: The \register cannot be used in the expression except possibly
%          as the first operand.


\newdimen{\@calct}


\def \@calculate #1=#2{%                        \register={expression}
  \let \@accum = #1%
  \@calca =,#2,;,,\zmark}

\def \@gcalculate #1=#2{%                       \register={expression}
  \let \@accum = #1%
  \@calca =,#2,;,,\zmark
  \global \@accum = \@accum}

\def \@calca #1,#2,#3\zmark{%
  \def \znext{\zcalca #3\zmark}%
       \if #1=\@accum = #2%                             % Assignment
  \else\if #1+\advance \@accum #2%                      % Addition
  \else\if #1-\advance \@accum -#2%                     % Subtraction
  \else\if #1*\multiply \@accum #2%                     % Multiplication
  \else\if #1/\divide \@accum #2%                       % Division
  \else\if #1N\if \dimlssp{#2}{\@accum}\@accum = #2\fi  % Minimum
  \else\if #1P\divide \@accum 100                       % Percentage
              \expandafter\@accum #2\@accum
  \else\if #1R\@calct = #2%                             % Ratio
              \divide \@calct by 4096
              \divide \@accum by \@calct
              \multiply \@accum by 16\relax
  \else\if #1S\@accum = \thefactor#2\@accum             % Scale
  \else\if #1X\if \dimgtrp{#2}{\@accum}\@accum = #2\fi  % Maximum
  \else\if #1;\let \znext = \relax                      % Done
  \else
    \ClassError{operator}{Invalid operator `#1' in expression}%
  \fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi
  \znext}

%                       Options
%                       -------


\@setflag \@authoryear = \@true
\@setflag \@explicitsize = \@false
\@setflag \@mathtime = \@false
\@setflag \@natbib = \@true
\@setflag \@ninepoint = \@true
\newcount{\@numheaddepth} \@numheaddepth = 3
\@setflag \@preprint = \@false
\@setflag \@tenpoint = \@false
\@setflag \@times = \@false

% Note that all the dangerous book class options are trapped.

\DeclareOption{9pt}{\@setflag \@ninepoint = \@true
                    \@setflag \@explicitsize = \@true}

\DeclareOption{10pt}{\PassOptionsToClass{10pt}{book}%
                     \@setflag \@ninepoint = \@false
                     \@setflag \@tenpoint = \@true
                     \@setflag \@explicitsize = \@true}

\DeclareOption{11pt}{\PassOptionsToClass{11pt}{book}%
                     \@setflag \@ninepoint = \@false
                     \@setflag \@explicitsize = \@true}

\DeclareOption{12pt}{\@unsupportedoption{12pt}}

\DeclareOption{a4paper}{\@unsupportedoption{a4paper}}

\DeclareOption{a5paper}{\@unsupportedoption{a5paper}}

\DeclareOption{authoryear}{\@setflag \@authoryear = \@true}

\DeclareOption{b5paper}{\@unsupportedoption{b5paper}}

\DeclareOption{cm}{\@setflag \@times = \@false}

\DeclareOption{computermodern}{\@setflag \@times = \@false}

\DeclareOption{executivepaper}{\@unsupportedoption{executivepaper}}

\DeclareOption{landscape}{\@unsupportedoption{landscape}}

\DeclareOption{legalpaper}{\@unsupportedoption{legalpaper}}

\DeclareOption{letterpaper}{\@unsupportedoption{letterpaper}}

\DeclareOption{mathtime}{\@setflag \@mathtime = \@true}

\DeclareOption{natbib}{\@setflag \@natbib = \@true}

\DeclareOption{nonatbib}{\@setflag \@natbib = \@false}

\DeclareOption{notitlepage}{\@unsupportedoption{notitlepage}}

\DeclareOption{numberedpars}{\@numheaddepth = 4}

\DeclareOption{numbers}{\@setflag \@authoryear = \@false}

\DeclareOption{preprint}{\@setflag \@preprint = \@true}

\DeclareOption{times}{\@setflag \@times = \@true}

\DeclareOption{titlepage}{\@unsupportedoption{titlepage}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

\ExecuteOptions{10pt,indentedstyle,times}
\@setflag \@explicitsize = \@false
\ProcessOptions

\PassOptionsToClass{twoside,onecolumn}{book}
\LoadClass{book}

\def \@unsupportedoption #1{%
  \ClassError{proc}{The standard '#1' option is not supported.}}

% This can be used with the 'reprint' option to get the final folios.

\def \setpagenumber #1{%
  \setcounter{page}{#1}}

\AtEndDocument{\label{sigplanconf@finalpage}}

%                       Utilities
%                       ---------


\newcommand{\setvspace}[2]{%
  #1 = #2
  \advance #1 by -1\parskip}

%                       Document Parameters
%                       -------- ----------


% Page:

\newdimen{\trimwidth}
\newdimen{\trimheight}

\setlength{\trimwidth}{7.5in}
\setlength{\trimheight}{9.25in}

\setlength{\hoffset}{.5in}
\setlength{\voffset}{0in}

\setlength{\topmargin}{2.9pc}
\setlength{\headheight}{7pt}
\setlength{\headsep}{31pt}

\setlength{\evensidemargin}{.5in}
\setlength{\oddsidemargin}{.5in}

% Text area:

\newdimen{\standardtextwidth}
\setlength{\standardtextwidth}{31pc}

\setlength{\textwidth}{31pc}

\setlength{\topskip}{8pt}
\setlength{\columnsep}{2pc}
\setlength{\textheight}{45pc}

% Running foot:

\setlength{\footskip}{30pt}

% Paragraphs:

\setlength{\parskip}{0pt}
\setlength{\parindent}{12pt}

\setlength{\lineskip}{.5pt}
\setlength{\lineskiplimit}{\lineskip}

\frenchspacing
\pretolerance = 400
\tolerance = \pretolerance
\setlength{\emergencystretch}{8pt}
\clubpenalty = 10000
\widowpenalty = 10000
\setlength{\hfuzz}{.5pt}

\setlength{\overfullrule}{0pt}

% Standard vertical spaces:

\newskip{\standardvspace}
\setvspace{\standardvspace}{5pt plus 1pt minus .5pt}

% Margin paragraphs:

\setlength{\marginparwidth}{36pt}
\setlength{\marginparsep}{2pt}
\setlength{\marginparpush}{8pt}


\setlength{\skip\footins}{8pt plus 3pt minus 1pt}
\setlength{\footnotesep}{9pt}

\renewcommand{\footnoterule}{%
  \hrule width .5\columnwidth height .33pt depth 0pt}

\renewcommand{\@makefntext}[1]{%
  \noindent \@makefnmark \hspace{1pt}#1}

% Floats:

\setcounter{topnumber}{4}
\setcounter{bottomnumber}{1}
\setcounter{totalnumber}{4}

\renewcommand{\fps@figure}{tp}
\renewcommand{\fps@table}{tp}
\renewcommand{\topfraction}{0.90}
\renewcommand{\bottomfraction}{0.30}
\renewcommand{\textfraction}{0.10}
\renewcommand{\floatpagefraction}{0.75}

\setcounter{dbltopnumber}{4}

\renewcommand{\dbltopfraction}{\topfraction}
\renewcommand{\dblfloatpagefraction}{\floatpagefraction}

\setlength{\floatsep}{28pt plus 4pt minus 2pt}
\setlength{\textfloatsep}{28pt plus 4pt minus 3pt}
\setlength{\intextsep}{10pt plus 4pt minus 3pt}

\setlength{\dblfloatsep}{28pt plus 4pt minus 2pt}
\setlength{\dbltextfloatsep}{20pt plus 4pt minus 3pt}

% Miscellaneous:

\errorcontextlines = 5

%                       Fonts
%                       -----


\if \@times
  \renewcommand{\rmdefault}{ptm}%
  \if \@mathtime
    \usepackage[mtbold,noTS1]{mathtime}%
  \else
%%%    \usepackage{mathptm}%
  \fi
\else
  \relax
\fi

\renewcommand{\normalsize}{%
  \@setfontsize{\normalsize}{10pt}{14pt}%
  \setlength{\abovedisplayskip}{8pt plus 1pt minus .5pt}%
  \setlength{\belowdisplayskip}{\abovedisplayskip}%
  \setlength{\abovedisplayshortskip}{8pt plus 1pt minus 2pt}%
  \setlength{\belowdisplayshortskip}{\abovedisplayshortskip}}

\renewcommand{\tiny}{\@setfontsize{\tiny}{5pt}{6pt}}

\renewcommand{\scriptsize}{\@setfontsize{\scriptsize}{7pt}{8pt}}

\renewcommand{\small}{%
  \@setfontsize{\small}{9pt}{12pt}%
  \setlength{\abovedisplayskip}{6pt plus 1pt minus 1pt}%
  \setlength{\belowdisplayskip}{\abovedisplayskip}%
  \setlength{\abovedisplayshortskip}{6pt plus 1pt}%
  \setlength{\belowdisplayshortskip}{\abovedisplayshortskip}}

\renewcommand{\footnotesize}{%
  \@setfontsize{\footnotesize}{8pt}{9pt}%
  \setlength{\abovedisplayskip}{6pt plus 1pt minus .5pt}%
  \setlength{\belowdisplayskip}{\abovedisplayskip}%
  \setlength{\abovedisplayshortskip}{6pt plus 1pt}%
  \setlength{\belowdisplayshortskip}{\abovedisplayshortskip}}

\renewcommand{\large}{\@setfontsize{\large}{12pt}{13pt}}

\renewcommand{\Large}{\@setfontsize{\Large}{14pt}{18pt}}

\renewcommand{\LARGE}{\@setfontsize{\LARGE}{18pt}{20pt}}

\renewcommand{\huge}{\@setfontsize{\huge}{20pt}{25pt}}

\renewcommand{\Huge}{\@setfontsize{\Huge}{30pt}{35pt}}

\newcommand{\monster}{\@setfontsize{\monster}{100pt}{100pt}}

%                       Bibliography
%                       ------------


\renewenvironment{thebibliography}[1]
     {\chapter*{Bibliography}%
      \markboth{Bibliography}{Bibliograph}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \itemsep = 2pt plus 1pt minus .5pt
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \bibfont
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

\if \@natbib

\if \@authoryear
  \typeout{Using natbib package with 'authoryear' citation style.}
  \usepackage[authoryear,sort,square]{natbib}
  \bibpunct{[}{]}{;}{a}{}{,}    % Change fences to brackets;
                                % citation separator to semicolon;
                                % eliminate comma between author and year.
  \bibliographystyle{plainnat}
  \let \cite = \citep
\else
  \typeout{Using natbib package with 'numbers' citation style.}
  \usepackage[numbers,sort&compress,square]{natbib}
\fi
\setlength{\bibsep}{3pt plus .5pt minus .25pt}

\fi

\def \bibfont {\small}

%                       Enunciations
%                       ------------


\def \@begintheorem #1#2{%                      {name}{number}
  \trivlist
  \item[\hskip \labelsep \textsc{#1 #2.}]%
  \itshape\selectfont
  \ignorespaces}

\def \@opargbegintheorem #1#2#3{%               {name}{number}{title}
  \trivlist
  \item[%
    \hskip\labelsep \textsc{#1\ #2}%
    \if \@notp{\@emptyargp{#3}}\nut (#3).\fi]%
  \itshape\selectfont
  \ignorespaces}

%                       Figures
%                       -------


\@setflag \@caprule = \@true


\newcommand{\nocaptionrule}{%
  \@setflag \@caprule = \@false}

\long\def \@makecaption #1#2{%
  \stringeql{\@figurep}{\@captype}{figure}%
  \if \@figurep
    \addvspace{6pt}
    \if \@caprule
      \hrule width \hsize height .33pt
      \vspace{6pt}
    \fi
    {\softraggedright
     \noindent
     \llap{\hbox to 3pc{\hss \small \sffamily \bfseries #1 \hspace{8pt}}}%
     #2\par}%
  \else
    {\softraggedright
     \noindent
     \llap{\hbox to 3pc{\hss \small \sffamily \bfseries #1 \hspace{8pt}}}%
     #2\par}%
    \addvspace{6pt}%
  \fi}

\def\caption{%
   \ifx\@captype\@undefined
     \@latex@error{\noexpand\caption outside float}\@ehd
     \expandafter\@gobble
   \else
     \refstepcounter\@captype
     \expandafter\@firstofone
   \fi
   {\@dblarg{\@caption\@captype}}%
}

%                       Hierarchy
%                       ---------


\setcounter{secnumdepth}{\@numheaddepth}

\def\@makechapterhead#1{%
  \vspace*{30pt}%
  \noindent
  \llap{\vbox to 0pt{%
    \vss
    \hbox{\monster \bfseries \thechapter \hspace{18pt}}%
    \vskip -24pt}}%
  {\Huge \sffamily \bfseries #1}\par
  \vskip 14pt}

\def\@makeschapterhead#1{%
  \vspace*{30pt}%
  \noindent
  {\Huge \sffamily \bfseries #1}\par
  \vskip 14pt}

\newskip{\@sectionaboveskip}
\setvspace{\@sectionaboveskip}{13pt plus 5pt minus 1pt}

\newskip{\@sectionbelowskip}
\setlength{\@sectionbelowskip}{.01pt}%

\renewcommand{\section}{%
  \@startsection
    {section}%
    {2}%
    {0pt}%
    {-\@sectionaboveskip}%
    {\@sectionbelowskip}%
    {\large \sffamily \bfseries \raggedright}}

\newskip{\@subsectionaboveskip}
\setvspace{\@subsectionaboveskip}{13pt plus 3pt minus .5pt}

\newskip{\@subsectionbelowskip}
\setlength{\@subsectionbelowskip}{.01pt}%

\renewcommand{\subsection}{%
  \@startsection%
    {subsection}%
    {3}%
    {0pt}%
    {-\@subsectionaboveskip}%
    {\@subsectionbelowskip}%
    {\normalsize \sffamily \bfseries \raggedright}}

\renewcommand{\subsubsection}{%
  \@startsection%
    {subsubsection}%
    {3}%
    {0pt}%
    {-\@subsectionaboveskip}
    {\@subsectionbelowskip}%
    {\normalsize \bfseries \raggedright}}

\newskip{\@paragraphaboveskip}
\setvspace{\@paragraphaboveskip}{6pt plus 2pt minus 2pt}

\renewcommand{\paragraph}{%
  \@startsection%
    {paragraph}%
    {4}%
    {0pt}%
    {\@paragraphaboveskip}
    {-1em}%
    {\normalsize \bfseries \if \@times \itshape \fi}}

\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \@hangfrom{\llap{\hbox to 3pc{%
                     \if \@eqlp{#2}{2}\LARGE \fi
                     \hss \@svsec}}}%
          \interlinepenalty \@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}

%                       Lists
%                       -----


\setlength{\leftmargini}{20pt}
\setlength\leftmarginii{20pt}
\setlength\leftmarginiii{20pt}
\setlength\leftmarginiv{20pt}
\setlength{\labelsep}{3.5pt}

\setlength{\topsep}{\standardvspace}
\setlength{\itemsep}{1pt}
\setlength{\parsep}{3pt}

\renewcommand{\labelitemi}{{\small $\bullet$}}
%%%\renewcommand{\labelitemi}{{\small \centeroncapheight{\textbullet}}}
\renewcommand{\labelitemii}{\centeroncapheight{\rule{2.5pt}{2.5pt}}}
\renewcommand{\labelitemiii}{$-$}
\renewcommand{\labelitemiv}{{\Large \textperiodcentered}}

\renewcommand{\@listi}{%
  \leftmargin = \leftmargini
  \listparindent = 0pt}
%%%  \itemsep = 1pt
%%%  \parsep = 3pt}
%%%  \listparindent = \parindent}

\let \@listI = \@listi

\renewcommand{\@listii}{%
  \leftmargin = \leftmarginii
  \topsep = 1pt
  \labelwidth = \leftmarginii
  \advance \labelwidth by -\labelsep
  \listparindent = \parindent}

\renewcommand{\@listiii}{%
  \leftmargin = \leftmarginiii
  \labelwidth = \leftmarginiii
  \advance \labelwidth by -\labelsep
  \listparindent = \parindent}

\renewcommand{\@listiv}{%
  \leftmargin = \leftmarginiv
  \labelwidth = \leftmarginiv
  \advance \labelwidth by -\labelsep
  \listparindent = \parindent}

%                       Mathematics
%                       -----------


\def \theequation {\arabic{chapter}.\arabic{equation}}

%                       Miscellaneous
%                       -------------


\newcommand{\balancecolumns}{%
  \vfill\eject
  \global\@colht = \textheight
  \global\ht\@cclv = \textheight}

\newcommand{\nut}{\hspace{.5em}}

\newcommand{\softraggedright}{%
  \let \\ = \@centercr
  \leftskip = 0pt
  \rightskip = 0pt plus 12pt}

%                       Program Code
%                       ------- ----


\newcommand{\mono}[1]{%
  {\@tempdima = \fontdimen2\font
   \texttt{\spaceskip = 1.1\@tempdima #1}}}

%                       Running Heads and Feet
%                       ------- ----- --- ----


\def \ps@headings {%
  \def \@evenhead {\@setfolio{\thepage}\quad \leftmark \hfill}%
  \let \@evenfoot = \@empty
  \def \@oddhead {\hfill \rightmark \quad \@setfolio{\thepage}}%
  \let \@oddfoot = \@empty
  \let \@mkboth = \markboth
  \def \chaptermark ##1{%
    \markboth{%
      \ifnum \c@secnumdepth >\m@ne
        \if@mainmatter
          \@chapapp\ \thechapter \quad
        \fi
      \fi
      \emph{##1}}{}}%
  \def \sectionmark ##1{%
    \markright{%
      \ifnum \c@secnumdepth >\z@
        \thesection \nut
      \fi
      ##1}}}
\ps@headings

\def \ps@plain {%
  \let \@evenhead = \@empty
  \def \@evenfoot {\hfill \@setfolio{\thepage}\hfill}%
  \let \@oddhead = \@empty
  \def \@oddfoot {\hfill \@setfolio{\thepage}\hfill}%
  \let \@mkboth = \markboth}

\def \@setfolio #1{%
  {\sffamily \bfseries \small #1}}

%                       Special Characters
%                       ------- ----------


\DeclareRobustCommand{\euro}{%
  \protect{\rlap{=}}{\sf \kern .1em C}}

%                       Utilities
%                       ---------


\newcommand{\centeroncapheight}[1]{%
  {\setbox\@tempboxa = \hbox{#1}%
   \@measurecapheight{\@tempdima}%         % Calculate ht(CAP) - ht(text)
   \advance \@tempdima by -\ht\@tempboxa   %           ------------------
   \divide \@tempdima by 2                 %                   2
   \raise \@tempdima \box\@tempboxa}}

\newbox{\@measbox}

\def \@measurecapheight #1{%                            {\dimen}
  \setbox\@measbox = \hbox{ABCDEFGHIJKLMNOPQRSTUVWXYZ}%
  #1 = \ht\@measbox}

\long\def \@titlefootnote #1#2{%
  \insert\footins{%
    \reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
%%%    \protected@edef\@currentlabel{%
%%%       \csname p@footnote\endcsname\@thefnmark}%
    \color@begingroup
      \def \@makefnmark {$^{#1}$}%
      \@makefntext{%
        \rule\z@\footnotesep\ignorespaces#2\@finalstrut\strutbox}%
    \color@endgroup}}

%                       LaTeX Modifications
%                       ----- -------------

\def \cleardoublepage {%
  \clearpage
  \ifodd \c@page \else
    \thispagestyle{empty}
    \hbox{}%
    \clearpage
  \fi}

\def \@seccntformat #1{%
  \@name{\the#1}%
  \@expandaftertwice\@seccntformata \csname the#1\endcsname.\@mark
  \quad}

\def \@seccntformata #1.#2\@mark{%
  \if \@emptyargp{#2}.\fi}

%                       Revision History
%                       -------- -------


%  Date         Person  Ver.    Change
%  ----         ------  ----    ------

%  2014/02/06   PCA     0.1     Begin work on class file.

%  2014/02/15   PCA     0.1     Send first samples to Diane.

%  2014/02/24   PCA     1.0     Release initial version.

%  2014/02/25   PCA     1.1     Use natbib in author/date style as the
%                               default bibliography package.

%  2014/03/05   PCA     1.2     Change text leading to 14 points.
%                               Change citation fences to brackets.
