@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
COLOR 0A
TITLE zyr batch ReplaceContent tool
ECHO.
ECHO =================================
ECHO     ��ӭʹ��zyr�����滻�ļ����ݹ���
ECHO =================================
ECHO.
:START
SET /P filePath="��������Ҫ�滻��Դ·���ļ���(��Ҫ��������ͬĿ¼��): "
ECHO.
ECHO ��ѡ��Ҫ�����޸ĵĴ���ĺ�׺����
ECHO.
ECHO 1. �����ļ�(ֻ���޸��ļ���)
ECHO 2. java
ECHO 3. txt
ECHO 4. png
ECHO 5. ����,���Լ�������
ECHO.
CHOICE /C 12345 /m "���ѡ����: "
IF %ERRORlEVEL% equ 1 SET suffix=*
IF %ERRORlEVEL% equ 2 SET suffix=java
IF %ERRORlEVEL% equ 3 SET suffix=txt
IF %ERRORlEVEL% equ 4 SET suffix=png
IF %ERRORlEVEL% equ 5 (
    ECHO.
    SET /P suffix="������Ҫ��������ĺ�׺��: "
)
ECHO.
SET /P oldStr="��������Ҫ���滻������: "
SET /P newStr="��������Ҫ�滻������: "
ECHO.
ECHO �޸�ing...
SET /a index=0
FOR /r %filePath% %%i in (*.!suffix!) do (
    SET fileFullName=%%i
    (for /f "tokens=1* delims=:" %%a in ('findstr /n ".*" !fileFullName!') do (
        SET str=%%b
        IF "!str!" neq "" (
            ECHO !str!|findstr !oldStr!>nul 2>nul&&(
                SET str=!str:%oldStr%=%newStr%!
            )
        )
        echo,!str!
    ))>!fileFullName!.tmp
    move !fileFullName!.tmp !fileFullName!>nul 2>nul
)
ECHO.
PAUSE
goto START