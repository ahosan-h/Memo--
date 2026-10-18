#!/bin/bash

set -e

echo "Installing NestJS CLI..."
npm install -g @nestjs/cli

echo "Creating NestJS project..."
nest new . --skip-git --package-manager npm

echo "Installing configuration and validation..."
npm install @nestjs/config class-validator class-transformer

echo "Installing Prisma..."
npm install -D prisma@latest
npm install @prisma/client@latest @prisma/adapter-pg@latest pg dotenv

echo "Installing PostgreSQL TypeScript definitions..."
npm install -D @types/pg

echo "Initializing Prisma..."
npx prisma init

echo "Installing Passport authentication dependencies..."
npm install @nestjs/passport passport passport-jwt
npm install passport-google-oauth20 passport-facebook

echo "Installing JWT and cookie dependencies..."
npm install @nestjs/jwt cookie-parser

echo "Installing TypeScript definitions..."
npm install -D @types/passport-jwt
npm install -D @types/passport-google-oauth20
npm install -D @types/passport-facebook
npm install -D @types/cookie-parser

echo "Installing complete!"

echo "Next steps:"
echo "1. Configure your .env file"
echo "2. Configure your Prisma schema and configuration"
echo "3. Create your PrismaService with PostgreSQL connection pooling"
echo "4. Implement Google and Facebook authentication"
echo "5. Test the authentication flow"