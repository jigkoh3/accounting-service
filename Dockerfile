FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as build
WORKDIR /app
COPY *.sln .
COPY <PROJECT_1_FOLDER>/*.csproj ./<PROJECT_1_FOLDER>/
COPY <PROJECT_2_FOLDER>/*.csproj ./<PROJECT_2_FOLDER>/
COPY ./<PROJECT_3_FOLDER>/*.csproj ./<PROJECT_3_FOLDER>/
RUN dotnet restore
COPY <PROJECT_1_FOLDER>/. ./<PROJECT_1_FOLDER>/
COPY <PROJECT_2_FOLDER>/. ./<PROJECT_2_FOLDER>/
COPY <PROJECT_3_FOLDER>/. ./<PROJECT_3_FOLDER>/
WORKDIR /app
RUN dotnet publish -c Release -o out
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS runtime
COPY --from=build /app/out ./
CMD ASPNETCORE_URLS=http://*:$PORT dotnet <NAME_OF_THE_PROJECT_YOU_WILL_RUN>.dll
