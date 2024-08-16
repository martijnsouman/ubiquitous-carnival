FROM mcr.microsoft.com/dotnet/sdk:8.0-jammy AS build
WORKDIR /src
COPY MyApp .
RUN dotnet restore 
FROM build as publish
RUN dotnet publish --sc -o /app

FROM mcr.microsoft.com/dotnet/runtime:8.0-jammy-chiseled AS runtime
WORKDIR /app

COPY --from=publish /app /app

ENTRYPOINT ["dotnet", "MyApp.dll"]
