#!/bin/bash

# Scaffold-ETH 2 Setup Script
# This script automates the setup process and handles common issues

echo "🏗 Setting up Scaffold-ETH 2..."

# Check Node.js version
echo "📋 Checking Node.js version..."
node_version=$(node --version | cut -d'v' -f2)
required_version="20.18.3"

if [ "$(printf '%s\n' "$required_version" "$node_version" | sort -V | head -n1)" != "$required_version" ]; then
    echo "❌ Node.js version $node_version is below required version $required_version"
    echo "Please upgrade Node.js: https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js version $node_version is compatible"

# Install dependencies
echo "📦 Installing dependencies..."
yarn install
if [ $? -ne 0 ]; then
    echo "❌ Failed to install dependencies"
    exit 1
fi

# Install additional packages that might be missing
echo "📦 Installing additional packages..."
cd packages/nextjs
yarn add qrcode @types/qrcode
cd ../..

# Generate burner wallet
echo "👛 Generating burner wallet..."
yarn generate
if [ $? -ne 0 ]; then
    echo "❌ Failed to generate burner wallet"
    exit 1
fi

# Clear any existing build cache
echo "🧹 Clearing build cache..."
rm -rf packages/nextjs/.next

echo "✅ Setup complete!"
echo ""
echo "🚀 Next steps:"
echo "1. Start blockchain:    yarn chain     (in terminal 1)"
echo "2. Deploy contracts:    yarn deploy    (in terminal 2)" 
echo "3. Start frontend:      yarn start     (in terminal 3)"
echo ""
echo "📖 Visit http://localhost:3000 when all services are running"
echo "🔧 For troubleshooting, see TROUBLESHOOTING.md"
