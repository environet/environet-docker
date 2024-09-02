@ECHO OFF
TITLE Install Environet

rem variables from cli script
SET mode=%1
SET composeParam=%2
SET arg3=%3
SET arg4=%4

rem get the env file location
SET envFile="%cd%\.env"

rem if not exists, abort
IF NOT EXIST %envFile% (
	ECHO Error: .env file doesn't exist. You have to create one, based on the .env.example file
)

rem get the database connection credentials from .env file
FOR /F "tokens=1,2 delims==" %%a IN (%envFile%) DO (
	IF /I "%%a"=="POSTGRES_USER" (
		SET "postgresUser=%%b"
	)
	IF /I "%%a"=="POSTGRES_PASSWORD" (
		SET "postgresPassword=%%b"
	)
	IF /I "%%a"=="POSTGRES_DB" (
		SET "postgresDb=%%b"
	)
)

IF /I "%mode%"=="data" (
	SET "COMPOSE_FILE=./docker/docker-compose.data.yml"
	SET "SERVICE_NAME=data_php"
)
IF /I "%mode%"=="dist" (
	SET "COMPOSE_FILE=./docker/docker-compose.distribution.yml"
	SET "SERVICE_NAME=dist_php"
)
IF /I "%mode%"=="doc" (
	SET "COMPOSE_FILE=./docker/docker-compose.documentation.yml"
	SET "SERVICE_NAME=doc_php"
)
IF "%COMPOSE_FILE%"=="" (
	ECHO Invalid cli arguments.
	goto :eof
)

IF "%postgresUser%"=="" (
	IF /I "%mode%" NEQ "data" (
		ECHO Invalid .env file. Missing database username.
		SET ERROR=1
	)
)
IF "%postgresPassword%"=="" (
	IF /I "%mode%" NEQ "data" (
		ECHO Invalid .env file. Missing database password.
		SET ERROR=1
	)
)
IF "%postgresDb%"=="" (
	IF /I "%mode%" NEQ "data" (
		ECHO Invalid .env file. Missing database name.
		SET ERROR=1
	)
)
IF NOT "%ERROR%"=="" (
	goto :eof
)

SET "CURRENT_UID=root:root"

IF /I "%composeParam%"=="up" (
	docker compose --env-file %envFile% -p environet -f %COMPOSE_FILE% up -d
	goto :eof
)
IF /I "%composeParam%"=="down" (
	docker compose --env-file %envFile% -p environet -f %COMPOSE_FILE% down
	goto :eof
)
IF /I "%composeParam%"=="build" (
	docker compose --env-file %envFile% -p environet -f %COMPOSE_FILE% build
	goto :eof
)
IF /I "%composeParam%"=="stop" (
	docker compose --env-file %envFile% -p environet -f %COMPOSE_FILE% stop
	goto :eof
)

docker compose --env-file %envFile% -p environet -f %COMPOSE_FILE% up -d

IF /I "%composeParam%"=="generate-merged-html" (
	docker compose --env-file %envFile% -p environet -f %COMPOSE_FILE% exec dist_php php /var/www/html/doc/generate_merged_html.php
	goto :eof
)
IF /I "%composeParam%"=="bash" (
	docker compose --env-file %envFile% -p environet -f %COMPOSE_FILE% exec %SERVICE_NAME% bash
	goto :eof
)

docker compose --env-file %envFile% -p environet -f %COMPOSE_FILE% exec -T %SERVICE_NAME% bash -c "/var/www/html/bin/environet %mode% %composeParam% %arg3% %arg4%"