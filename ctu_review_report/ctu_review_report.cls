% =====================================================================
% =                                                                   =
% =                  CTU template for thesis reviews                  =
% =             ČVUT šablona pro posudky závěrečných prací            =
% =                                                                   =
% =                       author: Michal Neoral                       =
% =                   contact: neoramic@fel.cvut.cz                   =
% =                                                                   =
% =                          14th June 2023                           =
% =                                                                   =
% =====================================================================
% =                             DISCLAIMER:                           =
% =                                                                   =
% =  This LaTeX-based thesis reviewer report template is unofficial   =
% =  and provided without any guarantee. Usage of the template is at  =
% =  your own risk. The template was created according to the offi    =
% =  -cial word templates accessible from KOS or from:                =
% =  https://comtel.fel.cvut.cz/cs/instrukce-pro-zaverecne-prace      =
% =      Template was created for my personal usage at first. I was   =
% =  asked to publish it by my colleagues.                            =
% =====================================================================

% =====================================================================
% =                          LOG of changes:                          =
% = 2023-06-14 - Creation of the template                             =
% = 2025-05-03 - Published                                            =
% =====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ctu_review_report/ctu_review_report}[2023/06/14 CTU Thesis Reviewer or Supervisor Report]


% magical approach for string switches in latex
\RequirePackage{pdftexcmds}
% \makeatletter
\newcommand{\stringcases}[3]{%
  \romannumeral
    \str@case{#1}#2{#1}{#3}\q@stop
}
\newcommand{\str@case}[3]{%
  \ifnum\pdf@strcmp{\unexpanded{#1}}{\unexpanded{#2}}=\z@
    \expandafter\@firstoftwo
  \else
    \expandafter\@secondoftwo
  \fi
    {\str@case@end{#3}}
    {\str@case{#1}}%
}
\newcommand{\str@case@end}{}
\long\def\str@case@end#1#2\q@stop{\z@#1}
% \makeatother


% declaration of main template settings
\RequirePackage{ifthen}

\newif\ifen
\newif\ifcz

\newif\ifreviewer
\newif\ifsupervisor

\newif\ifbachelor
\newif\ifmaster

\newif\ifwouthelp

\DeclareOption{lang=cz}{\cztrue}
\DeclareOption{lang=en}{\entrue}
\DeclareOption{cz}{\cztrue}
\DeclareOption{en}{\entrue}
\DeclareOption{iam=reviewer}{\reviewertrue}
\DeclareOption{iam=supervisor}{\supervisortrue}
\DeclareOption{reviewer}{\reviewertrue}
\DeclareOption{supervisor}{\supervisortrue}
\DeclareOption{thesistype=bachelor}{\bachelortrue}
\DeclareOption{thesistype=master}{\mastertrue}
\DeclareOption{bachelor}{\bachelortrue}
\DeclareOption{master}{\mastertrue}
\DeclareOption{wouthelp}{\wouthelptrue}
\ProcessOptions\relax

% checks for options
\ifthenelse{\boolean{en} \AND \boolean{cz}}{
    \ClassError{CTU Review Report}{More than one language is set}{Choose only one of lang=cz or lang=en}
}{}

\ifthenelse{\NOT\boolean{en} \AND \NOT\boolean{cz}}{
    \ClassError{CTU Review Report}{NO language is set}{Choose one of lang=cz or lang=en}
}{}

\ifthenelse{\boolean{reviewer} \AND \boolean{supervisor}}{
    \ClassError{CTU Review Report}{Yoo cannot be reviewer and supervisor at the same time}{Choose only one of iam=reviewer or iam=supervisor}
}{}

\ifthenelse{\NOT\boolean{reviewer} \AND \NOT\boolean{supervisor}}{
    \ClassError{CTU Review Report}{Yoo have to specify your relation to this thesis}{Choose one of iam=reviewer or iam=supervisor}
}{}

\ifthenelse{\boolean{bachelor} \AND \boolean{master}}{
    \ClassError{CTU Review Report}{Thesis cannot be bachelor and master at the same time}{Choose only one of thesistype=bachelor or thesistype=master}
}{}

\ifthenelse{\NOT\boolean{bachelor} \AND \NOT\boolean{master}}{
    \ClassError{CTU Review Report}{Thesis has to have specified type}{Choose one of thesistype=bachelor or thesistype=master}
}{}

% base class
\LoadClass[oneside,a4paper,11pt]{report}

% setting of the "paper" and offsets
\RequirePackage[a4paper,top=37mm,left=15mm,right=15mm,bottom=30mm,bindingoffset=0mm,headheight=18mm]{geometry}

% babel settings (main=xxx needed for automatic date creation)
\ifen
    \RequirePackage[czech,main=english]{babel}
\fi
\ifcz
    \RequirePackage[main=czech,english]{babel}
\fi

% another portion of useful packages
\RequirePackage[T1]{fontenc}
\RequirePackage{tabularx}
\RequirePackage{setspace}

% automatic creation of the date
\RequirePackage[czech,en-GB]{datetime2}
\DTMlangsetup[en-GB]{ord=raise,monthyearsep={\space}}
\renewcommand{\today}{\the\year-\month-\day}

% bilingual commands
\newcommand{\langen}[1]{\ifen#1\fi}
\newcommand{\langcz}[1]{\ifcz#1\fi}
\newcommand{\langsw}[2]{\ifen#1\fi\ifcz#2\fi}
\newcommand{\langslen}[1]{\ifen\selectlanguage{english}#1\fi}
\newcommand{\langcslz}[1]{\ifcz\selectlanguage{czech}#1\fi}

% variable setting commands
\renewcommand*{\date}[1]{\DTMsavedate{cturev@date}{#1}}
\newcommand*{\thesisTitle}[1]{\gdef\cturev@thesisTitle{#1}}
\newcommand*{\thesisAuthor}[1]{\gdef\cturev@thesisAuthor{#1}}
\newcommand*{\reviewerName}[1]{\gdef\cturev@reviewerName{#1}}
\newcommand*{\faculty}[1]{\gdef\cturev@faculty{\ctupart{#1}}}
\newcommand*{\thesisAuthorDepartment}[1]{\gdef\cturev@thesisAuthorDepartment{#1}}
\newcommand*{\reviewerDepartment}[1]{\gdef\cturev@reviewerDepartment{#1}}


% Useful packages
\RequirePackage{amsmath}
\RequirePackage{graphicx}
\RequirePackage[pdftex,colorlinks=true,allcolors=black]{hyperref}

% setting up pdf-metas
\newcommand{\pdfMetaReviewerName}{\cturev@reviewerName (\ifreviewer\langsw{thesis reviewer}{oponent}\fi\ifsupervisor\langsw{thesis supervisor}{vedoucí práce}\fi)}
\newcommand{\pdfMetaTitle}{\cturev@thesisAuthor -\cturev@thesisTitle (\langsw{Review - review author:}{Posudek - author posudku:}\cturev@reviewerName)}

\newcommand{\addpdfmetas}{
\hypersetup{
    pdfauthor={ \pdfMetaReviewerName },
    pdftitle={ \pdfMetaTitle },
    pdfsubject={ \ifreviewer\langsw{reviewer's report}{posudek oponenta}\fi\ifsupervisor\langsw{supervisor's report}{posudek vedoucího práce}\fi },
    pdfproducer={Latex with hyperref, or other system, Template author Michal Neoral},
    pdfcreator={pdflatex, or other tool, Template author Michal Neoral},    
}}

% packages, packages everywhere...
\RequirePackage[dvipsnames]{xcolor}
\definecolor{ERROR}{RGB}{255, 0, 0}
\RequirePackage[sf,bf]{titlesec}
\RequirePackage{mdframed}
\RequirePackage{svg}

\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\RequirePackage{tikz}

% definition of the assignment evaluation
\newcommand*{\evaluationOfAssignment}[1]{%
  \stringcases
    {#1}%
    {%
      {a}{\langsw{extraordinarily challenging}{mimořádně náročné}}%
      {b}{\langsw{challenging}{nářočnější}}%
      {c}{\langsw{ordinarily challenging}{průměrně náročné}}%
      {d}{\langsw{easy}{lehčí}}%
      {e}{\langsw{unsatisfacrorily challenging}{nedostatečně náročné}}%
    }%
    {{\color{ERROR} \langsw{invalid choice}{tato volba není validní}}}%
}

% definition of the assignment fulfilment evaluation
\newcommand*{\evaluationOfFulfilment}[1]{%
  \stringcases
    {#1}%
    {%
      {a}{\langsw{fulfilled}{splněno}}%
      {b}{\langsw{fulfilled with minor objections}{splněno s menšími výhradami}}%
      {c}{\langsw{fulfilled with major objections}{splněno s většími výhradami}}%
      {d}{\langsw{unfulfilled}{nesplněno}}%
    }%
    {{\color{ERROR} \langsw{invalid choice}{tato volba není validní}}}%
}

% definition of methodology evaluation
\newcommand*{\evaluationOfMethodology}[1]{%
  \stringcases
    {#1}%
    {%
      {a}{\langsw{outstanding}{vynikající}}%
      {b}{\langsw{correct}{správný}}%
      {c}{\langsw{partially applicable}{částečně vhodný}}%
      {d}{\langsw{incorrect}{nesprávný}}%
    }%
    {{\color{ERROR} \langsw{invalid choice}{tato volba není validní}}}%
}

% definition of grades
\newcommand*{\evaluationMarks}[1]{%
  \stringcases
    {#1}%
    {%
      {A}{A - \langsw{excellent}{výborně}}%
      {B}{B - \langsw{very good}{velmi dobře}}%
      {C}{C - \langsw{good}{dobře}}%
      {D}{D - \langsw{satisfactory}{uspokojivě}}%
      {E}{E - \langsw{sufficient}{dostatečně}}%
      {F}{F - \langsw{failed}{nedostatečně}}%
    }%
    {{\color{ERROR} \langsw{invalid choice}{tato volba není validní}}}%
}

% definition of the faculties/parts abbreviations
\newcommand*{\ctupart}[1]{%
  \stringcases
    {#1}%
    {%
      {FSV}{\langsw{Faculty of Civil Engineering (FCE)}{Fakulta stavební (FSv)}}%
      {FSv}{\langsw{Faculty of Civil Engineering (FCE)}{Fakulta stavební (FSv)}}%
      {FCE}{\langsw{Faculty of Civil Engineering (FCE)}{Fakulta stavební (FSv)}}%
      {FME}{\langsw{Faculty of Mechanical Engineering (FME)}{Fakulta strojní (FS)}}%
      {FS}{\langsw{Faculty of Mechanical Engineering (FME)}{Fakulta strojní (FS)}}%
      {FEL}{\langsw{Faculty of Electrical Engineering (FEE)}{Fakulta elektrotechnická (FEL)}}%
      {FEE}{\langsw{Faculty of Electrical Engineering (FEE)}{Fakulta elektrotechnická (FEL)}}%
      {FNSPE}{\langsw{Faculty of Nuclear Science and Physical Engineering (FNSPE)}{Fakulta jaderná a fyzikálně inženýrská (FJFI)}}%
      {FJFI}{\langsw{Faculty of Nuclear Science and Physical Engineering (FNSPE)}{Fakulta jaderná a fyzikálně inženýrská (FJFI)}}%
      {FA}{\langsw{Faculty of Architecture (FA)}{Fakulta architektury (FA)}}%
      {FD}{\langsw{Faculty of Transportation Sciences (FTS)}{Fakulta dopravní (FD)}}%
      {FTS}{\langsw{Faculty of Transportation Sciences (FTS)}{Fakulta dopravní (FD)}}%
      {FBE}{\langsw{Faculty of Biomedical Engineering (FBE)}{Fakulta biomedicínského inženýrství (FBMI)}}%
      {FBMI}{\langsw{Faculty of Biomedical Engineering (FBE)}{Fakulta biomedicínského inženýrství (FBMI)}}%
      {FIT}{\langsw{Faculty of Information Technology (FIT)}{Fakulta informačních technologií (FIT)}}%
      {MIAS}{\langsw{Masaryk Institute of Advanced Studies (MIAS)}{Masarykův ústav vyšších studií (MÚVS)}}%
      {MUVS}{\langsw{Masaryk Institute of Advanced Studies (MIAS)}{Masarykův ústav vyšších studií (MÚVS)}}%
      {FUN}{\langsw{Faculty of Unicorns and Nonsence (FUN)}{Fakulta Jednorožců a Nesmyslů (FJN)}}%
    }%
    {{\color{ERROR}\bfseries #1 - \langsw{invalid choice}{tato volba není validní}}}%
}


% appearance of sections settings
\renewcommand{\thesection}{\Roman{section}.} 
\titleformat{\section}{\normalsize\bfseries\fontfamily{qhv}\selectfont}{\thesection}{1em}{\normalsize}
\titlespacing*{\section}{0pt}{18pt}{3pt}

% setting of a head and foot
\renewcommand{\headrulewidth}{0pt} % vypnutí horní linky
\pagestyle{fancy}
\fancyhead{} % záhlaví prázné
\fancyfoot[C]{\thepage/\pageref{LastPage}}
\setlength{\headheight}{69.05775pt}
% \addtolength{\topmargin}{-17.8428pt}

% Czech or English logo of our university
\ifen
%\lhead{\includesvg[width=4.5cm]{ctu_review_report/logo_CTU_cb.svg}}
\lhead{\includegraphics [width=4.5cm]{ctu_review_report/logo_CTU_cb}}
\fi
\ifcz
%\lhead{\includesvg[width=4.5cm]{ctu_review_report/logo_CVUT_cb.svg}}
\lhead{\includegraphics[width=4.5cm]{ctu_review_report/logo_CVUT_cb}}
\fi


% 4 case switch for type of the thesis
\newcommand{\printThesisType}{
\ifbachelor
    \ifen bachelor\fi\ifcz bakalářská\fi
\fi
\ifmaster
    \ifen master\fi\ifcz diplomová\fi
\fi
}

% 4 case switch for "My" department
\newcommand{\printReviewerDepartmentTitle}{
\ifsupervisor
\langsw{Supervisor’s department:}{Pracoviště~vedoucího~práce:}
\fi
\ifreviewer
\langsw{Reviewer’s department:}{Pracoviště oponenta práce:}
\fi
}

% 4 case switch for "My" name
\newcommand{\printReviewerNameTitle}{
\ifsupervisor
\langsw{Thesis supervisor:}{Vedoucí práce:}
\fi
\ifreviewer
\langsw{Thesis reviewer:}{Oponent práce:}
\fi
}

% 4 case switch for text in the head (if you want longer text, you may need to make it more complex with the redefinition of \rhead bellow
\newcommand{\printHeaderType}{
\ifsupervisor
\langsw{SUPERVISOR'S OPINION OF THESIS}{POSUDEK VEDOUCÍHO PRÁCE}
\fi
\ifreviewer
\langsw{THESIS REVIEWER'S REPORT}{POSUDEK OPONENTA PRÁCE}
\fi
}
\rhead{\LARGE\bfseries\fontfamily{qhv}\selectfont \printHeaderType\\~\vfill}

% definition of the evaluation boxes
\mdfdefinestyle{reviewReportStyle}{innerleftmargin=2mm, 
                         innertopmargin=1mm,
                         innerrightmargin=2mm,
                         innerbottommargin=1mm,
                         skipbelow=0mm,
                         frametitlerule=true,
                         frametitleaboveskip=1mm,
                         frametitlerulecolor=gray,
                         linewidth=0.75pt,
                         }

% more compact text (somehow broken and needs to have a low value)
\renewcommand{\baselinestretch}{0.9}

% definition of the helptext appearance
\newcommand{\helptext}[1]{
\noindent{\color{gray} \it \scriptsize
\begin{spacing}{1.0}
\noindent #1
\end{spacing}
}
}

% script for general creation of evaluation boxes 
\newcommand{\evaluation}[4]{
\begin{mdframed}[style=reviewReportStyle, 
frametitle={
\begin{tabularx}{0.995\linewidth}{Xr}
{\hspace{-2.5pt}\bfseries\sffamily #1} & \bfseries\fontfamily{qhv}\large\MakeUppercase{#2}\\
\end{tabularx}
\ifwouthelp
\vspace{-10pt}
\else
\vspace{-5pt}
\helptext{#3}
\fi
}]
{\small 
#4
}
\end{mdframed}
}


% START of the document - identification data box definition
\newcommand{\printIdentificationData}{
\section{\langsw{IDENTIFICATION DATA}{IDENTIFIKAČNÍ ÚDAJE}}

\begin{mdframed}[style=reviewReportStyle]
    \begin{tabular}{p{4.95cm}p{12.55cm}}
    {\bfseries\sffamily \langsw{Thesis title}{Název práce}:} & \cturev@thesisTitle\\
    {\bfseries\sffamily \langsw{Author's name}{Jméno autora}:} & \cturev@thesisAuthor\\
    {\bfseries\sffamily \langsw{Typ of thesis}{Typ práce}:} & \printThesisType\\
    {\bfseries\sffamily \langsw{Faculty/Institute}{Fakulta/ústav}:} & \cturev@faculty\\
    {\bfseries\sffamily \langsw{Department}{Katedra/ústav}:} & \cturev@thesisAuthorDepartment\\
    {\bfseries\sffamily \printReviewerNameTitle} & \cturev@reviewerName\\
    {\bfseries\sffamily \printReviewerDepartmentTitle} & \cturev@reviewerDepartment\\
    \end{tabular}
\end{mdframed}

\addpdfmetas

\section{\langsw{EVALUATION OF INDIVIDUAL CRITERIA}{HODNOCENÍ JEDNOTLIVÝCH KRITÉRIÍ}}
}


% END of the document - date and signature appearance definition
\newcommand{\dateAndSigniture}{
\vspace{70pt}
\noindent \langsw{Date}{Datum}: {\bfseries \DTMusedate{cturev@date}}

\vspace{10pt}
\begin{flushright}
\cturev@reviewerName
\end{flushright}
}

% =================================================================
% =             EVALUATION BOXES BASE TEXT DEFINITIONS            =
% =================================================================

% Assignment evaluation
\newcommand{\evalAssignment}[2]{
\evaluation{\langsw{Assignment}{Zadání}}
{\evaluationOfAssignment{#1}}
{\langsw
{How demanding was the assigned project?}
{Hodnocení náročnosti zadání závěrečné práce.}
}
{#2}
}

% Assignment fulfilment evaluation
\newcommand{\evalFulfilment}[2]{
\evaluation{\langsw{Fulfilment of assignment}{Splnění zadání}}
{\evaluationOfFulfilment{#1}}
{\langsw
{How well does the thesis fulfil the assigned task? Have the primary goals been achieved? Which assigned tasks have been incompletely covered, and which parts of the thesis are overextended? Justify your answer.}
{Posuďte, zda předložená závěrečná práce splňuje zadání. V komentáři případně uveďte body zadání, které nebyly zcela splněny, nebo zda je práce oproti zadání rozšířena. Nebylo-li zadání zcela splněno, pokuste se posoudit závažnost, dopady a případně i příčiny jednotlivých nedostatků.}
}
{#2}
}

% Methodology evaluation - JUST FOR REVIEWER
\ifreviewer
\newcommand{\evalActivity}[2]{}
\newcommand{\evalMethodology}[2]{
\evaluation{\langsw{Methodology}{Zvolený postup řešení}}
{\evaluationOfMethodology{#1}}
{\langsw
{Comment on the correctness of the approach and/or the solution methods.}
{Posuďte, zda student zvolil správný postup nebo metody řešení.}
}
{#2}
}
\fi

% Students activity evaluation - JUST FOR SUPERVISON
\ifsupervisor
\newcommand{\evalMethodology}[2]{}
\newcommand{\evalActivity}[2]{
\evaluation{\langsw{Activity and independence when creating final thesis}{Aktivita a samostatnost při zpracování práce}}
{\evaluationMarks{#1}}
{\langsw
{Assess that student had positive approach, time limits were met, conception was regularly consulted and was well prepared for consultations. Assess student’s ability to work independently.}
{Posuďte, zda byl student během řešení aktivní, zda dodržoval dohodnuté termíny, jestli své řešení průběžně konzultoval a zda byl na konzultace dostatečně připraven. Posuďte schopnost studenta samostatné tvůrčí práce.}
}
{#2}
}
\fi

% Technical level evaluation 
\newcommand{\evalTechnicalLevel}[2]{
\evaluation{\langsw{Technical level}{Odborná úroveň}}
{\evaluationMarks{#1}}
{\langsw
{Is the thesis technically sound? How well did the student employ expertise in the field of his/her field of study? Does the student explain clearly what he/she has done?}
{Posuďte úroveň odbornosti závěrečné práce, využití znalostí získaných studiem a z~odborné literatury, využití podkladů a dat získaných z~praxe.}
}
{#2}
}

% Formal sound evaluation
\newcommand{\evalFormal}[2]{
\evaluation{\langsw{Formal and language level, scope of thesis}{Formální a jazyková úroveň, rozsah práce}}
{\evaluationMarks{#1}}
{\langsw
{Are formalisms and notations used properly? Is the thesis organized in a logical way? Is the thesis sufficiently extensive? Is the thesis well-presented? Is the language clear and understandable? Is the English satisfactory?}
{Posuďte správnost používání formálních zápisů obsažených v práci. Posuďte typografickou a jazykovou stránku.}
}
{#2}
}

% Sources and citation evaluation
\newcommand{\evalCitation}[2]{
\evaluation{\langsw{Selection of sources, citation correctness}{Výběr zdrojů, korektnost citací}}
{\evaluationMarks{#1}}
{\langsw
{Does the thesis make adequate reference to earlier work on the topic? Was the selection of sources adequate? Is the student’s original work clearly distinguished from earlier work in the field? Do the bibliographic citations meet the standards?}
{Vyjádřete se k aktivitě studenta při získávání a využívání studijních materiálů k řešení závěrečné práce. Charakterizujte výběr pramenů. Posuďte, zda student využil všechny relevantní zdroje. Ověřte, zda jsou všechny převzaté prvky řádně odlišeny od vlastních výsledků a úvah, zda nedošlo k porušení citační etiky a zda jsou bibliografické citace úplné a v souladu s citačními zvyklostmi a normami.}
}
{#2}
}

% Additional comments
\newcommand{\evalComments}[1]{
\evaluation{\langsw{Additional commentary and evaluation (optional)}{Další komentáře a hodnocení (nepovinné)}}
{}
{\langsw
{Comment on the overall quality of the thesis, its novelty and its impact on the field, its strengths and weaknesses, the utility of the solution that is presented, the theoretical/formal level, the student’s skillfulness, etc.}
{Vyjádřete se k úrovni dosažených hlavních výsledků závěrečné práce, např. k úrovni teoretických výsledků, nebo k úrovni a funkčnosti technického nebo programového vytvořeného řešení, publikačním výstupům, experimentální zručnosti apod.}
}
{#1}
}

% Final words and overall evaluation section + final grade
\newcommand{\evalOverall}[2]{
\section{\langsw{OVERALL EVALUATION, QUESTIONS FOR THE PRESENTATION AND DEFENSE OF THE \mbox{THESIS}, SUGGESTED GRADE}{CELKOVÉ HODNOCENÍ, OTÁZKY K~OBHAJOBĚ, NÁVRH KLASIFIKACE}}

\ifwouthelp
\vspace{-5pt}
\else
\helptext{\langsw
{Summarize your opinion on the thesis and explain your final grading. Pose questions that should be answered during the presentation and defense of the student’s work.}
{Shrňte aspekty závěrečné práce, které nejvíce ovlivnily Vaše celkové hodnocení. Uveďte případné otázky, které by měl student zodpovědět při obhajobě závěrečné práce před komisí.}
}
\fi

\vspace{15pt}
\noindent #2

\vspace{15pt}
\noindent \langsw{The grade that I award for the thesis is}{Předloženou závěrečnou práci hodnotím klasifikačním stupněm} {\bfseries\fontfamily{qhv}\normalsize\MakeUppercase{\evaluationMarks{#1}}}.
}

% compact tables - need for more compact evaluation boxes (margins are set externally with mdframe)
\setlength{\tabcolsep}{0pt}


% =================================================================
% =                      DUMMY TEXT DEFINITION                    =
% =                  NOTHING USEFUL AFTER THIS LINE               =
% =================================================================

\newcommand{\DeleteMeAndFillYourOwnCommentAboutAssignment}{
\langsw{The assignment of this thesis was extraordinarily demanding, bringing the challenge of combining magic and electrical engineering. It required blending unconventional thinking with technical knowledge, which added to the complexity of this work.}{Zadání této závěrečné práce bylo neobyčejně náročné, přinášející výzvu spojenou se spojením magie a elektrotechniky. Bylo potřeba kombinovat nekonvenční myšlení s technickými znalostmi, což zvyšovalo náročnost této práce.}
}

\newcommand{\DeleteMeAndFillYourOwnCommentAboutFulfilmentOfTheAssignment}{
\langsw{The thesis fulfills the assignment and even expands it with new and original aspects. Thorough analyses and experiments regarding the utilization of pixie dust for achieving energy efficiency in electrical circuits were presented. There is a minor incompleteness in the presentation of results, but given the nature of the topic, it is understandable.}
{Závěrečná práce splňuje zadání a dokonce ho rozšiřuje o nové a originální aspekty. Byly předloženy důkladné analýzy a experimenty týkající se využití vílího prachu k dosažení energetické účinnosti v elektrických obvodech. Existuje malá nekompletnost v prezentaci výsledků, ale vzhledem k povaze tématu je to pochopitelné.}
}

\newcommand{\DeleteMeAndFillYourOwnCommentAboutMethodology}{
\langsw{The student chose an appropriate approach and methods in solving the final thesis. They employed a systematic approach to analyze pixie dust and its potential in enhancing the energy efficiency of electrical circuits. The student proceeded methodically during experiments and evaluation of results, leading to objective assessments and acquiring relevant knowledge. Their approach was innovative and daring, which is particularly important in this magical realm. Overall, it can be concluded that the chosen approach contributed to the enrichment and originality of this final thesis.}{Student zvolil při řešení závěrečné práce vhodný postup a metody. Využil systematický přístup k analýze vílího prachu a jeho potenciálu v energetické účinnosti elektrických obvodů. Postupoval metodicky při experimentech a vyhodnocování výsledků, což přispělo k objektivnímu hodnocení a získání relevantních poznatků. Přístup studenta byl inovativní a odvážný, což je v této magické oblasti zvláště důležité. Celkově lze konstatovat, že zvolený postup řešení přispěl k obohacení a originalitě této závěrečné práce.}
}

\newcommand{\DeleteMeAndFillYourOwnCommentAboutActivity}{
\langsw{The student demonstrated a high level of activity and independence in the process of working on this thesis. They consulted regularly with their supervisor and were well-prepared for discussions. Their ability for independent and creative work is excellent.}
{Student projevil vysokou míru aktivity a samostatnosti při zpracování této práce. Konzultoval průběžně s vedoucím práce a byl připraven na diskuse. Jeho schopnost samostatné tvůrčí práce je vynikající.}
}

\newcommand{\DeleteMeAndFillYourOwnCommentAboutTechnicalLevel}{
\langsw{The thesis achieves a high level of expertise. The student utilized their knowledge acquired through studies and professional literature, effectively incorporating it with magical elements. They also succeeded in utilizing relevant practical sources, which enhances the value of their work.}
{Závěrečná práce dosahuje vysoké odborné úrovně. Student využil své znalosti získané studiem i odborné literatury a dokázal je uplatnit ve spojení s magickými prvky. Podařilo se mu také využít relevantních pramenů z praxe, což zvyšuje hodnotu jeho práce.}
}

\newcommand{\DeleteMeAndFillYourOwnCommentAboutFormalLevel}{
\langsw{The formal and linguistic quality of the thesis is excellent. The student correctly employed formal writing conventions and expressed themselves clearly and comprehensibly. The scope of the work is sufficient and in line with requirements.}
{Formální a jazyková úroveň práce je výborná. Student správně použil formální zápisy a vyjádřil se jasně a srozumitelně. Rozsah práce je dostatečný a v souladu s požadavky.}
}

\newcommand{\DeleteMeAndFillYourOwnCommentAboutSelectionOfSources}{
\langsw{The student showed excellent activity in acquiring and utilizing study materials. The selection of sources is diverse and relevant to the topic. Citations are properly executed, adhering to citation ethics and norms. The thesis includes complete bibliographic references, and the student demonstrated the ability to critically evaluate and incorporate available sources into their research.}
{Student projevil výbornou aktivitu při získávání a využívání studijních materiálů. Výběr pramenů je rozmanitý a relevantní pro dané téma. Citace jsou správně provedeny a dodrženy citační etiky a normy. V práci jsou uvedeny kompletní bibliografické citace a student projevil schopnost kriticky vyhodnotit a začlenit dostupné zdroje do svého výzkumu.}
}

\newcommand{\DeleteMeAndFillYourOwnAdditionalComments}{
\langsw{You may hide this section (as comment).}{Tuto sekci je možné zakomentovat.}
}

\newcommand{\DeleteMeAndFillYourOwnOverallComment}{\langsw{This thesis is an outstanding example of creativity, combining unconventional approaches with technical know-how. The student showcased a deep understanding of the subject matter and presented new and innovative ways of harnessing pixie dust in electrical circuits. Questions that the student should address during their defense could focus on technical details of the experiments and potential applications of this magical approach in the real world.

\vspace{10pt}
\noindent \textbf{Questions}:
\begin{itemize}
    \item What was the ratio of woodland and water pixies during the tests?
    \item What are the reasons for not fulfilling assignment task (f)?
    \item Why is there a lack of discussion regarding this matter in the text?
\end{itemize}
}{Tato závěrečná práce je skvělým příkladem kreativity, spojení nekonvenčních přístupů a technického know-how. Student předvedl hluboké porozumění danému tématu a představil nové a inovativní způsoby využití vílího prachu v elektrických obvodech. Otázky, které by student měl zodpovědět při obhajobě, by se mohly zaměřit na technické detaily experimentů a případné aplikace této magické metody v reálném světě.

\vspace{10pt}
\noindent \textbf{Otázky k obhajobě}:
\begin{itemize}
    \item Jaký byl poměr lesních a vodních víl bylo během testů?
    \item Proč není splněna část zadání (bod g)?
    \item Proč tato skutečnost není diskutována v textu?
\end{itemize}
}
}

\newcommand{\DeleteMeAndInsertYourDepartment}{
\langsw{Department of Mystical Enchantments and Wacky Wizardry}{Katedra mystických čar a blázniho čarodějnictví}
}

\newcommand{\DeleteMeAndInsertDepartmentAccordingToAssignment}{
\langsw{Department of Elfs and Hobits}{Katedra trpaslíků a permoníků}
}

\newcommand{\DeleteMeAndInsertThesisTitle}{
\langsw{Harnessing the Power of Pixie Dust: A Magical Approach to Energy Efficiency in Electrical Circuits}{Využití síly vílího prachu: Magický přístup k energetické účinnosti v elektrických obvodech}
}

\newcommand{\DeleteMeAndInsertThesisAuthorName}{
\langsw{Bc. Bytebinder Lumoswitch}{Bc. Božetěch Síťopoutník}
}

\newcommand{\DeleteMeAndInsertYourName}{
\langsw{prof. Ing. Spells-a-Lot Bumbleboots Ph.D.}{prof. Ing. Balthazar Zářeplápol Ph.D.}
}
