create database DEVELOPER_BOARD;
drop database DEVELOPER_BOARD;
use DEVELOPER_BOARD;

-- 테이블 utf-8 설정
ALTER TABLE tblAttend convert to charset UTF8;

-- 기본키 자동증가 초기화
delete from tblCategory;
ALTER TABLE tblCategory AUTO_INCREMENT=1;

-- tblMember
create table tblMember(                                                                                                                                                                                                                                                                                                                    
    mseq int auto_increment primary key,
    name varchar(30) not null,
    tel varchar(30) not null,
    email varchar(50) not null,
    id varchar(30) not null,
    pw varchar(30) not null,
    lv int default 1 not null,          -- (1~3)1주니어 (4~6)2중급 (7~)3시니어
    active char(1) default 'y' not null,
    mfile longblob default 'default.jpg' not null
);

-- tblCommunity
create table tblCommunity (  
    cseq int auto_increment primary key,
    title varchar(300) not null,
    content varchar(4000) not null,
    file longblob,
    mseq int not null,
    foreign key (mseq) references tblMember(mseq) on delete cascade, 
    regdate datetime default current_timestamp() not null,
    count int default 0 not null
);

-- tblComment
create table tblComment ( 
    ccseq int auto_increment primary key,
    ccontent varchar(100) not null,
    mseq int not null,
    foreign key (mseq) references tblMember(mseq) on delete cascade,  
    regdate datetime default current_timestamp() not null,
    ref int not null,
    foreign key (ref) references tblCommunity(cseq) on delete cascade,  
    step int default 1 not null,
    depth int default 0 not null
);

-- tblCategory
create table tblCategory ( 
    caseq int auto_increment primary key,
    cname varchar(30) not null,
    color varchar(15) not null
); 

-- tblPlace
create table tblPlace ( 
    pseq int auto_increment primary key,
    place varchar(30) not null,
    lat double(10,6) not null,
    log double(10,6) not null
);

-- tblStudy
create table tblStudy ( 
    sseq int auto_increment primary key,
    caseq int not null,
    foreign key (caseq) references tblCategory(caseq) on delete cascade,  
    pseq int not null,
    foreign key (pseq) references tblPlace(pseq) on delete cascade, 
    sname varchar(50) not null, 
    intro varchar(1000), 
    rcount int not null,
    time varchar(30) not null,
    day varchar(30) not null,
    week varchar(20) not null,
    file longblob default 'default.png' not null
);

-- tblJjim
create table tblJjim ( 
    jseq int auto_increment primary key,
    mseq int not null,
    foreign key (mseq) references tblMember(mseq) on delete cascade,  
    sseq int not null,
    foreign key (sseq) references tblStudy(sseq) on delete cascade
);

-- tblNote
create table tblNote ( 
    nseq int auto_increment primary key,
    caseq int not null,
    foreign key (caseq) references tblCategory(caseq) on delete cascade,  
    mseq int not null,
    foreign key (mseq) references tblMember(mseq) on delete cascade, 
    ntitle varchar(100) not null, 
    stitle varchar(200), 
    scontent varchar(1000),
    nlike int default 0 not null,
    ncheck char(1) default 'y' not null
);

-- tblLike
create table tblLike ( 
    lseq int auto_increment primary key,
    mseq int not null,
    foreign key (mseq) references tblMember(mseq) on delete cascade, 
    nseq int not null,
    foreign key (nseq) references tblNote(nseq) on delete cascade  
);

-- tblApply
create table tblApply ( 
    aseq int auto_increment primary key,
    sseq int not null,
    foreign key (sseq) references tblStudy(sseq) on delete cascade,  
    mseq int not null,
    foreign key (mseq) references tblMember(mseq) on delete cascade, 
    lv int default 1 not null
);

-- tblAttend
create table tblAttend ( 
    atseq int auto_increment primary key,
    aseq int not null,
    foreign key (aseq) references tblApply(aseq) on delete cascade,  
    day datetime default current_timestamp() not null,
    aactive int default 1 not null
);


drop table tblMember;
drop table tblCommunity;
drop table tblComment;
drop table tblCategory;
drop table tblPlace;
drop table tblStudy;
drop table tblJjim;
drop table tblNote;
drop table tblLike;
drop table tblApply;
drop table tblAttend;

delete from tblMember;

-- tblMember
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(1, '김설화', '010-6289-0859', 'tjfghkcjsrnr@naver.com', 'seol12', 'qwer12!'', 1, 'Y', 'default.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(2, '이형원', '010-1019-6313', 'ebhv660@gamil.com', 'nqis11', 'xxvl68&', 2, 'Y', 'member01.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(3, '고동우', '010-5480-5017', 'igvp682@outlook.com', 'texu47', 'bjdj73@', 3, 'Y', 'member02.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(4, '복현주', '010-2102-3243', 'ygbc790@ gamil.com', 'zbys26', 'itvd51@', 3, 'Y', 'default.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(5, '백세웅', '010-7966-4528', 'tkhm972@daum.net', 'vsxd58', 'czeq87!', 2, 'Y', 'default.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(6, '박용환', '010-3861-5915', 'fmjr100@ gamil.com', 'orbv25', 'vwsz16@', 3, 'Y', 'member03.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(7, '문다은', '010-1353-6378', 'telx281@daum.net', 'ammg45', 'jcwk97@', 3, 'Y', 'member04.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(8, '권미연', '010-3786-2705', 'xcsm277@naver.com', 'gpad57', 'yweb91&', 1, 'Y', 'member05');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(9, '문은혜', '010-1287-2167', 'zonn842@daum.net', 'hwfa63', 'tdkj28&', 2, 'Y', 'default.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(10, '설선빈', '010-9943-8892', 'idze376@daum.net', 'wzsr62', 'ktts33!', 2, 'Y', 'default.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(11, '봉지성', '010-3622-1967', 'hpas771@ gamil.com', 'mdvn76', 'mpap15&', 1, 'Y', 'default.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(12, '풍형수', '010-6837-8185', 'wcpx766@ outlook.com', 'ksxo53', 'dfth75!', 2, 'Y', ' member06.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(13, '사공은희', '010-7096-4111', 'lqif340@icloud.com', 'ofzv31', 'gicd43!', 3, 'Y', 'member07.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(14, '홍천희', '010-3128-5758', 'dlwg531@ naver.com', 'cgnn30', 'naky66@', 2, 'Y', 'member08.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(15, '추명희', '010-3875-4748', 'bdpa391@ gamil.com', 'jowd79', 'sqzk10@', 3, 'Y', 'default.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(16, '임승호', '010-2739-3012', 'ygei372@ outlook.com', 'ybed31', 'dpkn75!', 1, 'Y', 'member09.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(17, '황민아', '010-5424-5016', 'wkyx328@ gamil.com', 'edsr93', 'dchj10@', 2, 'Y', 'default.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(18, '김윤진', '010-9964-9963', 'jqfo130@daum.net', 'lnkz56', 'wnol32&', 3, 'Y', 'default.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(19, '김철진', '010-8615-4893', 'ijwq663@ gamil.com', 'vizi54', 'axtf57!', 2, 'Y', 'member10.jpg');
INSERT INTO tblMember (mseq, name, tel, email, id, pw, lv, active, mfile) VALUES(20, '윤은비', '010-6696-5853', 'fsdt969@daum.net', 'ndml59', 'izhy59&', 1, 'Y', 'default.jpg');

-- tblCommunity
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (1, 1, '확실하게 프로그램 잘 짜는 법..', '어렵지 않습니다...
프로그래머의 본질은 요구사항에 대하여 해결하기 위하여 프로그램을 제작하는 것입니다.
인터넷에 간단한 웹페이지 또는 내 머리속에 있는 서비스를 구상하고 PPT로 그려보고 구현해보면 됩니다.
최근 저는 2개의 개인 프로젝트를 구현완료 했어용 ^^...
하나는 중국 황실달력이라는 프로젝트이고 나머지는 변수명을 지어주는 프로젝트입니다...', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (2, 2, '웹 개발 공부를 처음부터 한다면..?', '디자인 > 업로드 > 카페24에서 코드명만 수정
이렇게 반복했더니 국비 처음 공부하는 사람보다 못..한 수준이 되어버렸습니다
그동안 헬스만 열심히 했더니 몸만 좋아져버린 케이스가 되어버렸네요..
1인 프로젝트를 시작으로 다시 공부하려고 하는데
인프런을 보면서 하는 게 나을까요? 아니면 우선 해보다가 모르는 것만 구글링하는 게 나을까요?', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (3, 3, '기사 자격증', '국비 끝나고 알바를 하면서 공부하고있는데..
면접본곳들이 전부 이제는 기사 자격증은 있어야한다고해서..
방통대 와 학은제 어떤걸해서 따는게 괜찮은지 모르겠습니다.

방통은 4년을 다니고 졸업을 하면 그래도 대졸이라는 타이틀도 붙는데..
정말 고민이 되네요 ㅠㅠ', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (4, 4, '구직중인 신입 개발자인데 몇년째 적자인 스타트업도 괜찮을까요?', '최근 서류를 통과하여 면접제의를 받았습니다. 해당 기업은 시리즈a 투자를 받은 적이 있고 사원 수는 40명 정도 되는 것 같습니다.
다만 최근 3-4년간 적자 폭이 커진 기업입니다.
공고 경쟁률도 정말 높았는데 저는 비전공자인데도 감사하게도 면접에 불러주셨습니다.
하지만 몇 년째 적자인데다 최근 투자 시장이 좋지 않아 추가 투자를 유치하지 못한다면 위기에 놓이는 스타트업들이 많다는 이야기가 심심치않게 들리는데요
헷갈리는 점은 그런데도 불구하고 최근 인원 충원은 꾸준히 이루어지고있는것같습니다.

현재 합격을 받고 입사 일정이 잡힌 기업이 있어 면접에 가야할지 고민이 되는 상황입니다.
혹시 의견이 있으시다면 조언해주신다면 감사할 것 같습니다.', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (5, 5, '컴공 대학 4년제 내년 2월 졸업 예정자입니다. 조언을 얻고 싶네요.', '안녕하세요 컴공 4년제 대학 내년 2월 졸업 예정자인 대학생입니다.
현재 대학교 졸업 서류 제출까지 완료한 상태여서 사실 졸업준비는 끝난 상태인데요
그래서 취업 준비를 하고 있으나 학교에서 했던 프로젝트에서 사용한 주 언어가 있습니다.
React native , javascript , DB는 firebase만 사용해서 프로젝트를 만들었습니다.
그런데 저는 백엔드 개발자로 가고 싶은데 백엔드 언어쪽으로 포트폴리오가 많이 부족한 것 같아서
JSP, SPRING 배우는 국비지원 학원을 들어가서 포트폴리오를 채워야 할지
아니면 국비지원 말고 개인 프로젝트로 백엔드 언어 관련 포트폴리오를 많이 쌓고 준비를 해야 할지 조언을 얻고 싶네요.', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (6, 6, '32살 고졸 비전공자 진로관련 질문좀 받아주실분..', '국비백엔드과정 수료하고 과정평가형 정처산기따고 취업하려고했는데
갑자기 너무 돈 급한일이 생겨가지고.. 개발이랑 관련없는 엑셀쓰는 사무일에 취업해서 1년정도 지났습니다..
상황이 좀 안정화가 되서 다시 웹개발쪽으로 취업 도전해보려고하는데
그냥 빨리 어디든 고졸로 취업해서 일부터 시작할지
아니면 기존직장 다니면서 방통대2학년 편입하고 정처기자격증따고 공부좀 더 하다가 한 35살쯤에 전공자로 취업할지 고민중인데
어떤게 나을지 잘 모르겠어가지고 여쭤봅니다...

도와주시면 너무너무 감사하겠습니다ㅠㅠ.. 주변에 물어볼만한 분이 한명도 없네여..', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (7, 7, '백엔드 개발자가 되고 싶은데 데이터 사이언스 부트캠프 참여하는 거 어떻게 생각하시나요?', '저는 금융권 it 취업 준비 중입니다.

백엔드 개발자가 되고 싶어서 준비 중인데 데이터 분석 등을 배우는 데이터 사이언스 부트캠프에 참여하는 것이 취업에 도움이 될까요? 카드 쪽 업무에서 데이터를 많이 다루기 때문에 데이터 관련 자격증이나 공부를 하는 것이 좋다고 듣기는 했는데 제가 잘 몰라서 그런 것일수도 있지만 개인적으로 데이터 분석 등은 백엔드 개발보다는 ai 관련으라는 생각이 들어서 조금 고민이 됩니다.

현직자 분들 어떻게 생각하시나요??', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (8, 8, '백엔드 신입 배포 역량은 어디까지가 플러스인가요?', '우선 이번 프로젝트 배포로 생각 중인건 깃허브액션+aws ec2고

여유되면 젠킨스, 도커까지 활용해볼 생각입니다

그리고 최근 길벗 컨테이너 인프라 환경 구축을 위한 쿠버네티스/도커 서적을 구매했는데 다 읽는게 좋을지 골라읽고 백엔드 역량에 집중하는게 좋을지 고민입니다

배포도 저기까지가 좋을지 아니면 줄일지 더 해볼지 고민되네요

조언부탁드립니다', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (9, 9, '신입 5개월 경력?은 이력서에 쓰는게 좋을까요..?', '중소 si에서 프론트 개발자로 있다가 6개월차 되던때 퇴사했는데요.

신입이긴했지만 입사하고 바로 새 프로젝트에 참여하게 되서 거의 매일 12시간씩 일했고 다른 팀원들과 비슷한 양과 난이도의 화면 개발 수행했습니다.

미친 업무 강도에 건강이 너무 안좋아지는게 느껴져서 런하고 싶었지만 중간에 런하면 팀원한테 너무 민폐라고 생각해서 꾸역꾸역 다니다 프로젝트 막바지 QA 돌리던 때쯤 퇴사했습니다.

그동안은 이력서 경력란에 간단히 넣어서 내긴 했는데 그냥 안넣는게 나으려나 하는 생각이 문득 들어서 여기 질문해봅니다ㅠㅠ', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (10, 10, '국비 수료후 취준에 대해 궁금합니다!', '안녕하십니까! 자바 스프링 웹 개발 취준생입니다!

수료는 12월 예정이지만
저는 아직 기초가 부족하다고 생각되어 인프런에서 자바와 스프링 강의를 더 들으며 공부할 계획이고 정보처리기사를 취득하고 개인 프로젝트를 1 ~ 2개 정도 만들어 본 후 4~ 5월 부터 취업에 지원할 생각인데
다른 수강생들은 벌써 이력서를 지원하고 있는것을 보며 혹시 수료하고 취준기간이 길어지는것이 문제가 되지 않을까 걱정이 되어 글을 작성했습니다.

어떤 식으로 취업을 준비하는게 좋을까요', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (11, 11, '이런 상황에 퇴사하는게 어떨까요...', '출근하면 다른 업무가 없을 땐 자기계발을 하는데, 다른 회사의 개발자들은 다 업무를 하는데 난 여기서 뭐하나 하는 생각도 들고 배워도 어차피 적용하지 못하는 상황이라(고객사가 보수적임) 기운도 빠집니다. 지금도 잘 되는데 왜 새로운걸 써야하냐라는 태도입니다. 이런 상황이 계속 되다보니 이젠 지쳐서 우울증에 걸릴 것 같습니다. 자잘한 실수가 나오다보니 더 힘들고 악순환에 빠진 것 같습니다.

다니면서 이직하려고 했는데 마음처럼 잘 안됐구요. 그래도 JPA나 스프링 시큐리티같은 회사에서 사용하지 않는 기술스택들은 혼자 공부해왔습니다. 이것저것 컨퍼런스도 많이 참여하고 블로그도 작성했고 혼자 공부는 많이 했어서 퇴사하고서도 계속 공부해서 취준할 수 있을거라는 생각이 들고요.

이렇게 계속 회사에 기운 빠지느니 차라리 퇴사해서 포트폴리오 제대로 만들어서 다른 회사가자는 생각이 드는데, 이런 상황에 그만둬도 되는걸까요.', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (12, 12, '개발자로 잘 살아남을 수 있을까요?
', '컴퓨터 공부 몇 년 열심히 했고

컴퓨터 공부 하기 전에는 다른거 열심히 했고

한 10년 이상 계속 열심히 살았는데 앞으로도 계속 이럴 수 있을지 솔직히 자신이 없어요

옛날에는 대학교 수업 끝나고 늦게까지 공부하는게 일상이였는데

한 1년 전쯤부터 회의감이 들기 시작했어요

요즘은 딱 40시간 일하고 그 이후에는 쉬고싶고, 그 40시간 마저도 조금이라도 편하게 일하고 싶어요.

그래서 개발자로 잘 살아남을 수 있을지 참 걱정입니다', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (13, 13, '안드로이드 개발자 숫자가 줄어들었나요??', '사람인에서 안드로이드로 검색하고 있는데 지원자가 많은데는 30명수준에서 적은데는 2~3명정도 밖에 없네요.

저희 회사도 최근에 아이폰 안드로이드 구직공고를 냈는데 아이폰은 4일정도 됐고 안드로이드는 3일 정도 됐는데

아이폰은 17명정도 지원했고 안드로이드는 1명 지원했네요...

그래서 궁금해서 다른 직종도 적은지 찾아보니 자바 백엔드는 적은데가 100명대에서 많은데는 500명대가 넘어가는데

무슨일 있는건가요??

아직 안드로이드 국비 과정이 안끝나는 타이밍이서 그런걸까요??', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (14, 14, '스프링 개발자 파이썬 파이토치 전환 가능할까요', '못 하면 정리해고 시킬까 해서요

AI 붓캠 나온 신입 뽑는게 인건비도 덜 들어가는데, 그냥 쌓인 정이 있으니 기회는 주자...', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (15, 15, '풀스택 개발자 공부는 뭐가 필요한가요?', '풀스택 개발자로 취업을 목표로 하고있는데(비전공자)

가장 근본적인건 JAVA인건 알고있고

다른거는 뭐뭐 배워야할까요?

점진적으로 배워야 할텐데 1.뭐를/2.어떤순서대로 배울지 모르겠어요...

html,css, DB,자바스크립트,스프링 등등 있는데

뭐가 필수이고 어떤 순서대로 들어야할까요?...', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (16, 16, '공대 졸업 후 개발자 분야 부트캠프 선택 고민입니다..', '현재, 졸업을 앞두고 인프런 강의도 보고 했지만 혼자서 공부하는 게 어렵더라구요..

부트캠프를 하려고 하는데 싸피, 우테코, 등등 유명한 교육들은 마감되었고

부트캠프를 2곳 지원하였는데 Cloud기반 백엔드 과정(엘리스 트랙)과 클라우드 및 데브옵스 기반의 백엔드 과정(네이버클라우드캠프)에 붙어서

고민중입니다... 다른 분은 둘 다 별로라고 하셨는데 그 정도인가요?? 만약, 다른 추천하시는 과정이 있으면 정보 공유 부탁드리겠습니다.. ㅠㅜ', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (17, 17, '이제 입사 5일차 신입 입니다ㅠㅠㅠㅠ', '이제 입사 5일차 전공은 아니지만 관련학과 졸업 하고 학부때 php로 프로젝트 한번 해보고 혼자 독학으로 알고리즘이랑 장고로 게시판 몇번 만들어본게 전부인데 급한데로 집근처 중소 si 들어갔는데 이 회사는 php로 개발을 하고 있다는데 제가 php는 이제 기억도 안나고 mysql도 테이블 생성 만 해본게 다인데 이번주 까지는 메뉴얼이랑 사내 문서 작성법만 배운게 다인데 다음주 부터는 교육을 진행 한다는데 너무 걱정입니다. 선임분이 좋으신분 같은데 제가 세상 쫄보라서 ㅠㅠㅠㅠ 내가 너무 못해서 선임분이 안좋게 생각할까봐 지금 집에서 급하게 sql문법이랑 php로 게시판 만들고 있는데 신입은 어느정도로 역량을 올려야 할까요??', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (18, 18, '뭘 만들고싶은데 주제 추천 부탁드려요!', '혼자서 꼭 만들게요. 희안한 거나 이상한거 도전정신이 필요한거

추천해주세요.

요즘 국룰이

리액트, 스프링부트인가요?!', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (19, 19, '맥쓰다가 윈도우 넘어가면 불편할까요???', '맥북 1년썼는데 팔고 윈도우 데탑 넘어갈까하는데 불편한거 많을까요?? 맥북이 불편해서 넘어가는건 아니고 가끔 게임하고싶어서 팔고 데탑가려는데.. 맥북에서 모니터 모서리에 마우스로 찌르면 액션취해지는거 너무 편하게 쓰고있긴한데', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (20, 20, '인프런 게임 서버 강의', '이번 방학 때 인프런에 있는 게임 서버 강의를 들으려고 하는데 유니티로 하는 강의와 언리얼로 하는 강의가 있더라고요.
유니티와 언리얼이라곤 하지만 내용에서 엔진은 크게 상관이 없는 것 같아요.
둘 다 강사님은 같고, 가격하고 커리큘럼에서 차이가 있어요

가격은 유니티 < 언리얼
커리큘럼은 유니티 ⊂ 언리얼


인데 어떤 걸 들어야 할지 고민되는데 혹시 추천해 주실 수 있을까요?', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (21, 20, '포폴용 배포 AWS 말고 어디서 하세요?(feat.할거 없어서 만들어 봄)', '만들다가 귀찮아서..배포를 먼저 해봄..

배포 하다가 메모리 부족해서 메모리 스왑 까지함

Next.js + Spring..

Okky를 모방했습니다 ㅎ.. 귀-찮..

혹시 AWS npm install하면 자꾸 서버가 멈춰서 그러는데

무료 서버 더 메모리 좋은 곳 있을까요?', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (22, 19, '크아아악 제발 노션으로 낸 포폴...', '제발 노션으로 제출 하셨으면
외부에서 보이는지 체크 좀 하고 제출 좀하세요

이력서,포폴을 권한이 없다고 못봐요....', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (23, 18, '스타트업 주의할 점 있을까요?', '다음주에 2년된 스타트업으로 면접가게 되었습니다

집 근처라 못해도 20분 이내로 출퇴근 가능 할 거 같습니다

회사 정보가 많이 없어서 판단할 기준은 거의 없네요 ㅠㅠ

잡코리아 기준 8명 정도 되는거 같고 SI/솔루션 회사인거 같아요

혹시 면접볼때 확인해야 할 부분들이 있다면 어떤것이 있을까요?', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (24, 17, '우테코처럼 톰캣을 만들고 리뷰해주는 부트캠프는 없나요?', '커리큘럼이 좋은거같은데 직장인이라 우테코는 힘들것같고

우테코보니까 톰캣만드는 과정에서 리뷰도 하나하나 정성스럽게 달아주더라구요

그런 코스같은거 있을까요? 유료여두요!', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (25, 16, '코드가 깔끔하대요', '과거 같이 일했던 동료로 부터 들었어요.

제가 짠 코드가 깔끔하고 알아보기 쉽대요.

그래서 기분이 조크든요 ㅋㅋ

제가 좀 코드에 대한 강박? 있어서 노력하는 편입니다.

걍 그렇다고요^^', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (26, 15, '웹개발 시작하게 되었는데 프론트 부분때문에 발목이 잡히네요.. 어떻게 해야할까요?', '주제는 영화 예매 사이트 입니다.

부트스트랩 템플릿 좀 찾아봤는데 맘에 드는게 없고

견본사이트(롯데시네마)를 그대로 따라하자니 프론트 쪽으로는 아는게 없어서 힘드네요

어떻게 하면 좋을까요', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (27, 14, '백엔드 개발은 요즘 자바에서 자바스크립트로 가는 추세인가요?', '외국에서는 웹개발에 자바 기반 프레임워크가 많이 쓰인다고 들었는데요,

요즘은 국내 기업들에서 백엔드는 자바스크립트 기반 프레임워크 비중이 더 높아지고 있다고 들었는데 사실인가요?', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (28, 13, '요즘 취준 어떤가요?', '1년차 프론트인대

가급적 버텨볼려고 하나 이대로 가다간 물경력만 될꺼같아서 내년 1~2분기를 목표로 슬슬 준비할려고 하는대
요즘 상황이 어떤가요..?', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (29, 12, '백엔드 부트캠프를 하려고 하는데 어떤 캠프를 선택해야 하는지 궁금합니다', '저는 비전공자이며, 백엔드와 알고리즘을 꾸준히 공부해왔고 이제 캠프에 지원해서 수료 후 취업을 하려고 하고 있습니다.

캠프를 선택할 때 혹시 어떤 기준을 통해 하는 것이 좋을까요?

캠프에도 급 같은게 있을까요? 이왕이면 좋은 곳에서 수료하고 싶습니다', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (30, 11, '새벽에는 구직공고 지원 안 하시는 게 좋습니다.', '예전에 제가 새벽에 잡코리아에서 이곳저곳 지원을 했었는데요.

다음날 면접보러 오라고 해서 갔습니다.

그러다 이얘기 저얘기 하다가 마지막에 왜 새벽 4시에 지원을 하였냐고 묻더라구요.

대충 둘러대긴 했는데.

나중에 공고를 직접 올리고 보니까 지원자가 지원을 하면 그때마다 알림 메일이 와서 휴대폰이 계속 띠링띠링 하더군요.

상대방 입장에서는 새벽에 잠을 깻으니 불쾌할 수도 있을 거 같더라구요.', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (31, 10, '라이브 코딩 테스트는 난이도가 대체로 어떤가요?', '안녕하세요. 저는 신입 개발자로 취업 준비중인데요.

면접 과정에서 라이브 코딩 테스트를 본다고 하더라구요.

시간은 20~30분 정도라고 하시고, 코더패드나 해커랭크로 볼 것이라고 합니다.

제가 라이브 코딩 테스트는 한번도 본 적이 없어서, 난이도가 어떤지 궁금하네요.

리트코드 이지~미듐정도 될까요?', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (32, 9, '안녕하세요 국비 포트폴리오 관련 질문 있습니다.', '저는 비전공자이고 보도방도 상관없이 오직 취업만을 목표로 하고 있습니다. 현재 학원에서 만든 입사지원서는 1 파일안에 이력서, 자소서, 포폴을 전부 집어넣어 총 48p분량의 pdf파일이 나오더라구요. 또한 포폴 내용은 내가 고민한 흔적보다는 게시판의 기능을 설명하는 위주의, 예를들면 a라는 버튼을 클릭하였을 때 어떤 반응이 나오는 식의 내용이 담겨있습니다
하지만 제가 여러군데에서 본 것은 이것과 상이한 결과물이던데 뭐가 맞는지 모르겠습니다. 아무래도 다른분들은 솔루션이나 스타트업 등 조금 더 건실한 곳들을 목표로 하였기에 결과물을 만들어내는 방식이 다를 수도 있다고 생각하는데 어떤것이 맞는건가요??
회사의 수준은 차치하고 오로지 취업을 목적으로 작성한다고 했을 때 학원에서 고수하는 방법이 효과가 있을까요ㅠ??

', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (33, 8, '개발자 이수과목(수강과목)중요해요??', '운영체제, 알고리즘, 자료구조, 컴퓨터 구조는 수강했는데

데이터베이스랑 네트워크 수업을 못들어서요

어떤 기업은 자소서에 수강과목 적으라는 곳도 있다고 해서요

그냥 졸업하면 나중에 불이익있을까요?

', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (34, 7, '깃허브 화면에 일부 변화가 있는데, 다들 이런가요?', '리포지토리의 Commits 목록에 가면..

뭔가 폰트도 구려지고, 목록의 width도 살짝 길어지고,

제일 신경 쓰이는 건, 몇 개의 코멘트가 달려있는지 표시해주는 아이콘과 숫자가 사라졌네요.

의도한 건지.. 조만간 고쳐줄 건지.. 암튼 이상합니다.', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (35, 6, '지금 오키에 있는 신입 연봉글들을 많이 봤는데', '내가 너무 현실 모르고 욕심만 냈고 지금 상황에 감사해야할듯
대부분이 2500~2800인데 전문대졸에 초봉 3500이면

어후 감사합니다 하느님', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (36, 5, '회사 2곳중 어디 선택이 나으세요?', '1.대용량트래픽 발생,대용량 데이터 핸들링 및 분산시스템 등 온갖 개발을 깊이있게 다루고 배울수있음,개발문화 잡혀있음 ,찐개발자가 모여있는 기업
연봉 3500

vs

연봉 8000 지만 단순 crud위주,데이터 소량,일트래픽 10만이하 ,소규모

그냥 한번 커리어적으로 어떤 선택을 보편적으로 하실지해서 올려봤습니다.아마 당연한 결과일거같긴하지만..', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (37, 4, '이직 시 연봉 vs 미래', '평소 이런 질문 글이 올라오면 당연히 이거지! 하는 생각을 하기도 했습니다.

근데 당사자가 되어 보니까, 이게 쉬운 결정이 아니네요...

여러분이라면 어떤 선택을 하실 건가요?

1. 미래 유망한 스타트업 - 여기서 이직을 또 한다고 하더라도 매우 좋음 (로보틱스)

2. 유명한 중견기업 - 위 스타트업 보다 연봉이 거의 1.5배, 안정적, 복지 좋음, 야근 많음, 하는 일이 장비쪽이고 범위가 제한적', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (38, 3, '회사에서 사람뽑는데', '이력서에 타지역 주소로 해놓으신분들은
면접보러 회사까지 올수 있다는 뜻일까요
회사는 서울인데 이력서 주소가 대구로 되어 있어서 일단 보류 해놓긴했는데...

저도 지방 출신이긴한데
저같은 경우는 이력서에 해당 지역 주소가 없다면
아무래도 pick가능성이 떨어진다고 생각해서
아예 서울에 방잡고 이력서 돌렸거든요.
이력서 돌려서 면접날짜가 급하기 잡히면 오고 가는것도 그렇고
또 만약에 합격을 한다면
갑자기 서울에 사는곳 찾는것도 쉬운일은 아닐것같아서요

머 일단은 저렇게라도 면접 볼수있다면야 연락은 돌려봐야 겠네요
답변들 감사합니다.', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (39, 2, 'java spring 에서 java node.js', '안녕하세요 2년차 개발자입니다

java spring 사용하다가 곧 이직할 회사가 java node.js를 사용한다해서 걱정이 많습니다

node.js 책이나 인강 추천해주실 수 있는지와 저와같은 코스로 이직하신 분들이 있다면 후기로 알려주시면 감사하겠습니다!

어떨지 감이 하나두 안잡히네용,,', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (40, 1, '취업에 더 유리한건 졸업 프로젝트 vs 현장실습', '4학년 이제 올라가는데 학교에서 수업들으면서 졸업 프로젝트를 만들지 현장실습하면 졸업프로젝트 대체인데 현장실습을 나갈지 고민중입니다

취업할땐 어떤게 더 유리한가요?', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (41, 7, 'SI 개발자로 시작하여 임원이 될 수 있을까요?', '안녕하세요 si 대기업에 입사를 앞둔 사회 초년생입니다.

커리어의 목표를 세우는 데에 있어, 선배님들의 고견을 듣고 싶어 글을 남기게 되었습니다.

아직 입사 전이지만, 저는 회사가 저와 잘 맞는다면 이직을 하지 않고 오래오래 남아 임원을 하고 싶다는 생각을 가지고 있습니다.

최종적으로는 높은 직급에서 회사의 방향성에도 많은 기여를 하고 싶은데 너무 어린 생각일까요?

두서 없는 글을 읽어주셔서 감사합니다.

', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (42, 20, '6개월 차 신입 연차 없을때 이직 면접', '안녕하세요 이제 막 6개월 정도 회사에 다닌 신입입니다..
현 회사가 제가 꿈꾸는 개발과 맞지 않아 이직을 하려고 하는데.. 하필이면 이직 제안이 한 번에 2개가 들어와 버려서 시간 조율을 해야 하는데 퇴근 후(6시)에 면접 요청을 하거나 주말에 요청해도 괜찮을까요?', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (43, 12, '개인 개발용 노트북 고민 입니다', '5년째 쓰고 있는 비보북이 망가져서 하나 사려고 하는데

뭐가 좋을까요

M1칩 맥북 vs LG 그램 vs 갤북

이렇게 고민 중 입니다

백엔드라 비싼 맥북으로 굳이 갈아타야 하나 싶기도 하고

어렵네요', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (44, 13, '웹개발용 노트북 추천해주세요!', 'cpu : i5 13 ~ 14세대, i7도 괜찮습니다!

ram : 32 gb

ssd : 512gb

화면 15 ~ 16 inch

위 스팩으로 구매를 하고싶은데 괜찮은 것들 추천 해주세요! 가성비도 조금 보고싶은데 150만원 아래로 생각하고 있습니다!

맥북제외하구 풀스택 웹개발입니다!!

다들 화이팅.!', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (45, 16, '아이폰 개발자 연차별 연봉 대략적으로 어느정도죠?', '초봉3500부터 시작이라던데.. 사실인가요..?

초봉이 웹쪽은 3200인가요..?웹쪽도 올랐다고 들었었는데..', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (46, 17, '국비학원에서 이제 프로젝트를 시작하는데 궁금한게 있습니다.', '다들 부트스트랩 사용할 때 보통 cdn 방식으로 하시나요 아니면 템플릿 전체 다운받는 식으로 하나요?', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (47, 5, '코린이 자바에 관하여 질문드립니다.', '프론트엔드 개발자를 목표로 공부시작한 코린이입니다.

혼자서 인강 보면서 자바스크립트 공부하고 있는데

커뮤니티를 보면 웹개발자를 목표를 하시는 분들이 대체로 자바를 공부하더라구요

자바스크립트를 공부하는게 맞나 싶은 생각이 드는데 자바를 배우는게 맞나요?', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (48, 6, '자바의 정석을 구매했는데...', '종강이 10일 정도 남아서 본격적으로 공부할 책을 좀 구매해봤습니다.

자바의 정석이 추천도 많이 받았고 정말 좋은 책이라고 하길래 이왕 자바를 배우는 겸 이걸로 해볼까 하는 생각에 구매를 했습니다.

그런데 16년도라 그런지 23년이 되기까지 새로운 자바 버전이 좀 생겨서.. 책에서 사용하는 버전을 사용할까 했지만 또 생각해보면

이전 버전에서 개선 되었기 때문에 또 다른 버전이 나온게 아닌가 싶기도 하고 고민이네요.

보통 실무에서 사용하는 버전은 몇인지 알고 싶습니다. 버전 추천도 받아요.', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (49, 4, '혹시 온라인 보드게임 백엔드(java) 개발 해보신 분 계신가요', '온라인으로 체스나 오목, 바둑 등등 대전(대국) 하는 보드게임은 프로토콜부터 다를거라 생각하는데

검색 키워드를 뭐라고 해야할 지 모르겠네요 ..

요즘 어떤 방식으로 만드나요 , 앱이 아닌 백엔드 기준으로 정보좀 주실수 있을까요 ㅜ', default, default, default);
INSERT INTO tblCommunity (cseq, mseq, title, content, file, regdate, count) VALUES (50, 1, '국비 수료한 java 웹개발자 신입인데요', '감사하게도 한 회사에서 면접을 불러주셨는데 일단 최선을 다할거지만 좀 궁금한게 있어서요!

이 회사는 일반인들 대상으로 자사 어플(금융관련)을 꽤 크게 운영하는 곳인것 같습니다. 공고 상으로는 자바 백엔드 서버 개발자를 구한다고 해서 지원했구요

그런데 저는 학원 프로젝트로 웹사이트(기본적인 쇼핑몰,게시판)만 만들어본 경험이 있는데 이 직무와 연관성이 있는게 맞을까요?

어플을 주력으로 하는 회사라 뭐가 어떻게 다른건지가 감이 잘 안와서요.. 아직 합격은 아니지만 궁금합니다', default, default, default);

-- tblCategory
insert into tblCategory (cname, color) values ('JAVA', '#660099');    
insert into tblCategory (cname, color) values ('HTML', '#FF6666');
insert into tblCategory (cname, color) values ('CSS', '#FFFF66');
insert into tblCategory (cname, color) values ('PLSQL', '#663366');
insert into tblCategory (cname, color) values ('ANSISQL', '#FF3333');
insert into tblCategory (cname, color) values ('JavaScript', '#6666CC');
insert into tblCategory (cname, color) values ('Spring', '#669933');
insert into tblCategory (cname, color) values ('SpringBoot', '#336600');
insert into tblCategory (cname, color) values ('JSP', '#663333');
insert into tblCategory (cname, color) values ('C', '#CCCCCC');
insert into tblCategory (cname, color) values ('C++', '#999999');
insert into tblCategory (cname, color) values ('C#', '#666666');
insert into tblCategory (cname, color) values ('Python', '#000066');
insert into tblCategory (cname, color) values ('TypeScript', '#66CC66');
insert into tblCategory (cname, color) values ('PHP', '#333333');
insert into tblCategory (cname, color) values ('Ruby', '#CC0000');
insert into tblCategory (cname, color) values ('Visual Basic', '#999900');
insert into tblCategory (cname, color) values ('Assembly Language', '#9999CC');
insert into tblCategory (cname, color) values ('GO', '#66FF33');
insert into tblCategory (cname, color) values ('R', '#660000');
insert into tblCategory (cname, color) values ('Swift', '#CC9933');
insert into tblCategory (cname, color) values ('Perl', '#CC00FF');
insert into tblCategory (cname, color) values ('ALGOL', '#99CCCC');
insert into tblCategory (cname, color) values ('Fortran', '#FFCC99');
insert into tblCategory (cname, color) values ('MongoDB', '#6699FF');
insert into tblCategory (cname, color) values ('NoSQL', '#3333FF');
insert into tblCategory (cname, color) values ('MySQL', '#6633FF');
insert into tblCategory (cname, color) values ('Oracle', '#0033CC');
insert into tblCategory (cname, color) values ('MariaDB', '#0099FF');
insert into tblCategory (cname, color) values ('Node.js', '#33FFCC');

-- tblPlace
insert into tblPlace (place, lat, log) values ('잠실스터디카페', 37.552, 127.1545);
insert into tblPlace (place, lat, log) values ('르하임스터디카페', 37.5533, 127.1439);
insert into tblPlace (place, lat, log) values ('더달썸스터디카페', 37.544, 127.1211);
insert into tblPlace (place, lat, log) values ('앤딩스터디카페', 37.549, 127.1543);
insert into tblPlace (place, lat, log) values ('더싸이스터디카페', 34.8606, 128.425);
insert into tblPlace (place, lat, log) values ('몽스터디카페', 37.5404, 127.1282);
insert into tblPlace (place, lat, log) values ('시작스터디카페', 37.3203, 127.11);
insert into tblPlace (place, lat, log) values ('무실스터디카페', 37.337, 127.927);
insert into tblPlace (place, lat, log) values ('오름스터디카페', 37.7674, 128.8762);
insert into tblPlace (place, lat, log) values ('크라운스터디카페', 38.2077, 128.5751);
insert into tblPlace (place, lat, log) values ('스터디랩', 37.2677, 127.0012);
insert into tblPlace (place, lat, log) values ('정상스터디카페', 35.8666, 129.2117);
insert into tblPlace (place, lat, log) values ('올탑스터디카페', 37.86, 127.7292);
insert into tblPlace (place, lat, log) values ('셀독24스터디카페', 37.4, 127.2543);
insert into tblPlace (place, lat, log) values ('디플레이스스터디카페', 37.4157, 127.2481);
insert into tblPlace (place, lat, log) values ('아인스터디카페', 37.4124, 127.2564);
insert into tblPlace (place, lat, log) values ('비허밍스터디카페', 34.8106, 126.38);
insert into tblPlace (place, lat, log) values ('라온스터디카페', 37.3786, 127.2547);
insert into tblPlace (place, lat, log) values ('랭스터디카페', 36.8186, 127.1556);
insert into tblPlace (place, lat, log) values ('네이처스터디카페', 36.811, 127.1088);
insert into tblPlace (place, lat, log) values ('이룸스터디카페', 36.8186, 127.1561);
insert into tblPlace (place, lat, log) values ('마이룸스터디카페', 36.8074, 127.1309);
insert into tblPlace (place, lat, log) values ('비책스터디카페', 35.1916, 129.0853);
insert into tblPlace (place, lat, log) values ('공휴스터디라운지', 35.1697, 129.0694);
insert into tblPlace (place, lat, log) values ('세인트스터디카페', 35.1684, 129.0696);
insert into tblPlace (place, lat, log) values ('글로티스 관리형스터디카페', 37.4619, 126.7078);
insert into tblPlace (place, lat, log) values ('공간스터디룸', 37.4929, 126.7221);
insert into tblPlace (place, lat, log) values ('샘이스터디카페', 37.4752, 126.6453);
insert into tblPlace (place, lat, log) values ('한림스터디카페', 33.4158, 126.2693);
insert into tblPlace (place, lat, log) values ('성공스터디카페', 37.2013, 126.8262);

-- tblStudy
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (1, 1, 'JAVA로 백엔드 개발자되기', 'eclipse를 활용한 JAVA 공부', 5, '13:00-15:00', '2023-12-15~2024-01-01', '금', 'study01.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (2, 2, 'HTML을 활용한 기본 웹페이지공부', '비전공자를 위한 기초를 익히는 스터디 모임입니다.', 6, '13:00-15:00', '2023-12-14~2023-12-30', '목', 'study02.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (3, 3, '나는 CSS 마스터', '웹페이지를 보다 효과적으로 디자인하고 관리할 수 있도록 공부하는 그룹입니다.', 3, '13:00-15:00', '2023-12-12~2023-12-31', '화', 'study03.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (4, 4, 'PLSQL의 연구모임', '직접 쿼리를 작성해보면서 프로시저, 함수, 트리거, 패키지등을 학습하는 모입니다.', 5, '13:00-15:00', '2023-12-11~2023-12-30', '월', 'study04.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (5, 5, 'ANSISQL로 데이터베이스 마스터', 'ANSISQL로 select, update, insert, delete을 구현하면서 데이터의 삽입, 삭제, 조회, 수정을 학습할 수 있습니다.', 4, '13:00-15:00', '2023-12-13~2024-01-04', '수', 'study05.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (6, 6, 'JavaScript를 이용한 웹페이지 제작', '다양한 라이브러리(jQuery, React, Vue.js)와 프레임워크(Node.js, Angular)를 활용하여 다양한 기능을 구현합니다.', 6, '13:00-15:00', '2024-02-03~2024-03-03', '토', 'study06.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (7, 7, 'MVC패턴을 활용한 Spring 프로젝트', 'Java 기반의 오픈 소스 프레임워크인 Spring을 사용하여 모델-뷰-컨트롤러 구조로 웹페이지 제작 가능', 6, '13:00-15:00', '2024-02-04~2024-03-04', '일', 'study07.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (8, 8, 'SpringBoot를 사용하여 빠르고 쉽게 홈페이지 구축하기', '내장서버(Tomcat)를 제공하여 별도의 외부 서버 설정이 필요하지 않아 편리한 Spring Boot로 웹사이트 구축해요! ', 5, '10:00-12:00', '2024-02-05~2024-03-05', '월,수', 'study08.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (9, 9, 'JSP 사용해서 동적이고 유연한 웹 페이지 구현합시다~', '많은 기업에서 웹 어플리케이션을 개발하는 데 널리 사용되는 기술 JSP 공부합시다.', 5, '10:00-12:00', '2024-02-06~2024-03-06', '화,목', 'study09.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (10, 10, '다양한 분야에 활용되는 C언어 공부할 사람', 'C는 하드웨어나 운영체제에 종속되지 않고 이식성이 높아서 다양한 환경에서 사용될 수 있습니다.', 3, '10:00-12:00', '2024-02-09~2024-03-09', '금,토', 'study10.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (11, 11, 'C언어를 기반으로 발전한 고급 프로그래밍언어 C++ 공부하실분~', '객체지향프로그래밍, 상속과 다형성, 캡슐화와 데이터 은닉에 대해 공부해요~', 2, '10:00-12:00', '2024-02-10~2024-03-10', '토,일', 'study11.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (12, 12, 'C#으로 게임 개발하실 분 구합니다', 'Microsoft에서 개발한 객체 지향 프로그래밍 언어 함께 공부해요', 5, '08:00-10:00', '2024-01-01~2024-01-25', '월', 'study12.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (13, 13, 'Python으로 인공지능, 머신러닝에 대해 학습하는 모임', '데이터 분석, 머신러닝, 딥러닝에 대해 공부할 수 있습니다. 바로 신청하세요~!', 3, '08:00-10:00', '2024-01-02~2024-01-25', '화', 'study13.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (14, 14, 'TypeScript로 프로그래밍 공부해요', 'JavaScript의 단점을 보완하고 안정성을 높이는 TypeScript를 공부합니다.', 4, '08:00-10:00', '2024-01-03~2024-01-25', '수', 'study14.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (15, 15, 'PHP로 웹 개발 공부', 'PHP는 웹 개발을 위한 강력하고 유연한 언어로, 페이스북, 워드프레스 등 많은 대규모 웹사이트들이 PHP를 기반으로 개발되어 있습니다.', 5, '08:00-10:00', '2024-01-04~2024-01-25', '목', 'study15.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (16, 16, 'Ruby를 사용하여 쉽게 학습하는 공부모임', 'Ruby는 간결하고 가독성이 높은 문법을 가진 객체 지향 프로그래밍 언어로, 특히 웹 개발에 강점을 가지고 있으며, Ruby on Rails 프레임워크를 통해 빠른 웹 애플리케이션 개발이 가능합니다.', 2, '08:00-10:00', '2024-01-05~2024-01-25', '금', default);
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (17, 17, 'Visual Basic으로 응용 프로그램 공부하실 분 구합니다.', 'Visual Basic는 쉽고 빠르게 Windows 기반 애플리케이션을 개발할 수 있는 강력한 도구로, GUI 프로그래밍에 초점을 맞춘 언어입니다. ', 5, '08:00-10:00', '2024-01-06~2024-01-25', '토', default);
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (18, 18, 'Assembly Language 배우고 싶으신 분', 'C언어보다 훨씬 빠른 어셈블리 언어로 성능 좋은 프로그램을 만들 수 있습니다.', 5, '08:00-10:00', '2024-01-07~2024-01-25', '일', default);
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (19, 19, 'GO로 대규모 시스템 개발할 사람~', 'Go는 대규모 시스템, 웹 서버, 네트워크 애플리케이션, 분산 시스템 등 다양한 분야에서 사용되며, 특히 동시성, 병렬성, 간결성 등의 특징으로 많은 개발자들에게 선호되는 언어 중 하나입니다.', 3, '15:00-17:00', '2024-01-08~2024-02-09', '월', 'study16.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (20, 20, 'R을 이용한 통계 계산과 데이터 분석 공부', 'R은 통계학자, 데이터 과학자, 연구원 등 데이터 분석과 통계 계산을 필요로 하는 많은 분야에서 활발하게 사용되고 있으며, 데이터 분석 작업의 생산성과 효율성을 높여주는 강력한 도구로 평가받고 있습니다.', 5, '15:00-17:00', '2024-01-09~2024-02-09', '화', 'study17.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (21, 21, 'Apple에서 개발한 Swift 공부하실 분', 'Swift는 애플 생태계에서 주로 사용되며, 안전하고 빠르며 가독성이 좋은 코드를 작성할 수 있는 강력한 언어입니다. 이러한 특징으로 많은 iOS 및 macOS 앱 개발자들에게 선호되고 있습니다.', 5, '15:00-17:00', '2024-01-10~2024-02-09', '수', 'study18.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (22, 22, 'Perl로 웹 개발 하실분', 'Perl은 특히 텍스트 처리 및 시스템 관리 작업에서 강점을 가지고 있으며, 초기 웹 개발에도 널리 사용되었습니다.', 5, '15:00-17:00', '2024-01-11~2024-02-09', '목', default);
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (23, 23, '최초의 고급 프로그래밍 언어 ALGOL 공부할 사람', 'ALGOL은 프로그래밍 언어 설계에 있어서 많은 철학적 영향을 미쳤으며, 구조화된 프로그래밍 개념을 도입하여 코드의 가독성과 모듈화를 강조하였습니다. 이러한 개념과 철학은 후대의 많은 언어에 영향을 주었습니다.', 3, '15:00-17:00', '2024-01-12~2024-02-09', '금', default);
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (24, 24, '최초의 고급 프로그래밍 언어 Fortran 학습하실 분', 'Fortran은 초기 컴퓨터 시대부터 과학적 계산을 위한 언어로 사용되어 왔으며, 높은 성능과 안정성으로 인해 여전히 많은 과학 및 엔지니어링 분야에서 활발하게 사용되고 있습니다.', 2, '15:00-17:00', '2024-01-13~2024-02-09', '토', default);
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (1, 25, 'JAVA를 이용한 앱개발 할 사람', '안드로이드 앱의 개발 언어로 사용되며, 안드로이드 스튜디오(Android Studio)와 함께 사용하여 모바일 애플리케이션을 개발할 때 널리 사용됩니다.', 5, '15:00-17:00', '2024-01-14~2024-02-09', '일', 'study19.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (2, 26, 'HTML로 웹 페이지 구현할 사람', 'HTML은 웹 페이지의 구조를 정의하기 위해 사용됩니다. 텍스트, 이미지, 링크, 표, 목록 등을 구성하여 사용자에게 보여지는 콘텐츠를 정의합니다.', 3, '13:00-15:00', '2024-01-29~2024-02-29', '월,수,금', 'study20.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (3, 27, 'CSS로 디자인 배우기', 'CSS는 웹 페이지의 시각적인 표현을 담당하여 사용자에게 보다 직관적이고 매력적인 경험을 제공합니다. HTML과 함께 사용하여 웹 페이지의 구조와 스타일을 분리하여 유지보수와 확장성을 높일 수 있습니다.', 2, '13:00-15:00', '2024-01-30~2024-02-29', '화,목,토', 'study21.png');
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (4, 28, 'PLSQL 기본 다지기', 'Oracle 데이터베이스에서 사용되는 절차적 프로그래밍 확장 언어입니다. SQL의 데이터 조작 기능을 확장하여 프로그래밍적인 기능을 추가하고 데이터베이스 관리를 보다 유연하게 할 수 있습니다. ', 4, '10:00-12:00', '2024-02-05~2024-03-10', '월', default);
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (5, 29, 'ANSISQL로 DDL, DML 마스터하기', 'ANSI SQL은 데이터베이스 쿼리와 데이터 조작의 표준을 제공하여 데이터베이스 관리 시스템의 통일성을 높이고, 다양한 시스템 간의 호환성을 향상시킵니다.', 4, '10:00-12:00', '2024-02-13~2024-03-14', '화', default);
insert into tblStudy (caseq, pseq, sname, intro, rcount, time, day, week, file) values (6, 30, 'JavaScript로 다양한 프로그램 개발할 사람', 'JavaScript는 웹 프론트엔드 및 백엔드 개발, 웹 애플리케이션, 게임 개발, 브라우저 확장기능 등 다양한 분야에서 활용되며, 웹 기술의 핵심 요소 중 하나로 자리잡고 있습니다.', 5, '17:00-19:00', '2024-02-14~2024-03-15', '수', 'study22.png');

-- tblJjim
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (1, 2, 3);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (2, 2, 10);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (3, 3, 12);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (4, 3, 1);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (5, 8, 6);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (6, 1, 13);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (7, 1, 3);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (8, 11, 25);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (9, 4, 8);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (10, 6, 27);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (11, 14, 23);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (12, 7, 1);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (13, 11, 29);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (14, 19, 26);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (15, 9, 11);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (16, 9, 28);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (17, 20, 15);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (18, 10, 22);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (19, 6, 7);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (20, 7, 9);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (21, 12, 27);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (22, 13, 30);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (23, 17, 22);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (24, 15, 25);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (25, 14, 30);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (26, 18, 18);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (27, 5, 29);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (28, 20, 21);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (29, 10, 5);
INSERT INTO tblJjim (jseq, mseq, sseq) VALUES (30, 5, 14);

-- tblNote
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (1, 10,1, 'C언어', 'C언어의 첫 걸음 - C언어의 특징이란?', 'C언어의 특징
1) C언어는 함수 중심으로 구현되는 절차지향 언어이다. 절차지향 언어란 시간의 흐름에 따라 정해진 절차를 실행하는 언어이다.

2) C언어는 간결하고 효율적인 언어이다. 다양한 시스템 라이브러리를 제공하며, 함수의 재귀 호출까지 가능하므로 간결하게 프로그램을 작성할 수 있다. 포인터와 메모리 관리 기능이 있어 시스템의 세세한 부분까지 제어 할 수 있다는 장점까지 있다. 특히, C언어로 작성된 프로그램은 크기가 작으며, 메모리도 효율적으로 사용되 실행 속도 또한 빠르다.

3) 이식성이 좋은 언어이다. C로 작성된 소스는 운영체제에 알맞는 컴파일러만 제공된다면 별다른 수저없이 컴파일해 실행될 수 있다. 다시말해 다양한 CPU와 플랫폼의 컴파일러를 지원해 이식성이 좋다.

4) C언어는 배울 필요성이 있다고 생각한다. 자바나 C#등 많은 언어의 시작이 C언어로 부터 만들어졌고 그 영향을 끼쳤으므로 배우면 다른 언어를 접했을 때 어려움이 덜해질 것이라 보기때문이다.', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (2, 25,2, 'MongoDB', 'MongoDB의 장점에 대해 파악하', 'MongoDB의 장점
1) Document 지향 Database이다.
2) 데이터 중복이 발생할 수 있지만 접근성과 가시성, 읽기 성능이 좋다.
3) 생성, 수정, 삭제 시 각 컬렉션에 반영해야 하는 단점이 있다.
4) 스키마 설계가 어렵지만, 스키마가 유연해서 Application의 요구사항에 맞게 데이터를 수용할 수 있다.
5) HA와 Scale-Out Solution을 자체적으로 지원해서 확장이 쉽다.
6) Application에서는 Scale-out을 고려하지 않아도 된다.
7) Secondary Index를 지원한다.
8) 다양한 종류의 Index를 제공한다.
9) 응답 속도가 빠르다.', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (3, 13,3, 'Python', 'Python으로 Hello World 출력', 'print("Hello, world!") 작성 후 실행 시 Hello World가 출력된다. 파이썬 이름 짓는 규칙
파이썬 파일은 한글, 알파벳, 숫자, 특수문자 등 여러 종류의 문자를 사용해 이름지을 수 있다. 그러나 아무 문자나 사용해서 이름을 짓게 되면 나중에 문제가 생길 수 있다. 예를 들어 hypen(-)이 포함된 이름은 해당 기호가 파이썬에서 뺄셈을 나타내므로, 제대로 사용하지 못할 수 있다. 이름을 짓는 과정을 네이밍(Naming)이라 말하고, 그 규칙을 네이밍 관례(Naming Convention)이라 말한다. 다음은 파이썬 파일에 대해 공식적으로 권장되는 네이밍 관례다.
', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (4, 14,4, 'TypeScript', 'TypeScript란 무엇일까?!', 'TypeScript라는 이름답게 정적 타입을 명시할 수 있다는 것이 순수한 자바스크립트와의 가장 큰 차이점이다. 덕분에 개발 도구(IDE나 컴파일러 등)에게 개발자가 의도한 변수나 함수 등의 목적을 더욱 명확하게 전달할 수 있고, 그렇게 전달된 정보를 기반으로 코드 자동 완성이나 잘못된 변수/함수 사용에 대한 에러 알림[2] 같은 풍부한 피드백을 받을 수 있게 되므로 순수 자바스크립트에 비해 어마어마한 생산성 향상을 꾀할 수 있다. 즉, "자바스크립트를 실제로 사용하기 전에 있을만한 타입 에러들을 미리 잡는 것" 이 타입스크립트의 사용 목적이다.

개발자와 도구 간의 상호작용에서 뿐만 아니라 개발자 간의 상호작용에서도 상당한 이점이 있는데, API를 구현하고 사용함에 있어 해당 API의 인풋과 아웃풋이 무엇인지 명확하게 표현할 수 있으므로, API 하나 쓰는데에도 일일이 매뉴얼을 찾아봐야 하거나 심하면 해당 API의 코드까지 뒤적거려봐야 하는 자바스크립트에 비해 효율적이다.', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (5, 27,5, 'MySQL', 'MySQL 장점 컴온!', 'MySQL의 장점
MySQL이 가지는 장점은 다음과 같습니다.
1. 오픈 소스 라이센스를 따르기 때문에 무료로 사용할 수 있습니다.
2. 다양한 운영체제에서 사용할 수 있으며, 여러 가지의 프로그래밍 언어를 지원합니다.
3. 크기가 큰 데이터 집합도 아주 빠르고 효과적으로 처리할 수 있습니다.
4. 널리 알려진 표준 SQL 형식을 사용합니다.
5. MySQL 응용 프로그램을 사용자의 용도에 맞게 수정할 수 있습니다.', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (6, 30,6, 'Node.js', 'Node.js의 특징 파헤치기', '1. Node.js는 단일 스레드(Single-Thread)의 논 블로킹(Non-blocking I/O) 이벤트 기반 비동기 방식으로 처리되어 높은 처리 성능을 가지고 있다.
2. 내장 HTTP 서버 라이브러리를 포함하고 있어 웹 서버에서 아파치 등의 별도의 소프트웨어 없이 동작하는 것이 가능하며 이를 통해 웹 서버의 동작에 있어 더 많은 통제를 가능케 한다.
3. Javascript 언어로 Front-end 뿐만 아니라 Back-end 개발 환경을 구성할 수 있기에 생산성이 높고 러닝 커브가 줄어든다.
4. 다양한 패키지 매니저(npm: node Package Manager)를 기반으로 다양한 모듈(패키지)을 제공하며 필요 라이브러리에 대해 설치하고 사용할 수 있기에 효율성이 좋다
', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (7, 20,7, 'R', 'R이란 무엇인지 알아보자~!', 'R 개념
- 뉴질랜드 오클랜드 대학의 Robert Gentleman 와 Ross Ihaka이 1995년에 개발하였다.
- 이름이 R인 이유는 두 개발자의 이름 모두 R로 시작하기 때문이다.
- R은 데이터 분석을 위한 통계 및 그래픽스를 지원하는 자유 소프트웨어 환경이다.
- 그 뿌리는 벨 연구소에서 만들어진 통계 분석 언어 S에 근간을 두고 있다.', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (8, 1,8, 'JAVA', 'JAVA 특징 정복하자', 'Java의 특징
1. 운영체제에 독립적으로 동작
* 자바가상머신(JVM, Java Virtual Machine)을 통해 JVM이 설치되어 있는 OS에서는 모두 자바로 작성된 프로그램이 실행 가능하다.
* 자바로 작성된 프로그램을 실행 할 수 있는 가상의 컴퓨터이다.

2. 객체지향언어 (OOP, Object - Oriented Programming language)
자바는 객체지향개념의 특징인 상속, 캡슐화, 다형성이 잘 적용된 순수한 객체지향언어이다.

3. 가비지컬렉터 (GC, Garbage Collector)를 통한 자동 메모리 관리
다른 프로그래밍 언어와는 달리, 자바는 가비지 컬렉터(GC)가 자동으로 메모리를 관리하여 참조되고 있지 않은 메모리를 해제해준다.
이러한 특징으로 인해 프로그래머는 메모리 관리에 신경 쓸 필요 없이 오직 프로그래밍에만 집중 할 수 있다.

4. 네트워크, 분산처리의 지원
다양한 Java API 라이브러리들은 네트워크 및 분산처리와 관련된 기능을 쉽게 개발할 수 있도록 지원한다.
이러한 특징으로 인해 자바 언어는 대규모 분산처리 환경 등의 프로그래밍에 적합하다.

5. 멀티쓰레드의 지원
자바의 멀티쓰레드는 시스템과 관계없이 구현이 가능하며, Java API를 통해 쉽게 구현할 수 있다.

6. 동적 로딩(Dynamic Loading)의 지원
자바는 동적 로딩을 지원함으로써 프로그램 실행 시 모든 클래스가 로딩되지 않고 필요한 시점에 필요한 클래스만을 로딩하여 사용할 수 있다.', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (9, 3,9, 'CSS', '디자인은 나에게 맡겨라!', 'HTML와 같이 CSS는 실제로 프로그래밍 언어는 아닙니다. 마크업(markup) 언어 도 아닙니다. Style sheet 언어 입니다. HTML 문서에 있는 요소들에 선택적으로 스타일을 적용할 수 있다는 말입니다. 예를 들면, HTML 페이지에서 모든 문단 요소들을 선택하고 그 문단 요소들 안에 있는 텍스트를 빨갛게 바꾸려고 한다면 다음과 같이 CSS를 작성할 것입니다.

p {
  color: red;
}
', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (10, 6,10, 'JavaScript', 'JavaScrip 매력에 빠져보기', '흔히들 JavaScript는 “HTML과 CSS로 구성된 웹 페이지를 동적으로 만들어주는 언어” 라고 설명을 합니다. 이러한 JavaScript는 어떻게 탄생하게 되었을까요? JavaScript가 탄생하기 전 HTML과 CSS로만 구성이 된 웹 페이지는 보시는 것과 같습니다. 지금 우리가 사용하고 있는 구글, 유튜브와는 참 다른 모습을 띠고 있죠. 당시 웹 페이지가 이렇게 표현 될 수밖에 없었던 이유는 동적인 표현을 해낼 수 있는 언어가 없었기 때문입니다.

JavaScript의 첫 시작은 정적인 웹을 동적으로 표현하기 위함이었지만, 현재는 웹 브라우저에서만 동작하는 반쪽짜리 프로그래밍 언어가 아닌, 프론트엔드 영역은 물론 백엔드 영역까지 아우르는 웹 프로그래밍 언어의 표준으로 자리를 잡고 있습니다.', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (11, 2,11, 'HTML', 'HTML 태그 쏙쏙 파악해보기', '1. Block 태그
- Block 태그는 새로운 라인에서 시작 되며, Block 태그 다음에 오는 모든 태그들은 새 라인에서 시작 >> 행렬로 비교하면 행에 해당
- Block 태그들은 css의 속성 중 height, width, margin, padding을 적용할 수 있다.
- 예 : <p> ,<div>
2. Inline 태그
- Inline 태그들은 새라인에서 시작하지 않고 현재 라인에서 시작 >> 행렬로 비교하면 열에 해당
- Inline 태그들은 css의 속성 중 height, width, margin, padding등의 속성을 적용할 수 없다.
- 예 : <span>
3. 쌍으로 된 태그
- 태그의 시작과 끝이 따로 있어 시작과 끝 사이에 안에 코드를 넣는 태그 : <태그> 코드 </태그>
- 예 : <p> ,<div> 등..
4. 쌍이 아닌 태그
- 태그의 시작과 끝이 따로 없는 태그 : <태그/> 또는 <태그>
- 예 : <br>, <input> 등..', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (12, 7,12, 'Spring', 'Spring의 특징을 내가 정리해주지!', '1. "경량 컨테이너"(크기와 부하의 측면)로서 자바 객체를 직접 관리 - 각각의 객체 생성, 소멸과 같은 라이프 사이클을 관리하며 스프링으로부터 필요한 객체를 얻어올 수 있다.
2. 제어 역행(IoC : Inversion of Control) - 애플리케이션의 느슨한 결합을 도모. - 컨트롤의 제어권이 사용자가 아니라 프레임워크에 있어 필요에 따라 스프링에서 사용자의 코드를 호출한다. 
3. 의존성 주입(DI : Dependency Injection) - 각각의 계층이나 서비스들 간에 의존성이 존재할 경우 프레임워크가 서로 연결시켜준다.
4. 관점지향 프로그래밍(AOP : Aspect-Oriented Programming) - 트랜잭션이나 로깅, 보안과 같이 여러 모듈에서 공통적으로 사용하는 기능의 경우 해당 기능을 분리하여 관리할 수 있다. - AOP를 공부하려면 Filter, Interceptor, AOP를 비교하면서 공부하면 이해가 더 빠를 것이다.   
4. 애플리케이션 객체의 생명 주기와 설정을 포함하고 관리한다는 점에서 일종의 "컨테이너"(Container)라고 할 수 있다. - iBatis, myBatis나 Hibernate 등 완성도가 높은 데이터베이스처리 라이브러리와 연결할 수 있는 인터페이스를 제공한다. 
5. 트랜잭션 관리 프레임워크 - 추상화된 트랜잭션 관리를 지원하며 설정파일(xml, java, property 등)을 이용한 선언적인 방식 및 프로그래밍을 통한 방식을 모두 지원한다.
6. 모델-뷰-컨트롤러 패턴 - 웹 프로그램밍 개발 시 거의 표준적인 방식인 "Spring MVC"라 불리는 모델-뷰-컨트롤러(MVC) 패턴을 사용한다.  -  DispatcherServlet이 Controller 역할을 담당하여 각종 요청을 적절한 서비스에 분산시켜주며 이를 각 서비스들이 처리를 하여 결과를 생성하고 그 결과는 다양한 형식의 View 서비스들로 화면에 표시될 수 있다.', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (13, 8,13, 'Spring Boot', 'Spring Boot가 가진 장점~', '스프링 부트 장점으로는
1. 자주 사용되는 라이브러리들의 버전 관리 자동화
2. AutoConfig로 복잡한 설정 자동화
3. 내장 웹서버 제공
4. 실행 가능한 JAR로 개발 가능', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (14, 11,14, 'C++', 'C++로 Hello World 출력', '#include <iostream>
using namespace std;
 
int main() {
    cout << "Hello World!" << endl;
    return 0;
}
각 줄의 코드를 설명해보겠습니다.

1-1. 1번째 줄은 iostream이라는 헤더 파일을 불러옵니다. C++를 사용하실 때는 거의 항상 iostream 헤더 파일을 불러옵니다. C언어의 헤더 파일인 stdio.h 파일도 불러올 수 있습니다. 주의하실 점은 #include에서는 코드의 마지막에 ;를 붙이지 않습니다.
1-2. 2번째 줄은 std 네임스페이스를 사용하는 코드입니다. 이 코드가 있으면 std:: 내용을 생략할 수 있습니다.
1-3. 4번째 줄은 프로그램을 실행할 때 실행되는 함수인 main() 함수를 정의하는 것입니다. 주로 int main()으로 사용합니다.
1-4. 5번째 줄은 cout는 콘솔에다가 무언가 출력하고, << 연산자로 이어서 콘솔에다가 출력할 내용이 있고, << 연산자로 이어서 endl로 개행(줄바꿈)을 하는 코드입니다.
1-5. 6번째 줄은 main() 함수가 int 형식으로 되어 있기 때문에 프로그램이 정상적으로 종료되었다는 0을 반환해야 합니다.', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (15, 9,15, 'JSP', 'JSP의 장단점은?!', '풀네임 : Java Server Page

구현언어 : Java

오픈소스 : X

벤더 : 오라클 Oracle

프레임워크 : Spring

WAS : Tomcat

장점 : 객체지향 설계로 큰 프로젝트에서 강점을 보인다. 주축이 되는 강력한 프레임워크가 존재한다. 벤더가 거대 기업이고, 한국에서 굉장히 많이 쓰이고 있다.

단점 : 각종 모듈을 설치해야 해서 가벼운 프로젝트에 어울리지 않고, 프레임워크를 잘 사용하지 않으면 개발이 힘들 수 있다. 또한 2019년 부터 기업사용자는 비용이 발생한다는 공식적인 발표가 있다.', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (16, 28,16, 'Oracle', 'Oracle 자료형', '1. 문자형:
1-1. 고정형: char(10): 10byte이하의 데이터를 입력하고, 크기는 무조건 10byte 취급. 단! 유일하게 oracle xe버전에서는 한글을 글자당 3byte 취급한다. (본래 2byte)* 최대 2천 byte까지
1-2: 가변형: varchar2(10): 10byte이하, 취급 크기는 실제 입력된 데이터 크기와 동일. 최대 4천 byte까지. long의 경우 최대 2gb, clob의 경우 최대 4gb까지.
2. 숫자형: number(표현 가능한 전체 자릿수(p), 소숫점 이하 자릿수(s)) p: precision, scale. 단, s를 음수로 처리하는 경우 소숫점 n자릿수 이상으로 반올림처리. 즉, s를 입력하지 않고 number(p)로 선언하는 경우 소숫점을 허용하지 않는다.
3. 날짜형: 년/월/일 시/분/초. 1 단위의 산술 연산이 가능. ex. 날짜 +- 숫자 = 날짜. 날짜 - 날짜 = 숫자.
TimeStamp: 년/월/일/시/분/초/millisecond
sysdate: 현재 시각 정보를 가져오는 키워드
', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (17, 29,17, 'MariaDB', 'MariaDB의 개념을 내것으로 만들기', 'MariaDB는 무료 오픈소스 관계형 데이터베이스 관리 시스템(RDBMS)입니다. 2009년 Oracle에 인수된 MySQL이 상용화될 것이라는 우려 속에, MySQL의 원래 개발자들이 만든 것입니다.

MariaDB는 C 및 C++로 작성되었으며 C, C#, Java, Python, PHP, Perl 등 여러 프로그래밍 언어를 지원합니다. MariaDB는 또한 Windows, Linux 및 macOS를 포함한 모든 주요 운영 체제를 지원합니다.

관계형 데이터베이스이지만, MariaDB 버전 10부터 NoSQL(비구조화 쿼리 언어)과 유사한 기능을 제공합니다. Connect 엔진을 사용하면 MariaDB 내의 비정형 데이터에 쉽게 액세스할 수 있으며, 동적 열은 동일한 행에 있는 다양한 유형의 객체를 NoSQL 유형으로 저장할 수 있게 해줍니다.', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (18, 15,18, 'PHP', 'PHP란 무엇일까?', 'PHP의 특성을 알기 위해서는 이 언어가 어디에 주로 쓰이는지 먼저 알아야겠죠? PHP는 ‘Personal Home PagE Tools’의 약자로 웹사이트 제작에 특화된 백엔드(서버) 언어입니다. 웹사이트란 우리가 흔히 접하는 쇼핑몰 사이트를 생각하시면 됩니다. 쇼핑몰 사이트에 들어가면 주문을 하기 위해 보통 회원가입을 제일 먼저 하게 되죠.

PHP는 웹사이트에 회원가입을 할 때 아이디 검사, 주소 검색, 비밀번호 유효성 검사 등의 행위를 실행하도록 만들어주는 역할을 합니다. 조금 더 자세히 설명드리자면 동적인 웹페이지를 만들기 위해 설계가 된 언어입니다. 서버에 있는 스크립트에 의해 가공 처리되어 생성된 데이터들을 사용자의 웹페이지로 전달하여 화면에 보여주기 때문에 필요한 단계에 따라 서버 언어를 활용하여 달라진 웹페이지가 구현되도록 소스를 제공받게 되는 것입니다.

그래서 정적으로 미리 저장된 파일이 그대로 전달되어 구현된 HTML의 코드 내부 안에 동적인 기능이 구현 가능한 PHP 코드를 넣어 웹페이지의 기능들을 실행할 수 있습니다. 물론 이 두 가지만으로는 사이트를 운영할 수는 없지만 웹 사이트의 기본적인 틀은 만들 수 있다고 보시면 됩니다. ', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (19, 4,19, 'PLSQL', 'PLSQL을 알아보자!', '1. PL/SQL(Procedural Language extension to SQL)이란?

1-1. SQL을 확장한 절차적 언어.
1-2. 여러 SQL을 하나의 블록(Block)으로 구성하여 SQL을 제어할 수 있음.
	- Commit, Rollback, 예외처리 등.
1-3. 조건문(IF), 반복문(LOOP)을 사용하여 유연한 프로그래밍이 가능함.
1-4. 커서(Cursor)를 사용하여 대용량 데이터를 처리할 때, 데이터를 분할하여 처리할 수 있음.
1-5. 동적 SQL를 통하여 문자열로 작성된 SQL을 실행할 수 있으며, DML, DDL, DCL을 사용할 수 있음.', default, default);
INSERT INTO tblNote (nseq, caseq, mseq, ntitle, stitle, scontent, nlike, ncheck) VALUES (20, 26,20, 'NoSQL', 'NoSQL 개념 파악하기', 'NoSQL 데이터베이스란?

NoSQL 데이터베이스는 특정 데이터 모델에 대해 특정 목적에 맞추어 구축되는 데이터베이스로서 현대적인 애플리케이션 구축을 위한 유연한 스키마를 갖추고 있습니다. NoSQL 데이터베이스는 개발의 용이성, 기능성 및 확장성을 널리 인정받고 있습니다. 이 페이지에는 NoSQL 데이터베이스를 보다 잘 이해하고 효과적으로 시작할 수 있도록 지원할 리소스가 포함되어 있습니다.', default, default);

-- tblLike
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (1, 9, 3);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (2, 2, 4);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (3, 5, 2);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (4, 18, 15);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (5, 15, 11);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (6, 3, 1);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (7, 5, 10);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (8, 3, 9);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (9, 8, 13);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (10, 11, 18);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (11, 12, 1);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (12, 19, 20);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (13, 17, 7);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (14, 18, 5);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (15, 1, 8);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (16, 3, 4);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (17, 4, 11);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (18, 1, 10);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (19, 2, 6);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (20, 13, 19);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (21, 11, 2);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (22, 13, 10);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (23, 18, 8);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (24, 16, 4);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (25, 9, 16);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (26, 7, 10);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (27, 1, 14);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (28, 20, 2);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (29, 19, 17);
INSERT INTO tblLike (lseq, mseq, nseq) VALUES (30, 3, 9);

-- tblApply
insert into tblApply (sseq, mseq, lv) values (1, 1, 1);
insert into tblApply (sseq, mseq, lv) values (1, 2, 2);
insert into tblApply (sseq, mseq, lv) values (1, 3, 2);
insert into tblApply (sseq, mseq, lv) values (1, 4, 2);
insert into tblApply (sseq, mseq, lv) values (1, 5, 2);
insert into tblApply (sseq, mseq, lv) values (2, 6, 1);
insert into tblApply (sseq, mseq, lv) values (2, 7, 2);
insert into tblApply (sseq, mseq, lv) values (2, 8, 2);
insert into tblApply (sseq, mseq, lv) values (3, 12, 1);
insert into tblApply (sseq, mseq, lv) values (3, 13, 2);
insert into tblApply (sseq, mseq, lv) values (4, 15, 1);
insert into tblApply (sseq, mseq, lv) values (4, 16, 2);
insert into tblApply (sseq, mseq, lv) values (4, 17, 2);
insert into tblApply (sseq, mseq, lv) values (5, 20, 1);
insert into tblApply (sseq, mseq, lv) values (5, 1, 2);
insert into tblApply (sseq, mseq, lv) values (5, 3, 2);
insert into tblApply (sseq, mseq, lv) values (6, 4, 1);
insert into tblApply (sseq, mseq, lv) values (6, 5, 2);
insert into tblApply (sseq, mseq, lv) values (6, 6, 2);
insert into tblApply (sseq, mseq, lv) values (7, 10, 1);
insert into tblApply (sseq, mseq, lv) values (7, 11, 2);
insert into tblApply (sseq, mseq, lv) values (7, 12, 2);
insert into tblApply (sseq, mseq, lv) values (7, 13, 2);
insert into tblApply (sseq, mseq, lv) values (7, 14, 2);
insert into tblApply (sseq, mseq, lv) values (7, 15, 2);
insert into tblApply (sseq, mseq, lv) values (8, 16, 1);
insert into tblApply (sseq, mseq, lv) values (8, 17, 2);
insert into tblApply (sseq, mseq, lv) values (8, 18, 2);
insert into tblApply (sseq, mseq, lv) values (8, 19, 2);
insert into tblApply (sseq, mseq, lv) values (8, 20, 2);
insert into tblApply (sseq, mseq, lv) values (9, 2, 1);
insert into tblApply (sseq, mseq, lv) values (9, 3, 2);
insert into tblApply (sseq, mseq, lv) values (9, 5, 2);
insert into tblApply (sseq, mseq, lv) values (10, 6, 1);
insert into tblApply (sseq, mseq, lv) values (10, 8, 2);
insert into tblApply (sseq, mseq, lv) values (11, 13, 1);
insert into tblApply (sseq, mseq, lv) values (12, 3, 1);
insert into tblApply (sseq, mseq, lv) values (13, 9, 1);
insert into tblApply (sseq, mseq, lv) values (14, 10, 1);
insert into tblApply (sseq, mseq, lv) values (15, 11, 1);
insert into tblApply (sseq, mseq, lv) values (16, 14, 1);
insert into tblApply (sseq, mseq, lv) values (17, 19, 1);
insert into tblApply (sseq, mseq, lv) values (18, 8, 1);
insert into tblApply (sseq, mseq, lv) values (19, 12, 1);
insert into tblApply (sseq, mseq, lv) values (20, 4, 1);

-- tblAttend
insert into tblAttend (aseq, day, aactive) values (11, '2023-12-11', default);
insert into tblAttend (aseq, day, aactive) values (12, '2023-12-11', default);
insert into tblAttend (aseq, day, aactive) values (13, '2023-12-11', default);
insert into tblAttend (aseq, day, aactive) values (9, '2023-12-12', default);
insert into tblAttend (aseq, day, aactive) values (10, '2023-12-12', default);
insert into tblAttend (aseq, day, aactive) values (14, '2023-12-13', default);
insert into tblAttend (aseq, day, aactive) values (15, '2023-12-13', default);
insert into tblAttend (aseq, day, aactive) values (16, '2023-12-13', default);
insert into tblAttend (aseq, day, aactive) values (6, '2023-12-14', default);
insert into tblAttend (aseq, day, aactive) values (7, '2023-12-14', default);
insert into tblAttend (aseq, day, aactive) values (8, '2023-12-14', default);
insert into tblAttend (aseq, day, aactive) values (1, '2023-12-15', default);
insert into tblAttend (aseq, day, aactive) values (2, '2023-12-15', default);
insert into tblAttend (aseq, day, aactive) values (3, '2023-12-15', default);
insert into tblAttend (aseq, day, aactive) values (4, '2023-12-15', default);
insert into tblAttend (aseq, day, aactive) values (5, '2023-12-15', default);



select * from tblMember;
select * from tblCommunity;
select * from tblComment;
select * from tblCategory;
select * from tblPlace;
select * from tblStudy;
select * from tblJjim;
select * from tblNote;
select * from tblLike;
select * from tblApply;
select * from tblAttend;


select id from tblMember where name = '김설화' and tel ='010-6289-0859';

commit;



