# Use the appropriate base image for ASP.NET Core
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

WORKDIR /src

# Copy the project files into the container
COPY . .

# Navigate to the directory containing the project file
WORKDIR /src/Eol

# Publish the application
RUN dotnet publish -c Release -o /app/publish

# Use the appropriate base image for ASP.NET Core runtime
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final

WORKDIR /app

# Copy the published files into the container
COPY --from=build /app/publish .

# Set the entry point for the application
ENTRYPOINT ["dotnet", "Eol.dll"]