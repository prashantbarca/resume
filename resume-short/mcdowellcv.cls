\ProvidesClass{mcdowellcv}[2015/12/15 v1.1.0 McDowell CV class]
\usepackage[dvipsnames]{xcolor}

\definecolor{dartmouthgreen}{RGB}{0, 105, 62}
\definecolor{dartmouthgreencompl}{RGB}{10, 0, 105}

% Set up the fonts according to options
\def\mainfontsize{11pt}
\def\mainfontface{Times New Roman}

\DeclareOption{calibri}{%
  \def\mainfontface{Calibri}
}

\ProcessOptions\relax

% Set font size and paper type
\LoadClass[letterpaper,\mainfontsize]{article} 

% Set document margins
\usepackage[left=0.5in,top=0.5in,right=0.5in,bottom=0.2in]{geometry} 

% Set font face
\usepackage{fontspec}
\usepackage[utf8]{inputenc}
\usepackage[english]{babel}
\renewcommand{\baselinestretch}{1.04}
 
\usepackage[usenames, dvipsnames]{color}
\setmainfont[SmallCapsFeatures={Renderer=Basic},
Ligatures={TeX, NoCommon, NoDiscretionary}]{\mainfontface}

% Remove paragraph indentation
\usepackage[parfill]{parskip} 

% Required for boldface (\bf and \bfseries) tabular columns
\usepackage{array} 
\usepackage{color}

% Required for ifthenelse statements
\usepackage{etoolbox} 

% Suppress page numbers
\pagestyle{empty} 

% Flexible tables
\usepackage{tabu}

% For custom margins
\usepackage{changepage}

% To customize lists
\usepackage{enumitem}
% Remove left margin from lists, suppress vertical item separation and set top 
% separation to a negative value to suppress a single parskip before lists
\setlist{leftmargin=*, noitemsep, topsep=-1\parskip}

% For spcaed small caps
\usepackage{microtype}

\DeclareMicrotypeSet*{smallcapsi} { 
	encoding = {OT1,T1,T2A,LY1,OT4,QX,T5,TS1,EU1,EU2},
	shape    = {sc*,si,scit}
}

%--------------------------------------------------------------------------------
%                                    Constants                                  -
%--------------------------------------------------------------------------------
% space after the heading i.e. complete heading like name, address etc
\def\afterheaderspace{-6pt}

% space after each section ends
\def\beforesectionheaderspace{3.75pt} 


\def\sectionheadermargin{6pt}
\def\aftersectionheaderspace{-4pt}
\def\sectionheaderhrlueheight{0.5pt}
\def\aftersinglelinesubsectionheaderspace{-18.5pt}
\def\afterdoublelinesubsectionheaderspace{-10pt}
\def\aftermultilinesubsectionheaderspace{-6pt}
\def\afteremptysubsectionheaderspace{5pt}
\def\subsectionmargin{9pt}
\def\aftersubsectionspace{-6pt}

%--------------------------------------------------------------------------------
%                            Header Setup and Printing                          -
%--------------------------------------------------------------------------------

% Address
\makeatletter

\newcommand\address[1]{\def\@address{#1}}
\address{}

\newcommand\printaddress{
	\small{\@address}
}

\makeatother

% Name
\makeatletter

\newcommand\motto[1]{\def\@motto{#1}}
\motto{}
\newcommand\name[1]{\def\@name{#1}}
\name{}

\newcommand\printname{
	%\color{dartmouthgreen}\textbf{\huge{\textsc{\@name}}}
	\@name
}
% \textls[110]
\makeatother

% Contacts
\makeatletter

\newcommand\contacts[1]{\def\@contacts{#1}}
\contacts{}

\newcommand\printcontacts{
	\small{\@contacts}
}

\makeatother

\makeatletter
\newcommand\makeheader{
	\begin{center}
		\begin{tabu} to 1\textwidth { X[l,m] X[c,m] X[r,m] }
			\printaddress & \printname & \printcontacts \\
		\end{tabu}	
	\end{center}
	\vspace*{\afterheaderspace}
}
\makeatother

%--------------------------------------------------------------------------------
%                            Sections and Subsections                           -
%--------------------------------------------------------------------------------

% Print a section header
\makeatletter
\newenvironment{cvsection}[1]{
	\vspace*{\beforesectionheaderspace}
	% Set text margins to equal \tabcolsep (6pt by default)
	\begin{adjustwidth}{\sectionheadermargin}{\sectionheadermargin}
		\color{dartmouthgreencompl}\textsc{\textbf{#1}}
	\end{adjustwidth}
	\smallskip
	\hrule height \sectionheaderhrlueheight
	\vspace*{\aftersectionheaderspace}
}{}
\makeatother

% Print a subsection
\makeatletter
% Define toggles checking if titles were defined
\newtoggle{lefttitledefined}
\newtoggle{centertitledefined}
\newtoggle{righttitledefined}

\newenvironment{cvsubsection}[4][1]
{
	\notblank{#2}{\toggletrue{lefttitledefined}}{}
	\notblank{#3}{\toggletrue{centertitledefined}}{}
	\notblank{#4}{\toggletrue{righttitledefined}}{}
	\ifboolexpr{togl {lefttitledefined} or togl {centertitledefined} or togl {righttitledefined}}{
		\begin{tabu} to 1\textwidth { X[l,m] X[c,m+2] X[r,m] }
			\textbf{#2} & \normalsize\color{dartmouthgreen} \textbf{#3} & \textbf{#4} \\
		\end{tabu}
		% Add space according to the specidied number of lines
		\ifnumcomp{#1}{=}{1}{\vspace*{\aftersinglelinesubsectionheaderspace}}
        {\ifnumcomp{#1}{=}{2}{\vspace*{\afterdoublelinesubsectionheaderspace}}
        {\vspace*{\aftermultilinesubsectionheaderspace}
		}
		}
	}{
		\vspace*{\afteremptysubsectionheaderspace}
	}
	\togglefalse{lefttitledefined}
	\togglefalse{centertitledefined}
	\togglefalse{righttitledefined}
	\begin{adjustwidth}{\subsectionmargin}{\subsectionmargin}
}
{
	\end{adjustwidth}
	\vspace*{\aftersubsectionspace}
}
\makeatother
