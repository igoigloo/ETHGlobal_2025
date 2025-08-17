# Scaffold-ETH 2 Troubleshooting Guide

This guide covers common issues encountered during Scaffold-ETH 2 setup and development, along with their solutions.

## Build and Module Resolution Errors

### 1. Pino Module Error

**Error Message:**
```
Module not found: Can't resolve 'pino'
```

**Root Cause:**
The `pino` logging library is a Node.js-only module that cannot run in browser environments. Some blockchain-related dependencies attempt to use it.

**Solution:**
The `next.config.ts` file has been configured to handle this by:
- Adding `pino` and `pino-pretty` to webpack externals
- Setting up webpack aliases to disable these modules in browser environments
- Providing fallbacks for Node.js-specific modules

**Configuration Added:**
```typescript
webpack: config => {
  config.resolve.fallback = { 
    fs: false, net: false, tls: false, crypto: false,
    stream: false, url: false, zlib: false, http: false,
    https: false, assert: false, os: false, path: false,
    util: false, buffer: false
  };
  
  config.externals.push("pino-pretty", "pino", "lokijs", "encoding");
  
  config.resolve.alias = {
    ...config.resolve.alias,
    'pino': false,
    'pino-pretty': false,
    'node-gyp-build': false,
    'bufferutil': false,
    'utf-8-validate': false
  };
  
  config.ignoreWarnings = [
    { module: /node_modules\/bufferutil/ },
    { module: /node_modules\/utf-8-validate/ },
  ];
  
  return config;
}
```

### 2. QR Code Module Error

**Error Message:**
```
Module not found: Can't resolve 'qrcode'
Did you mean './qrcode'?
```

**Root Cause:**
The `@reown/appkit-ui` package expects the `qrcode` library to be available but it's not included as a dependency.

**Solution:**
Install the missing `qrcode` package and its TypeScript types:

```bash
# From project root
yarn add qrcode @types/qrcode

# Or specifically in the nextjs workspace
cd packages/nextjs
yarn add qrcode @types/qrcode
```

### 3. Native Module Warnings (bufferutil, utf-8-validate)

**Warning Messages:**
```
Module not found: Can't resolve 'node-gyp-build' in '.../bufferutil'
Module not found: Can't resolve 'node-gyp-build' in '.../utf-8-validate'
```

**Root Cause:**
These are optional native modules for WebSocket performance optimization. They require native compilation which often fails on Windows or in certain environments.

**Impact:**
- These warnings are **non-critical**
- WebSocket functionality falls back to JavaScript implementations
- No functional impact on your dApp

**Solution:**
The warnings are suppressed in the webpack configuration. No action needed, but if you want to resolve them completely:

1. Install build tools (Windows):
   ```bash
   npm install -g windows-build-tools
   ```

2. Or suppress warnings (already configured):
   ```typescript
   config.ignoreWarnings = [
     { module: /node_modules\/bufferutil/ },
     { module: /node_modules\/utf-8-validate/ },
   ];
   ```

## Cache and Build Issues

### Clearing Next.js Cache

When encountering persistent build issues, clear the Next.js cache:

**Windows PowerShell:**
```powershell
cd packages/nextjs
Remove-Item .next -Recurse -Force -ErrorAction SilentlyContinue
cd ../..
yarn start
```

**Linux/macOS:**
```bash
cd packages/nextjs
rm -rf .next
cd ../..
yarn start
```

### Complete Clean Rebuild

For stubborn issues, perform a complete clean rebuild:

```bash
# Remove all node_modules and cache
rm -rf node_modules
rm -rf packages/*/node_modules
rm -rf packages/*/.next
rm -rf yarn.lock

# Reinstall everything
yarn install

# Regenerate burner wallet if needed
yarn generate

# Restart development environment
yarn chain    # Terminal 1
yarn deploy   # Terminal 2
yarn start    # Terminal 3
```

## Windows-Specific Issues

### PowerShell Command Separator

**Issue:** Using `&&` in PowerShell commands fails
```powershell
# ❌ This fails in PowerShell
cd path && yarn start

# ✅ Use semicolon instead
cd path ; yarn start
```

### Node.js Version Compatibility

Ensure you're using Node.js >= v20.18.3:
```bash
node --version
```

If you need to upgrade:
1. Download from [nodejs.org](https://nodejs.org/)
2. Or use a version manager like `nvm` or `fnm`

## Development Environment Setup

### Recommended Terminal Setup

For optimal development experience, use three separate terminals:

**Terminal 1 - Blockchain:**
```bash
cd scaffold-eth-2
yarn chain
```

**Terminal 2 - Contract Deployment:**
```bash
cd scaffold-eth-2
yarn deploy
```

**Terminal 3 - Frontend:**
```bash
cd scaffold-eth-2
yarn start
```

### Port Conflicts

If you encounter port conflicts:

- **Port 8545 (Hardhat):** Stop other blockchain clients or change port in `hardhat.config.ts`
- **Port 3000 (Next.js):** Next.js will automatically try port 3001, 3002, etc.

## Advanced Troubleshooting

### Enable Verbose Logging

For detailed error information:

```bash
# Enable webpack verbose logging
WEBPACK_VERBOSE=true yarn start

# Enable Next.js debug mode
DEBUG=* yarn start
```

### Check Dependency Conflicts

```bash
# Check for dependency issues
yarn install --check-files

# Audit for vulnerabilities
yarn audit
```

### TypeScript Issues

```bash
# Type check without building
yarn check-types

# Clear TypeScript cache
rm -rf .next
rm -rf tsconfig.tsbuildinfo
```

## Getting Help

If you continue to experience issues:

1. Check the [Scaffold-ETH 2 documentation](https://docs.scaffoldeth.io)
2. Search existing [GitHub issues](https://github.com/scaffold-eth/scaffold-eth-2/issues)
3. Join the [Scaffold-ETH Discord](https://discord.gg/scaffoldeth)
4. Create a new issue with:
   - Operating system and version
   - Node.js version
   - Complete error messages
   - Steps to reproduce

## Environment Information

To help with debugging, collect this information:

```bash
# System info
node --version
yarn --version
npx next --version

# Package info
cat package.json | grep version

# Dependency tree (if needed)
yarn list --depth=0
```
