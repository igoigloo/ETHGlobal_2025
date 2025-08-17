import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  reactStrictMode: true,
  devIndicators: false,
  typescript: {
    ignoreBuildErrors: process.env.NEXT_PUBLIC_IGNORE_BUILD_ERROR === "true",
  },
  eslint: {
    ignoreDuringBuilds: process.env.NEXT_PUBLIC_IGNORE_BUILD_ERROR === "true",
  },
  webpack: config => {
    // Essential fallbacks for Node.js modules that don't work in browser environment
    config.resolve.fallback = { 
      fs: false, 
      net: false, 
      tls: false,
      crypto: false,
      stream: false,
      url: false,
      zlib: false,
      http: false,
      https: false,
      assert: false,
      os: false,
      path: false,
      util: false,
      buffer: false
    };
    
    // Exclude problematic Node.js-only modules from browser bundle
    config.externals.push("pino-pretty", "pino", "lokijs", "encoding");
    
    // Handle pino and native modules for browser environment
    config.resolve.alias = {
      ...config.resolve.alias,
      'pino': false,
      'pino-pretty': false,
      'node-gyp-build': false,
      'bufferutil': false,
      'utf-8-validate': false
    };
    
    // Suppress non-critical warnings for native modules
    config.ignoreWarnings = [
      { module: /node_modules\/bufferutil/ },
      { module: /node_modules\/utf-8-validate/ },
    ];
    
    return config;
  },
};

const isIpfs = process.env.NEXT_PUBLIC_IPFS_BUILD === "true";

if (isIpfs) {
  nextConfig.output = "export";
  nextConfig.trailingSlash = true;
  nextConfig.images = {
    unoptimized: true,
  };
}

module.exports = nextConfig;
