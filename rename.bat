@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
COLOR 0A
TITLE zyr batch rename tool
ECHO.
ECHO =================================
ECHO     ��ӭʹ��zyr������������
ECHO =================================
ECHO.
:START
SET /P filePath="��������Ҫ�滻��Դ·���ļ���(��Ҫ��������ͬĿ¼��): "
ECHO.
ECHO ��ѡ��Ҫ�����޸ĵĴ����ĺ�׺����
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
SET /P suffix="������Ҫ���������ĺ�׺��: "
)
ECHO.
SET /P oldStr="��������Ҫ���滻������: "
SET /P newStr="��������Ҫ�滻������: "
ECHO.
ECHO �޸�ing...
ECHO.
SET /a index=0
FOR /r %filePath% %%i in (*.!suffix!) do (
    SET /a index=!index!+1
    ECHO �滻��!index!���ļ�%%i��ʼ
    SET fileName=%%~ni
    SET fileSuffix=%%~xi
    SET fileName=!fileName:%oldStr%=%newStr%!!fileSuffix!
    REN %%i !fileName!
    ECHO �滻��!index!���ļ�����%%i���滻Ϊ!fileName!
)
IF %ERRORlEVEL% equ 0 (
    ECHO �޸ĳɹ�!
) ELSE (
    ECHO �޸�ʧ��!
)
ECHO.
PAUSE
goto START