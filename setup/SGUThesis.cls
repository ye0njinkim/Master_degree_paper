% -*- TeX:UTF-8 -*-
%%  서강대학교 석·박사 학위논문 LaTeX 템플릿
%%
%%           버전: 1.0.0
%%
%%         작성자: 고재현 (contact@jhko.dev)
%%           날짜: 2023. 12. 18
%%    마지막 갱신: 2024. 01. 10
%%
%%  필요한 패키지: TeXLive 2013 or later + ko.TeX, or XeLaTeX
%%
%%       참고자료: KAIST Thesis Templete for LaTeX version 0.4, https://github.com/KUNPL/KUThesis
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  여러분의 참여가 이 템플릿을 더욱 완벽하게 만들 수 있습니다. 
%%
%%         https://github.com/IIP-Sogang/SGU_thesis_template
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{SGUThesis}

%% 옵션 선언을 위한 변수 선언
\newif\if@isDoctor
\newif\if@isFinal
\newif\if@isPdfdoc
\newif\if@isDebug
\newif\if@isTwosides
\newif\if@isLongDeptName
\newif\if@isTOCHeader
\newif\if@isContentHeader
\newif\if@isBibHeader
\newif\if@isKrabst
\newif\if@isKrack
\newif\if@isAsym

%% 새 옵션 모음 - doctor|master, final|draft
\DeclareOption{doctor}       {\@isDoctortrue}
\DeclareOption{master}       {\@isDoctorfalse}
\DeclareOption{final}        {\@isFinaltrue}
\DeclareOption{pdfdoc}       {\@isPdfdoctrue}
\DeclareOption{debug}        {\@isDebugtrue}
\DeclareOption{twosides}     {\@isTwosidestrue}
\DeclareOption{oneside}      {\@isTwosidesfalse}
\DeclareOption{krabst}       {\@isKrabsttrue}
\DeclareOption{krack}        {\@isKracktrue}
\DeclareOption{asym}         {\@isAsymtrue}

%% leqno,fleqn,openbib 옵션은 그대로 report 클래스에 전달
\DeclareOption{leqno}  {\PassOptionsToClass{leqno}  {report}}
\DeclareOption{fleqn}  {\PassOptionsToClass{fleqn}  {report}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{report}}

%% doctor,draft,twoside가 기본값
\@isDoctortrue
\@isFinalfalse
\@isTwosidestrue
\@isLongDeptNamefalse
\@isTOCHeaderfalse
\@isContentHeaderfalse
\@isBibHeaderfalse
\@isKrabstfalse
\@isKrackfalse
\@isAsymfalse
\ProcessOptions

%% 11pt,onecolumn,oneside 옵션으로 report 클래스 불러오기
\if@isTwosides
  \LoadClass[11pt,onecolumn,twoside,openright]{report}
\else
  \LoadClass[11pt,onecolumn,oneside]{report}
\fi


%% 여백 체크용 디버그 옵션
\if@isDebug
  \usepackage[a4,frame,center]{crop}
\fi

%% Table of contents, List of figures, List of tables를 Table of Contents에 추가
\usepackage{tocbibind}


%% 편집용지 설정 (4x6 배판 - 190x260 mm2)
% \if@isAsym
%   \usepackage[inner = 25mm ,       outer = 15mm,
%                 top = 30mm,       bottom = 30mm,
%          paperwidth = 190mm, paperheight = 260mm]{geometry}
% \else
%   \usepackage[inner = 20mm ,       outer = 20mm,
%                 top = 30mm,       bottom = 30mm,
%          paperwidth = 190mm, paperheight = 260mm]{geometry}
% \fi
\if@isAsym
  \usepackage[inner = 25mm ,       outer = 15mm,
                top = 30mm,       bottom = 30mm,
         paperwidth = 190mm, paperheight = 260mm]{geometry}
\else
  \usepackage[inner = 20mm ,       outer = 20mm,
                top = 30mm,       bottom = 30mm,
         paperwidth = 190mm, paperheight = 260mm]{geometry}
\fi

%% 들여쓰기
\usepackage{indentfirst}
\setlength\parindent{0em}

%% Figure와 Caption사이 거리 조정
\setlength{\abovecaptionskip}{10pt} % 캡션 위 거리
\setlength{\belowcaptionskip}{0pt}  % 캡션 아래 거리

%% bibliography
\usepackage[square,numbers]{natbib}
\bibliographystyle{ieeetr}

\RequirePackage{ifthen}       % 추가 패키지 설정
\RequirePackage[strict]{changepage}
\RequirePackage{emptypage}
\RequirePackage{graphicx,xcolor}
\RequirePackage[toc,page]{appendix}
\RequirePackage{amsmath,amssymb,textcomp,bm}
\RequirePackage[pagewise]{lineno}
\RequirePackage{fix-cm}
\RequirePackage[cjk]{kotex}
\RequirePackage[nomessages]{fp}
\RequirePackage{fancyhdr}
\RequirePackage{pdfpages}
\RequirePackage{multirow}

%% Caption의 줄간격 설정
\RequirePackage{caption,setspace}
\captionsetup[table]{font={stretch=\@captionLineSpacing}}
\captionsetup[figure]{font={stretch=\@captionLineSpacing}}


%% PDF 파일로 문서를 만들었을 때 링크 활성화
\if@isPdfdoc
  \RequirePackage[unicode,%
       pageanchor=false,%
           pdftex=true,%
        bookmarks=true,%
       colorlinks=true%
    ]{hyperref}
\else
\fi

\newcounter{dummy}
\AfterEndPreamble{%                         % \begin{document}와 함께 실행
  \checkparameters                         % 문서 변수가 올바른지 점검
  \newgeometry{       left = 40mm,
                     right = 30mm,
                       top = 30mm,
                    bottom = 40mm}        % 여백 다른 페이지용 여백
  \makefrontcover                          % 앞표지 생성
  \maketitle                               % 속표지 생성
  \if@isFinal                              % final 옵션이 지정되어 있으면
    \newgeometry{       left = 40mm,
                       right = 30mm,
                         top = 40mm,
                      bottom = 40mm}        % 여백 다른 페이지용 여백
    \makeapproval                          % 제출승인서, 심사완료검인 생성
  \else
    \linenumbers
  \fi 
  \restoregeometry                         % 여백 되돌림
  

  \pagenumbering{roman}
  \setcounter{page}{1}
  \makecontents
  
%   \refstepcounter{dummy}
  \makeabstract                            % 초록 페이지 생성
  
  \if@isFinal
    % \refstepcounter{dummy}
    \if@isKrabst                           % 초록 페이지 생성(한글)
      \makekrabstract
    \fi
    % \makeacknowledgement
  \fi

  \pagenumbering{arabic}
  \setcounter{page}{1}
  
  \renewcommand{\arraystretch}{1.3}
  
  
}

\AtEndDocument{                             % \end{document}와 함께 실행
  \bibliography{library.bib}
  \addevenpage

  
}

%% 서강대학교 공식 영문명칭
\newcommand{\@soganguniv}{Sogang University}

% @command title 논문 제목
\renewcommand{\title}[3] {
  \ifnum#1=3
    \newcommand{\@titleSize}{19pt}  % 원래 19
    \newcommand{\@univSize}{18pt}  % 원래 18
  \else
    \ifnum#1=2
      \newcommand{\@titleSize}{21pt}  % 원래 21 
      \newcommand{\@univSize}{18pt}   % 원래 18
    \else
      \ifnum#1=0
        \newcommand{\@titleSize}{30pt}  % 원래 30
      \else
        \newcommand{\@titleSize}{28pt} % 원래 28
      \fi
      \newcommand{\@univSize}{20pt}  % 원래 20
    \fi
  \fi
  \newcommand{\@titleEng}{#2}
  \newcommand{\@titleKor}{#3}
}
\@onlypreamble{\title}

% @command author 저자 이름
% @param family_name, given_name 성, 이름을 구분해서 입력
% @options [default: (none)]
% - korean: 한글이름 | chinese: 한문이름 | english: 영문이름
\renewcommand{\author}[4][chinese] {%
    \ifthenelse{\equal{#1}{chinese}}
        {\newcommand{\@authorChnF}{#2}
         \newcommand{\@authorChnS}{#3}
         \newcommand{\@authorChnT}{#4}
         \ifthenelse{\equal{#4}{}}{
           \newcommand{\@authorChn}{#2#3}
         }{
           \newcommand{\@authorChn}{#2#3#4}
         }{}%
         \ifthenelse{\equal{#4}{}}{
           \newcommand{\@authorChnSpace}{#2\ #3}
         }{
           \newcommand{\@authorChnSpace}{#2\ #3\ #4}
         }}{}%
    \ifthenelse{\equal{#1}{english}}
        {\newcommand{\@authorEngFN}{#2}
         \newcommand{\@authorEngGN}{#3}
         \ifthenelse{\equal{#4}{}}{
           \newcommand{\@authorEng}{#3\ #2}
         }{
           \newcommand{\@authorEng}{#3\ #4\ #2}
         }}{}%
    \ifthenelse{\equal{#1}{korean}}
        {\newcommand{\@authorKor}{#2}
         }{}%
}
\@onlypreamble{\author}

% 현재는 주 지도교수만 지원
% @command advisor 지도교수 이름 (복수가능)
% @options [default: major]
% - major: 주 지도교수  | coopr: 부 지도교수 (공동지도교수 경우)
\newcommand{\advisor}[3]{%
  \newcommand{\@advisorMajorKor}{#1}  % 한글이름 저장
  \newcommand{\@advisorMajorChn}{#2}  % 영문이름 저장
  \newcommand{\@advisorMajorEng}{#3}  % 영문이름 저장
}
\@onlypreamble{\advisor}

\if@isDoctor
  \newcommand{\@degreeChn}{博}
  \newcommand{\@degreeEng}{Doctor of Philosophy}
\else
  \newcommand{\@degreeKor}{석사}
  \newcommand{\@degreeChn}{碩}
  \newcommand{\@degreeEng}{Master}
\fi

% @command department 
%
\newcommand{\department}[2] {%
      \ifthenelse{\equal{#1}{AI}}
        {\newcommand{\@deptNameEng}{Artificial Intelligence}
        \newcommand{\@deptNameChn}{人\ 工\ 知\ 能}
        \newcommand{\@deptNameKor}{인공지능학과}
        \newcommand{\@deptNameShort}{}
        \newcommand{\@degreeName}{공학}} {}
      \ifthenelse{\equal{#1}{EE}}
        {\newcommand{\@deptNameEng}{Electronic Engineering}
         \newcommand{\@deptNameChn}{物\ 理\ 學\ 科}
         \newcommand{\@deptNameKor}{전자공학과}
         \newcommand{\@deptNameShort}{}
         \newcommand{\@degreeName}{공학}} {}
    \ifthenelse{\equal{#1}{PH}}
        {\newcommand{\@deptNameEng}{Physics}
         \newcommand{\@deptNameChn}{物\ 理\ 學\ 科}
         \newcommand{\@deptNameKor}{물리학과}
         \newcommand{\@deptNameShort}{物理學}
         \newcommand{\@degreeName}{理學}} {}
    \ifthenelse{\equal{#1}{CSE}}
        {\newcommand{\@deptNameEng}{Computer Science Engineering}
         \newcommand{\@deptNameChn}{컴\ 퓨\ 터\ 學\ 科}
         \newcommand{\@deptNameKor}{컴퓨터학과}
         \newcommand{\@deptNameShort}{컴퓨터學}
         \newcommand{\@degreeName}{공학}} {}
}
\@onlypreamble{\department}

% @command referee 심사위원 (석사과정 3인, 박사과정 5인)
\newcommand{\referee}[2][1] {%
    \ifthenelse{\equal{#1}{1}}{\newcommand{\@refereeChief} {#2}} {}%
    \ifthenelse{\equal{#1}{2}}{\newcommand{\@refereeSecond}{#2}} {}%
    \ifthenelse{\equal{#1}{3}}{\newcommand{\@refereeThird} {#2}} {}%
    \ifthenelse{\equal{#1}{4}}{\newcommand{\@refereeFourth}{#2}} {}%
    \ifthenelse{\equal{#1}{5}}{\newcommand{\@refereeFifth} {#2}} {}%
}
\@onlypreamble{\referee}

% @command graduateDate 졸업년월
\newcommand{\graduateDate}[2]{
  \newcommand{\@graduateYear}{#1}
  \newcommand{\@graduateMonth}{#2}
}
\@onlypreamble{\graduateDate}

% @command submitDate 제출일자
\newcommand{\submitDate}[3]{
  \newcommand{\@submitYear}{#1}
  \newcommand{\@submitMonth}{#2}
  \newcommand{\@submitDay}{#3}
}
\@onlypreamble{\submitDate}

% @command abstractLineSpacing 초록 줄간격
\newcommand{\abstractLineSpacing}[1]{
  \FPeval{\@abstractLineRatio}{#1/100.0/1.236} 
}
\@onlypreamble{\abstractLineSpacing}

% @command krAbstractLineSpacing 국문초록 줄간격
\newcommand{\krAbstractLineSpacing}[1]{
  \FPeval{\@krAbstractLineRatio}{#1/100.0/1.236} 
}
\@onlypreamble{\krAbstractLineSpacing}

% @command TOCLineSpacing 목차 줄간격
\newcommand{\TOCLineSpacing}[1]{
  \FPeval{\@TOCLineRatio}{#1/100.0/1.236} 
}
\@onlypreamble{\TOCLineSpacing}

% @command contentLineSpacing 본문 줄간격
\newcommand{\contentLineSpacing}[1]{
  \FPeval{\@lineRatio}{#1/100.0/1.236} 
}
\@onlypreamble{\contentLineSpacing}

% @command acknowledgementLineSpacing 감사의글 줄간격
\newcommand{\acknowledgementLineSpacing}[1]{
  \FPeval{\@acknowledgementLineRatio}{#1/100.0/1.236} 
}
\@onlypreamble{\acknowledgementLineSpacing}

% @command captionLineSpacing 캡션 줄간격
\newcommand{\captionLineSpacing}[1]{
  \FPeval{\@captionLineSpacing}{#1/100.0/1.236} 
}
\@onlypreamble{\captionLineSpacing}

% @command addTOCHeader TOC, LOF, LIT에 헤더 추가
\newcommand{\addTOCHeader} {
  \@isTOCHeadertrue
}
\@onlypreamble{\addTOCHeader}

% @command addContentHeader 본문에 헤더 추가
\newcommand{\addContentHeader} {
  \@isContentHeadertrue
}
\@onlypreamble{\addContentHeader}

% @command addBibHeader 참고문헌에 헤더 추가
\newcommand{\addBibHeader} {
  \@isBibHeadertrue
}
\@onlypreamble{\addBibHeader}

% @command 본문 추가
\newcommand{\addContents}[1]{
  \setlength\parindent{5mm}
  \if@isContentHeader
    \pagestyle{fancy}
    \fancyhf{}
    \fancyhead[LE]{\nouppercase\leftmark}
    \fancyhead[RO]{\nouppercase\rightmark}
    \fancyfoot[CE,CO]{\thepage}
  \fi
  \renewcommand{\baselinestretch}{\@lineRatio}
  \selectfont{\input{#1}}
  \setlength\parindent{0mm}
}

% @command appendix 추가
\newcommand{\addAppendix}[1]{
  \setlength\parindent{5mm}
  \if@isContentHeader
    \pagestyle{fancy}
    \fancyhf{}
    \fancyhead[LE]{\nouppercase\leftmark}
    \fancyhead[RO]{\nouppercase\rightmark}
    \fancyfoot[CE,CO]{\thepage}
  \fi
  \renewcommand{\baselinestretch}{\@lineRatio}
  \selectfont{\input{#1}}
  \setlength\parindent{0mm}
}


%%
%% 필요한 정보 중에 누락된 것이 없는지 점검
%%
\newcommand{\checkparameters}{%
    \@ifundefined{@titleEng}{%
        \ClassError{SGUThesis}{The English title is not found}{}}{}
    \@ifundefined{@titleKor}{%
        \ClassError{SGUThesis}{The English title is not found}{}}{}
    \@ifundefined{@authorKor}{%
        \ClassError{SGUThesis}{The Korean name of the author is not found}{}}{}
    \@ifundefined{@authorChn}{%
        \ClassError{SGUThesis}{The Chinese name of the author is not found}{}}{}
    \@ifundefined{@authorEng}{%
        \ClassError{SGUThesis}{The English name of the author is not found}{}}{}
    \@ifundefined{@advisorMajorKor}{%
        \ClassError{SGUThesis}{The Korean name of the major advisor is not found}{}}{}
    \@ifundefined{@advisorMajorEng}{%
        \ClassError{SGUThesis}{The English name of the major advisor is not found}{}}{}
    \@ifundefined{@advisorMajorChn}{%
        \ClassError{SGUThesis}{The Chinese name of the major advisor is not found}{}}{}
}

%%
%% 영문 날짜 표기
%%
\newcommand{\@dateUSenglish}[2]{%  % 미국식 날짜 표기
    \newcommand{\@year}{#1}%
    \newcommand{\@month}{#2}%
    \ifcase\@month \or
        January \or February \or March \or April \or May \or June \or
        July \or August \or September \or October \or November \or December \fi
    \@year
}

%%
%% 빈 페이지 생성
%%
\newcommand{\emptypage}{
  \newpage
  \thispagestyle{empty}
  \hbox{ }
  \newpage
}

%%
%% 양면 출력일 때 홀수 페이질 경우 빈 페이지 추가
%%
\newcommand{\addevenpage}{
  \if@isTwosides
    \checkoddpage
    \ifoddpage
      \emptypage
    \fi
  \else
    \newpage
  \fi
}

%%
%% 앞표지 생성
%%
\if@isDoctor
\newcommand{\makefrontcover}{%
    \newpage
    \renewcommand{\baselinestretch}{1.3}%
    \thispagestyle{empty}
    \begin{minipage}[t][12mm][t]{112mm}
        \begin{center}
            \fontsize{13pt}{13pt}\selectfont\bf{Thesis for the Degree of \@degreeEng}
        \end{center}
    \end{minipage}\\[30mm]
    \hspace*{-15mm}
    \begin{minipage}[t][50mm][t]{142mm}
        \begin{center}
            \fontsize{\@titleSize}{\@titleSize}\selectfont{\bf \@titleEng}
        \end{center}
    \end{minipage}\vfill
    \begin{minipage}[b][85mm][b]{112mm}
        \begin{center}
            \fontsize{16pt}{16pt}\selectfont{\bf \@dateUSenglish{\@graduateYear}{\@graduateMonth}}
            \\[40mm]
            \fontsize{16pt}{16pt}\selectfont{\bf Department of \@deptNameEng}
            \\[4mm]
            \fontsize{16pt}{16pt}\selectfont{\bf Graduate School, \@soganguniv}
            \\[4mm]
            \fontsize{16pt}{16pt}\selectfont{\bf \@authorEng}
        \end{center}
    \end{minipage}
    \addevenpage
}
\else % 석사학위 논문의 경우 양식에 맞게 수정
\newcommand{\makefrontcover}{%
    \newpage
    \renewcommand{\baselinestretch}{1.3}%
    \thispagestyle{empty}
    % \begin{minipage}[t][12mm][t]{112mm}
    %     \begin{center}
    %         \fontsize{13pt}{13pt}\selectfont\bf{Thesis for the Degree of \@degreeEng}
    %     \end{center}
    % \end{minipage}\\[30mm]
    \hspace*{-15mm}
    \begin{minipage}[t][80mm][t]{142mm}
    \vspace*{30mm}
        \begin{center}
            \fontsize{\@titleSize}{\@titleSize}\selectfont{\bf \@titleEng}
        \end{center}
    \end{minipage}\vfill
    \begin{minipage}[b][85mm][b]{112mm}
        \begin{center}
            \fontsize{16pt}{16pt}\selectfont{\bf \@dateUSenglish{\@graduateYear}{\@graduateMonth}}
            \\[40mm]
            \fontsize{16pt}{16pt}\selectfont{\bf Department of \@deptNameEng}
            \\[4mm]
            \fontsize{16pt}{16pt}\selectfont{\bf Graduate School, \@soganguniv}
            \\[4mm]
            \fontsize{16pt}{16pt}\selectfont{\bf \@authorEng}
        \end{center}
    \end{minipage}
    \addevenpage
}
\fi
%%
%% 속표지 생성
%%
\renewcommand{\maketitle}{%
    \newpage
    \renewcommand{\baselinestretch}{1.3}%
    \thispagestyle{empty}
    \hspace*{-15mm}\begin{minipage}[t][16pt][t]{142mm}
      \begin{center}
        % \\[10mm]
        \fontsize{\@titleSize}{\@titleSize}\selectfont{\@titleEng}
        \\[15mm]
        \fontsize{16pt}{16pt}\selectfont{Advisor : Prof. \@advisorMajorEng}
      \end{center}
    \end{minipage}\vfill
    \begin{minipage}[b][50mm][b]{112mm}
      \begin{center}
        \fontsize{16pt}{16pt}\selectfont{A thesis submitted in partial fulfillment of the requirements for the degree of {\@degreeEng} in {\@deptNameEng}}
        \\[45mm]
        \fontsize{16pt}{16pt}\selectfont{\@dateUSenglish{\@graduateYear}{\@graduateMonth}}
        \\[20mm]
        \fontsize{16pt}{16pt}\selectfont{Department of \@deptNameEng}
        \\[4mm]
        \fontsize{16pt}{16pt}\selectfont{Graduate School, \@soganguniv}
        \\[4mm]
        \fontsize{16pt}{16pt}\selectfont{\@authorEng}
    \end{center}
    \end{minipage}
    \addevenpage
}

%%
%% 학위논문 심사완료 검인서 생성
%%
\newcommand{\approvalScan}[1]{%
  \newcommand{\@scanFile}{#1}
}
%% todo: 학교에 맞게 수정
\newcommand{\makeapproval}{%
  \@ifundefined{@scanFile}
  {
    \newpage
    \thispagestyle{empty}
    \renewcommand{\baselinestretch}{1.3}
    \begin{minipage}[t][80mm][t]{142mm}
      \vspace*{30mm}
          \begin{center}
              \fontsize{\@titleSize}{\@titleSize}\selectfont{\bf \@titleKor}
              논 문 인 준 서
          \end{center}
      \end{minipage}\vfill
      \begin{minipage}[t][20mm][t]{112mm}
      \begin{center}
        \fontsize{15.5pt}{15.5pt}\selectfont{\bf {\@authorKor}의 \@degreeName{\@degreeKor} 학위논문을 인준함}
        \\[30mm]
        \fontsize{14pt}{14pt}\selectfont{\bf {\@submitYear}년 {\@submitMonth}월}
        \\[20mm]
        \underline{
          \fontsize{16pt}{16pt}\selectfont{\bf 주심}
          \fontsize{14pt}{14pt}\selectfont{\hspace{60mm}\bf (印)}
        }
        \\[10mm]
        \underline{
          \fontsize{16pt}{16pt}\selectfont{\bf 부심}
          \fontsize{14pt}{14pt}\selectfont{\hspace{60mm}\bf (印)}
        }
        \\[10mm]
        \underline{
          \fontsize{16pt}{16pt}\selectfont{\bf 부심}
          \fontsize{14pt}{14pt}\selectfont{\hspace{60mm}\bf (印)}
        }
        \if@isDoctor
          \\[10mm]
          \underline{
            \fontsize{16pt}{16pt}\selectfont{\bf 부심}
            \fontsize{14pt}{14pt}\selectfont{\hspace{60mm}\bf (印)}
          }
          \\[10mm]
          \underline{
            \fontsize{16pt}{16pt}\selectfont{\bf 부심}
            \fontsize{14pt}{14pt}\selectfont{\hspace{60mm}\bf (印)}
          }
        \else\fi
      \end{center}
    \end{minipage}
    \addevenpage
  }{
    \includepdf{\@scanFile}
    \if@isTwosides
      \emptypage
    \fi
  }
}

%%
%% 초록 페이지 생성
%%
\newcommand{\makeabstract}{%
  \newpage
%   \thispagestyle{empty}
  \addcontentsline{toc}{chapter}{Abstract}
%   \pagenumbering{gobble}
%   \vspace*{\fill}
  \begin{center}
    \fontsize{16pt}{16pt}\selectfont{\bf Abstract}
  \end{center}

  \setlength\parindent{5mm}
  \renewcommand{\baselinestretch}{\@abstractLineRatio}\selectfont
  \fontsize{11pt}{12pt}\selectfont{\indent\input{covers/abstract.tex}}
  \setlength\parindent{0mm}
  \vspace*{\fill}
  \addevenpage
}



%%
%% 한국어 초록 페이지 생성
%%
\newcommand{\makekrabstract}{%
  \newpage
%   \thispagestyle{empty}
  \addcontentsline{toc}{chapter}{국문초록}
%   \pagenumbering{gobble}
  \begin{center}
    \fontsize{16pt}{16pt}\selectfont{\bf \@titleKor}
  \end{center}

  \fontsize{12pt}{15pt}\selectfont
  \begin{tabular}{rl}
  이름: & \@authorKor \\
  학과: & \@deptNameKor \\
  지도교수: & \@advisorMajorKor
  \end{tabular}
  \vspace*{1cm}

  \setlength\parindent{5mm}
  \renewcommand{\baselinestretch}{\@krAbstractLineRatio}\selectfont
  \fontsize{11pt}{12pt}\selectfont{\indent\input{covers/krabstract}}
  \setlength\parindent{0mm}
  \vspace*{\fill}
  \addevenpage
}

%%
%% 목차 일괄 생성
%%
\newcommand{\makecontents}{%            % TOC, LOT, LOF 생성
  \if@isTOCHeader
    \pagestyle{fancy}
    \fancyhf{}
    \fancyhead[LE]{\nouppercase\leftmark}
    \fancyhead[RO]{\nouppercase\leftmark}
    \fancyfoot[CE,CO]{\thepage}
  \fi
  \renewcommand{\baselinestretch}{\@TOCLineRatio}\selectfont
  \tableofcontents
  \addevenpage
  \listoffigures
  \addevenpage
  \listoftables
  \addevenpage
  \clearpage
}


% %%
% %% 감사의 글 페이지 생성
% %%
\newcommand{\makeacknowledgement}{%
  \newpage
  \thispagestyle{empty}
  \if@isKrack
    \addcontentsline{toc}{chapter}{감사의 글}
  \else
    \addcontentsline{toc}{chapter}{covers/Acknowledgement}
  \fi
  \pagenumbering{gobble}
  \begin{center}
    \if@isKrack
      \fontsize{16pt}{16pt}\selectfont{\bf 감사의 글}
    \else
      \fontsize{16pt}{16pt}\selectfont{\bf Acknowledgement}
    \fi
  \end{center}
  \vspace{5mm}

  \setlength\parindent{5mm}
  \renewcommand{\baselinestretch}{\@acknowledgementLineRatio}\selectfont
  \fontsize{11pt}{12pt}\selectfont{\indent\input{covers/acknowledgement}}
  \setlength\parindent{0mm}
  \addevenpage
}


